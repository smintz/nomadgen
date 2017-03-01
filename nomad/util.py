from thrift.transport.TTransport import TMemoryBuffer
from thrift.protocol.TJSONProtocol import TSimpleJSONProtocol
from jobspec.ttypes import NomadJob

import requests
import json
import argparse
class NomadJSONProtocol(TSimpleJSONProtocol):

# This will make writeBool writing a json compatible boolean instead of 1/0
    def writeBool(self, boolean):
        s="false"
        if boolean:
            s="true"
        self.writeJSONNumber(s)

def writeToJSON(obj):
  trans = TMemoryBuffer()
  proto = NomadJSONProtocol(trans)
  obj.write(proto)
  return trans.getvalue()

def jobToJSON(job):
    return writeToJSON(job).replace('"Args":', '"args":')

def validate_json_output(text):
    try:
        j=json.loads(text)
        print(json.dumps(j, indent=2))
        return True
    except:
        print(result.text)
        return False

def cmdline():
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('-r', '--run', action='store_true', help='Will make nomad agent run the output')
    parser.add_argument('-x', '--skip_diff', action='store_true', help='Will skip plan step')
    parser.add_argument('-f', '--force', action='store_true', help='Should not wait for confirmation')
    parser.add_argument('-v', '--verbose', action='store_true', help='Run verbose logging')
    parser.add_argument('--nomad_address', default='http://127.0.0.1:4646', help='Override default nomad agent address')
    return parser.parse_args()

def export_if_last(job):
    args=cmdline()
    if args.verbose:
        print(args)

    if args.run:
        if not args.skip_diff:
            # Show the diff
            result=requests.post(
                args.nomad_address + "/v1/job/" + job.ID + "/plan",
                data=jobToJSON(NomadJob(Job=job, Diff=True))
            )

            if not (validate_json_output(result.text)):
                return

        if args.force:
            cont = "y"
        else:
            cont = raw_input("Continue?")
        if cont in ["y", "Y"]:
            payload=jobToJSON(NomadJob(Job=job))
            result=requests.post(args.nomad_address + "/v1/job/" + job.ID, data=payload)
            validate_json_output(result.text)
    else:
        validate_json_output(jobToJSON(job))

