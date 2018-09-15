from thrift.util import Serializer
from thrift.protocol.TSimpleJSONProtocol import TSimpleJSONProtocolFactory, TSimpleJSONProtocol

import click
import json
class NomadJSONProtocol(TSimpleJSONProtocol):
    FIELD_NAMES_TRANSLATIONS={
        # "args" is a reseved word in thrift and therefore cannot be used as a field name.
        "command_args": "args",
        # "class" is a reseved word in thrift and therefore cannot be used as a field name.
        "java_class": "class",
    }

    def writeFieldBegin(self, name, ttype, fid):
        name = self.FIELD_NAMES_TRANSLATIONS.get(name, name)
        self.writeJSONString(name)

    def writeBool(self, boolean):
        # This will make writeBool writing a json compatible boolean instead of 1/0
        s="false"
        if boolean:
            s="true"
        self.writeJSONInteger(s)

class NomadJSONProtocolFactory:
    def getProtocol(self, trans, spec=None):
        prot = NomadJSONProtocol(trans, spec)
        return prot

def writeToJSON(obj):
    return Serializer.serialize(NomadJSONProtocolFactory(), obj)

def fromJson(msg, spec):
    return Serializer.deserialize(TSimpleJSONProtocolFactory(), msg, spec)

def jobToJSON(job):
    return writeToJSON(job)

def validate_json_output(text, spec=None):
    try:
        if spec:
            click.echo(fromJson(text, spec))
        else:
            j=json.loads(text)
            click.echo(json.dumps(j, indent=2))
        return True
    except:
        click.echo(click.style(text, fg='red'))
        return False

