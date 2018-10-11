import unittest
import subprocess
import urllib2
import zipfile
from StringIO import StringIO
import os
import random, string
from time import sleep
from dns import resolver

from nomadgen.api import Job, ExecTask, SECOND
from nomadgen.client import NomadgenAPI
from nomadgen.jobspec.ttypes import ServiceCheck, TaskArtifact


def download(binary, version):
    webfile = urllib2.urlopen(
        'https://releases.hashicorp.com/{binary}/{version}/{binary}_{version}_linux_amd64.zip'.format(
            binary=binary, version=version
        ))
    webfile2 = zipfile.ZipFile(StringIO(webfile.read()))
    content = webfile2.open(webfile2.filelist[0]).read()
    filepath= '/tmp/' + binary
    localfile = open(filepath, 'w')
    localfile.write(content)
    localfile.close()
    os.chmod(filepath, 0o755)
    return filepath


def randomword(length):
    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(length))

http_check = ServiceCheck(
    Type="http",
    Interval=10 * SECOND,
    Timeout=2 * SECOND,
    Path='/'
)

def get_random_job():
    r = randomword(20)
    job=Job(r)
    job.Datacenters=['dc1']
    job.setWorkersCount(1)
    task=ExecTask(r)
    # task.Artifacts.append(TaskArtifact(
    #     GetterSource='https://github.com/rif/spark/releases/download/v1.6.0/spark_1.6.0_linux_amd64.tar.gz'
    # ))
    # task.Config.command="${NOMAD_TASK_DIR}/spark"
    # task.Config.command_args="-port=${NOMAD_PORT_http} 'Hello World!'"
    task.Config.command="python"
    task.Config.command_args="-m SimpleHTTPServer ${NOMAD_PORT_http}".split()
    task.addService(r, port_label='http', checks=[http_check], port=8787)
    job.addTask(task)
    return job

class ClientTest(unittest.TestCase):
    def setUp(self):
        nomad = download('nomad', '0.8.3')
        consul = download('consul', '1.2.2')
        self.consul_proc=subprocess.Popen([consul, 'agent', '-dev'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        sleep(1)
        self.nomad_proc=subprocess.Popen([nomad, 'agent', '-dev'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        sleep(5)
        self.consul_resolver = resolver.Resolver()
        self.consul_resolver.port = 8600
        self.consul_resolver.nameservers = ["127.0.0.1"]
        self.c = NomadgenAPI()

    def test_main_flow(self):
        job=get_random_job()
        self.c.set_job(job)

        # Starting job for the first time
        self.c.run()
        sleep(1)

        # Validate allocations creation
        allocs = self.c.get_allocations()
        self.assertEqual(allocs.Allocations[0].TaskStates[job.ID].State, 'pending')

        # Validate deployment is running
        deployments = self.c.get_deployments()
        self.assertEqual(deployments.Deployments[0].Status, 'running')

        # Wait for deployment to complete
        self.c.wait()

        # Validate allocation is running
        allocs = self.c.get_allocations()
        self.assertEqual(allocs.Allocations[0].TaskStates[job.ID].State, 'running')

        # Validate deployment completed with `successful` state
        deployments = self.c.get_deployments()
        self.assertEqual(deployments.Deployments[0].Status, 'successful')

        # Validate service is registered with consul
        self.consul_resolver.query(job.ID + '.service.consul', 'SRV')

        # Validate task is answering
        urllib2.urlopen('http://127.0.0.1:8787').read()

if __name__ == '__main__':
    unittest.main()
