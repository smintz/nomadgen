import unittest

from nomadgen.api import DockerTask, ExecTask


class JobTestCase(unittest.TestCase):
    def setUp(self):
        self.task = DockerTask("hello", image="hashicorp/http-echo")
        pass

    def test_exec_task(self):
        task = ExecTask("hello")
        self.assertEqual(task.Driver, "exec")
        self.assertEqual(task.Name, "hello")

    def test_docker_task(self):
        task = DockerTask("hello", image="hashicorp/http-echo")
        self.assertEqual(task.Driver, "docker")
        self.assertEqual(task.Name, "hello")
        self.assertEqual(task.Config.image, "hashicorp/http-echo")
        task.setDockerAuth("foo", "bar")
        self.assertEqual(task.Config.auth[0].username, "foo")
        self.assertEqual(task.Config.auth[0].password, "bar")

    def test_add_template(self):
        self.task.addTemplate(
            self.task.makeTemplate("local/test.txt", "Hello World!")
        )
        my_template = self.task.Templates[0]
        self.assertEqual(my_template.DestPath, "local/test.txt")
        self.assertEqual(my_template.EmbeddedTmpl, "Hello World!")
        self.assertEqual(my_template.ChangeMode, self.task.change_mode)

    def test_add_service(self):
        self.task.addService("http", map_to=8080)
        my_service = self.task.Services[0]
        self.assertEqual(my_service.Name, "http")
        self.assertEqual(my_service.PortLabel, "http")
        self.assertTrue("http" in self.task.Config.port_map[0].keys())
        self.assertEqual(self.task.Config.port_map[0]["http"], "8080")
        self.assertEqual(
            self.task.Resources.Networks[0].DynamicPorts[0].Label, "http"
        )


if __name__ == "__main__":
    unittest.main()
