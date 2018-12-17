import requests
import logging
import json
import click
import six
from time import sleep

from nomadgen.helpers import validate_json_output, jobToJSON, fromJson, writeToJSON

from nomadgen.jobspec.ttypes import (
    JobAllocationsResponse,
    JobPlanRequest,
    JobPlanResponse,
    JobDeregisterResponse,
    JobRegisterRequest,
    JobRegisterResponse,
    DeploymentListResponse,
    DeploymentPromoteRequest,
)


class NomadgenAPI(object):
    default_params = {}
    verify_tls = None
    cert_path = None
    key_path = None
    job = None

    def __init__(self, addr="http://127.0.0.1:4646"):
        self.addr = addr

    def set_job(self, job):
        self.job = job
        return self

    def set_region(self, region):
        self.default_params["region"] = region
        return self

    def set_ca(self, ca):
        self.verify_tls = ca
        return self

    def set_tls_key(self, key):
        self.key_path = key
        return self

    def set_tls_cert(self, cert):
        self.cert_path = cert
        return self

    def get_tls_tuple(self):
        if self.key_path and self.cert_path:
            return (self.cert_path, self.key_path)
        else:
            return None

    def diff(self):
        job = self.job
        click.echo(click.style("Running diff...", fg="green"))
        result = self.post(
            "/v1/job/" + job.ID + "/plan",
            data=jobToJSON(JobPlanRequest(Job=job, Diff=True)),
        )
        validate_json_output(result.text, JobPlanResponse())
        return fromJson(result.text, JobPlanResponse())

    def run(self):
        payload = jobToJSON(JobRegisterRequest(Job=self.job))
        result = self.post("/v1/job/" + self.job.ID, data=payload)
        validate_json_output(result.text, JobRegisterResponse())
        d = fromJson(result.text, JobRegisterResponse())
        return d

    def stop(self):
        result = self.delete("/v1/job/" + self.job.ID)
        validate_json_output(result.text, JobDeregisterResponse())

    def promote(self, deployment):
        payload = DeploymentPromoteRequest(DeploymentID=deployment.ID, All=True)
        self.post("/v1/deployment/promote/" + deployment.ID, data=writeToJSON(payload))

    def eval(self):
        payload = {"JobID": self.job.ID, "EvalOptions": {"ForceReschedule": True}}
        result = self.post("/v1/job/" + self.job.ID + "/evaluate", data=payload)
        validate_json_output(result.text)

    def get_deployments(self, index=0):
        sleep(1)
        result = self.get(
            "/v1/job/" + self.job.ID + "/deployments", params={"index": index}
        )

        # This endpoints returns []Deployments which cannot be parsed by thrift
        ds = {"Deployments": json.loads(result.text)}
        return fromJson(json.dumps(ds), DeploymentListResponse())

    def get_running_deployments(self, index=0):
        d = self.get_deployments(index)
        return [
            deployment for deployment in d.Deployments if deployment.Status == "running"
        ]

    def wait(self, index=0, promote=False):
        click.echo("Waiting for deployment to finish")
        running_deployments = self.get_running_deployments(index)
        while len(running_deployments) > 0:
            cd = running_deployments[0]
            awaiting_promotion = [
                ds
                for tg, ds in six.iteritems(cd.TaskGroups)
                if ds.DesiredCanaries > 0
                and ds.DesiredCanaries == len(ds.PlacedCanaries) == ds.HealthyAllocs
            ]

            logging.info("%d task groups awaiting promotion" % len(awaiting_promotion))
            logging.debug(awaiting_promotion)
            if promote and len(awaiting_promotion) == len(cd.TaskGroups):
                self.promote(cd)
            running_deployments = self.get_running_deployments(cd.ModifyIndex)

    def get_allocations(self):
        result = self.get("/v1/job/" + self.job.ID + "/allocations")
        _my = json.dumps({"Allocations": json.loads(result.text)})
        return fromJson(_my, JobAllocationsResponse())

    # HTTP Methods
    def get(self, path, params={}):
        params.update(self.default_params)
        return requests.get(
            self.addr + path,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )

    def post(self, path, data, params={}):
        params.update(self.default_params)
        return requests.post(
            self.addr + path,
            data=data,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )

    def put(self, path, data, params={}):
        params.update(self.default_params)
        return requests.put(
            self.addr + path,
            data=data,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )

    def delete(self, path, params={}):
        params.update(self.default_params)
        return requests.delete(
            self.addr + path,
            verify=self.verify_tls,
            params=params,
            cert=self.get_tls_tuple(),
        )
