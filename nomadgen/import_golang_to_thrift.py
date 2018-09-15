import re
import requests
import logging
import sys
logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)

STRUCT_REGEX=re.compile('^type (?P<struct_name>[^\ ]*) struct {$')
COMMENT_REGEX=re.compile('^([^//]*)//.*')
FIELD_REGEX=re.compile('^\s+(?P<field_name>[^\ ]*)\s+(?P<field_type>[^\ ]*)(\s+`mapstructure:\"(?P<ms_field_name>[^\"]*)\"`)?')
END_OF_STRUCT=re.compile('^}$')

# Used when golang defines alias for types
# TODO: Figure translations automatically from files
TR_TYPES={
    'Networks': '[]NetworkResource',
    'Artifacts': '[]TaskArtifact',
    'DiffType': 'string',
}

# "args" and "class" are reserved names in thrift.
TR_NAMES={
    'args': 'command_args',
    'class': 'java_class',
}
driver_config_struct = {'DriverConfig':{}}


class StructParser(object):
    all_structs={}
    current_struct=None
    DOWNLOAD_PREFIX='https://raw.githubusercontent.com/hashicorp/nomad/'
    def __init__(self, version, file_paths=[], start_keys=[]):
        self.version=version
        self.file_paths=file_paths
        self.start_keys=start_keys
        for file in file_paths:
            self.parse_file(file)
        pass

    def download_file(self, file):
        return requests.get(self.DOWNLOAD_PREFIX + self.version + file)

    def parse_file(self, file):
        for line in self.download_file(file).text.splitlines():
            is_comment = COMMENT_REGEX.match(line)
            if is_comment:
                line = is_comment.group(1)

            struct_def = STRUCT_REGEX.match(line)
            if struct_def:
                self.current_struct=struct_def.group('struct_name')
                self.all_structs[self.current_struct]={}

            if self.current_struct:

                # golang can have structs nested into other struct
                # TODO: Find a better way to handle nested structs
                if "WriteMeta" in line:
                    self.all_structs[self.current_struct].update(self.all_structs.get('WriteMeta'))
                if "QueryMeta" in line:
                    self.all_structs[self.current_struct].update(self.all_structs.get('QueryMeta'))

                field_def = FIELD_REGEX.match(line)
                if field_def:
                    value =  TR_TYPES.get(field_def.group('field_type').strip(), field_def.group('field_type').strip())
                    key = TR_NAMES.get(field_def.group('ms_field_name'), field_def.group('ms_field_name'))
                    if not key:
                        key = field_def.group('field_name')
                    self.all_structs[self.current_struct][ key ] = value

                    # DriverConfigs are being set for each driver separatly but
                    # thrift only accept one type of struct as value.
                    if self.current_struct.endswith('DriverConfig'):
                        driver_config_struct['DriverConfig'][key] = value

            is_eos = END_OF_STRUCT.match(line)
            if is_eos:
                self.current_struct=None

    def get_struct_powers(self):
        # This will help resolve dependencies between structs
        my = dict()
        for start_key in self.start_keys:
            my.update(DepRes(start_key, self.all_structs).track_dict)
        return my

    def print_all(self):
        tracker = set()
        for key, val in sorted(self.get_struct_powers().items(), key=lambda i: i[1], reverse=True):
            logging.debug("Printing %s power is %s" % (key, val))
            if (key not in tracker) and (key in self.all_structs.keys()):
                print(print_struct(key, self.all_structs.get(key, {})))
                tracker.add(key)


class DepRes(object):
    def __init__(self, start_key, data, tr={}):
        self.data = data
        self.myset = list()
        self.track_dict = dict()
        self.counter=1
        self.tr=tr
        self.dep(start_key, 1)

    def get_tree(self):
        ret = sorted(self.track_dict.items(), key=lambda i: i[1], reverse=False)
        return ret

    def dep(self, key, counter):
        logging.debug("adding: %s" % key)
        self.myset.append(key)
        self.track_dict[key] = self.track_dict.get(key, counter) + counter
        for _key in self.data.get(key, {}).values():
            _key = _key.replace('[]', '')
            _key = _key.replace('map[string]', '')
            _key = _key.replace('*', '')
            if _key in self.track_dict.keys():
                self.track_dict[_key] = self.track_dict.get(_key, counter) + counter
            else:
                self.dep(_key, self.track_dict.get(key) + counter)


def print_struct(name, obj):
    arr=[]
    index=1
    arr.append('struct %s {' % name)
    set_fix_old_new=False
    for field_name, field_type in obj.iteritems():
        if field_name == '-':
            continue

        # Some structs define Old and New fields in the same line
        # https://github.com/hashicorp/nomad/blob/v0.8.3/nomad/structs/diff.go#L1034
        if (field_name == 'Old,') and (field_type == 'New'):
            set_fix_old_new=True
            continue
        arr.append('  %d: optional %s %s' % (
            index,
            normalize_field_type(field_type),
            field_name
        ))
        index += 1
    if set_fix_old_new:
        arr.append('  %d: optional %s %s' % (index, 'string', 'New'))
        index += 1
        arr.append('  %d: optional %s %s' % (index, 'string', 'Old'))

    arr.append('}')
    return "\n".join(arr)

LIST_RE=re.compile('\[\](?P<type>.*)')
MAP_RE=re.compile('map\[(?P<k_type>[^\]]*)\](?P<v_type>.*)')
def normalize_field_type(field_type):

    # DriverConfig is a special case
    if field_type == 'map[string]interface{}':
        return 'DriverConfig'

    list_re = LIST_RE.match(field_type)
    if list_re:
        return 'list<%s>' % normalize_field_type(list_re.group('type'))
    map_re = MAP_RE.match(field_type)
    if map_re:
        return 'map<%s,%s>' % (
            normalize_field_type(map_re.group('k_type')),
            normalize_field_type(map_re.group('v_type'))
        )

    field_type = field_type.replace('*', '')
    if field_type == 'int':
        return 'i16'
    if field_type.endswith('int64'):
        return 'i64'
    if field_type =='[]byte':
        return 'string'
    if field_type.startswith('float'):
        return 'double'
    if field_type.startswith('time.Time'):
        return 'string'
    if field_type.startswith('time.'):
        return 'i64'
    return field_type


if __name__ == "__main__":
    StructParser(
        version='v0.8.3',
        file_paths=[
            '/client/driver/docker.go',
            '/client/driver/exec.go',
            '/client/driver/qemu.go',
            '/client/driver/java.go',
            '/client/driver/rkt.go',
        ],
        start_keys=[
            'DockerDriverConfig',
            'ExecDriverConfig',
            'QemuDriverConfig',
            'JavaDriverConfig',
            'RktDriverConfig',
        ]).print_all()
    print(print_struct('DriverConfig', driver_config_struct['DriverConfig']))
    StructParser(
        version='v0.8.3',
        file_paths=[
            '/nomad/structs/structs.go',
            '/nomad/structs/diff.go',
        ],
        start_keys=[
            'QueryMeta',
            'WriteMeta',
            'DeploymentListResponse',
            'DeploymentPromoteRequest',
            'JobPlanRequest',
            'JobPlanResponse',
            'JobDeregisterResponse',
            'JobRegisterRequest',
            'JobRegisterResponse',
        ]).print_all()
