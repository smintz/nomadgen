import unittest

from nomadgen.api import Job, DockerTask
from nomadgen.jobspec.ttypes import EphemeralDisk

class JobTestCase(unittest.TestCase):

    def setUp(self):
        self.job=Job('hello')
        self.task=DockerTask("helloworld","hashicorp/http-echo")
        self.job.addTask(self.task)
        pass

    def getTaskGroup(self, group="servers"):
        return self.job.TaskGroups[self.job.getIndexOrCreateTaskGroup(group)]

    def test_create_minimal_job(self):
        job=Job('hello')
        self.assertEqual(job.ID, 'hello')
        self.assertEqual(job.Name, 'hello')
        self.assertEqual(job.Type, 'service')
        self.assertEqual(job.Region, 'global')
        self.assertEqual(len(job.TaskGroups), 0)
        self.assertEqual(len(job.Datacenters), 0)
        self.assertEqual(len(job.Constraints), 0)

    def test_create_job_with_region(self):
        job=Job('hello', region="us-east-1")
        self.assertEqual(job.Region, "us-east-1")

    def test_create_job_with_type(self):
        job=Job('hello', type="system")
        self.assertEqual(job.Type, "system")
        job=Job('hello', type="batch")
        self.assertEqual(job.Type, "batch")
        with self.assertRaises(ValueError):
            Job('hello', type='hello')

    def test_add_task_group(self):
        job=Job('hello')
        task=DockerTask("helloworld","hashicorp/http-echo")
        job.addTask(task)
        self.assertEqual(len(job.TaskGroups), 1)
        tg=job.TaskGroups[0]
        self.assertEqual(tg.Name, "servers")
        new_group_name="myname"
        job.addTask(task, new_group_name)
        tg2 = job.TaskGroups[job.getIndexOrCreateTaskGroup(new_group_name)]
        self.assertEqual(tg2.Name, new_group_name)

    def test_set_workers_count(self):
        self.job.setWorkersCount(7)
        self.assertEqual(self.getTaskGroup().Count, 7)

    def test_set_canries(self):
        self.job.setCanaries(7)
        self.assertEqual(self.getTaskGroup().Update.Canary, 7)

    def test_set_ephemeral_disk(self):
        with self.assertRaises(AssertionError):
            self.job.setEphemeralDisk("hello")
        disk=EphemeralDisk(SizeMB=300)
        self.job.setEphemeralDisk(disk)
        tg=self.getTaskGroup()
        self.assertEqual(tg.EphemeralDisk, disk)

    def test_constraints(self):
        self.job.distinctHosts()
        self.assertEqual(self.job.Constraints[0].Operand, "distinct_hosts")
        self.assertEqual(self.job.Constraints[0].RTarget, "true")
        self.job.Constraints=[]
        self.job.addConstraint("a", "b")
        self.assertEqual(self.job.Constraints[0].Operand, "=")
        self.assertEqual(self.job.Constraints[0].RTarget, "b")
        self.assertEqual(self.job.Constraints[0].LTarget, "a")


if __name__ == '__main__':
    unittest.main()
