from nomadgen.struct_parser import StructParser
CONSUL_VERSION = '1.3.0'

if __name__ == "__main__":
    StructParser(
        version='v' + CONSUL_VERSION,
        product='consul',
        override_field={
            'ServiceDefinitionConnectProxy': {'Config': 'string'},
            'ServiceNode': {
                'ServiceKind': 'string',
            },
        },
        tr_types={
            'api.ReadableDuration': 'string',
            'types.NodeID': 'string',
            'types.CheckID': 'string',
        },
        file_paths=[
            '/agent/structs/structs.go',
            '/agent/structs/service_definition.go',
        ],
        start_keys=[
            'QueryMeta',
            'IndexedNodes',
            'IndexedServices',
            'IndexedServiceNodes',
            'IndexedNodeServices',
            'IndexedHealthChecks',
            'IndexedCheckServiceNodes',
            'IndexedNodeDump',
        ]).print_all()
