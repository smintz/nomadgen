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

def export_if_last(job):
    payload=jobToJSON(NomadJob(Job=job))

    print(jobToJSON(NomadJob(Job=job, Diff='true')))

    result=requests.post(
        "http://localhost:4646/v1/job/" + job.ID + "/plan",
        data=jobToJSON(NomadJob(Job=job, Diff=True))
    )

    print(result.text)
    j=json.loads(result.text)
    print(json.dumps(j, indent=2))
    cont = raw_input("Continue?")
    if cont in ["y", "Y"]:
        result=requests.post("http://localhost:4646/v1/job/" + job.ID, data=payload)
        try:
            j=json.loads(result.text)
            print(json.dumps(j, indent=2))
        except:
            print(result.text)

