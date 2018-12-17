import logging
import os
import random
import string
import subprocess
import unittest
import requests
import zipfile
import platform

try:
    from StringIO import StringIO as stringio
except ImportError:
    from io import BytesIO as stringio

from dns import resolver
from time import sleep

from nomadgen.api import Job, ExecTask, SECOND
from nomadgen.client import NomadgenAPI
from nomadgen.consul_client import ConsulAPI
from nomadgen.jobspec.ttypes import ServiceCheck

from nomadgen.nomad_meta import NOMAD_VERSION
from nomadgen.consul_meta import CONSUL_VERSION


def download(binary, version):
    webfile = requests.get(
        "https://releases.hashicorp.com/{binary}/{version}/"
        "{binary}_{version}_{system}_amd64.zip".format(
            binary=binary, version=version, system=platform.system().lower()
        )
    )
    webfile2 = zipfile.ZipFile(stringio(webfile.content))
    content = webfile2.open(webfile2.filelist[0]).read()
    filepath = "/tmp/" + binary
    localfile = open(filepath, "wb")
    localfile.write(content)
    localfile.close()
    os.chmod(filepath, 0o755)
    return filepath


def randomword(length):
    letters = string.ascii_lowercase
    return "".join(random.choice(letters) for i in range(length))


http_check = ServiceCheck(
    Type="http", Interval=10 * SECOND, Timeout=2 * SECOND, Path="/"
)


def get_random_job():
    r = randomword(20)
    job = Job(r)
    job.Datacenters = ["dc1"]
    job.setWorkersCount(1)
    task = ExecTask(r, change_mode="restart")
    task.Driver = "raw_exec"
    task.addTemplate(
        task.makeTemplate(
            "local/start.sh",
            """#!/bin/bash
python -m SimpleHTTPServer ${NOMAD_PORT_http} \
        || python -m http.server ${NOMAD_PORT_http}
        """,
        )
    )
    task.Config.command = "local/start.sh"
    task.addService(r, port_label="http", checks=[http_check])
    task.addTemplate(task.makeTemplate("local/test", r))
    job.addTask(task)
    return job


class ClientTest(unittest.TestCase):
    def setUp(self):
        nomad = download("nomad", NOMAD_VERSION)
        consul = download("consul", CONSUL_VERSION)
        self.consul_proc = subprocess.Popen(
            [consul, "agent", "-dev"], stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        sleep(1)
        nomad_runner_txt = """\
#!/bin/bash
exec {nomad} agent -dev
""".format(
            nomad=nomad
        )

        nomad_runner_file = open("/tmp/nomad_runner.sh", "w")
        nomad_runner_file.write(nomad_runner_txt)
        nomad_runner_file.close()
        os.chmod("/tmp/nomad_runner.sh", 0o755)
        self.nomad_proc = subprocess.Popen(
            ["/tmp/nomad_runner.sh"], stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        sleep(5)
        self.consul_resolver = resolver.Resolver()
        self.consul_resolver.port = 8600
        self.consul_resolver.nameservers = ["127.0.0.1"]

    def tearDown(self):
        self.consul_proc.terminate()
        self.nomad_proc.terminate()

    def test_main_flow(self):
        nomadgen_client = NomadgenAPI()
        job = get_random_job()
        nomadgen_client.set_job(job)

        logging.info("Starting job for the first time")
        nomadgen_client.run()
        sleep(1)

        logging.info("[first] Wait for deployment to complete")
        nomadgen_client.wait()

        logging.info("[first] Validate allocation is running")
        allocs = nomadgen_client.get_allocations()
        self.assertEqual(allocs.Allocations[0].TaskStates[job.ID].State, "running")

        logging.info("[first] Validate deployment completed with `successful` state")
        deployments = nomadgen_client.get_deployments()
        self.assertEqual(deployments.Deployments[0].Status, "successful")

        logging.info("[first] Validate service is registered with consul")
        self.consul_resolver.query(job.ID + ".service.consul", "SRV")
        consul = ConsulAPI()
        answer = consul.get_service(job.ID)
        self.assertEqual(len(answer.ServiceNodes), 1)

        logging.info("[first] Validate task is answering")
        requests.get("http://127.0.0.1:%d" % answer.ServiceNodes[0].ServicePort)

        logging.info("Increase workers amount")
        nomadgen_client.job.setWorkersCount(3)
        diff = nomadgen_client.diff()
        logging.debug(diff)
        self.assertEqual(diff.Annotations.DesiredTGUpdates["servers"].InPlaceUpdate, 1)
        self.assertEqual(diff.Annotations.DesiredTGUpdates["servers"].Place, 2)
        nomadgen_client.run()

        logging.info("[scale] Wait for deployment to complete")
        nomadgen_client.wait()

        allocs = nomadgen_client.get_allocations()
        # logging.debug(allocs)
        self.assertEqual(len(allocs.Allocations), 3)

        logging.info("[scale] Validate allocation is running")
        allocs = nomadgen_client.get_allocations()
        self.assertEqual(len(allocs.Allocations), 3)
        self.assertEqual(allocs.Allocations[0].TaskStates[job.ID].State, "running")

        logging.info("[scale] Validate deployment completed with `successful` state")
        deployments = nomadgen_client.get_deployments()
        self.assertEqual(deployments.Deployments[0].Status, "successful")

        logging.info("[scale] Validate service is registered with consul")
        result = self.consul_resolver.query(job.ID + ".service.consul", "SRV")
        self.assertEqual(len(result), 3)

        if platform.system() == "Linux":
            logging.info("Test canaries")
            nomadgen_client.job.setCanaries(1)
            nomadgen_client.job.TaskGroups[0].Tasks[0].addTemplate(
                nomadgen_client.job.TaskGroups[0]
                .Tasks[0]
                .makeTemplate("local/canary", "canary")
            )
            nomadgen_client.run()
            sleep(1)

            logging.info("[canaries] Validate deployment is running")
            deployments = nomadgen_client.get_running_deployments()
            logging.debug(deployments)
            self.assertEqual(len(deployments), 1)

            nomadgen_client.wait(promote=True)
            nomadgen_client.wait()


if __name__ == "__main__":
    unittest.main()
