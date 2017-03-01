from thrift.transport.TTransport import TMemoryBuffer
from thrift.protocol.TJSONProtocol import TSimpleJSONProtocol
from jobspec.ttypes import NomadJob

import requests
import json
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

def export_if_last(job):

    # Show the diff
    result=requests.post(
        "http://localhost:4646/v1/job/" + job.ID + "/plan",
        data=jobToJSON(NomadJob(Job=job, Diff=True))
    )

    if not (validate_json_output(result.text)):
        return
    cont = raw_input("Continue?")
    if cont in ["y", "Y"]:
        payload=jobToJSON(NomadJob(Job=job))
        result=requests.post("http://localhost:4646/v1/job/" + job.ID, data=payload)
        validate_json_output(result.text)

