import unittest

from nomadgen.api import Job, DockerTask

class JobTestCase(unittest.TestCase):

    def setUp(self):
        pass

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

if __name__ == '__main__':
    unittest.main()
