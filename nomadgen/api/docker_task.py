from nomadgen.jobspec.ttypes import (
    DriverConfig, DockerDriverAuth,
)
from nomadgen.api.task import NGTask
import os

class DockerTask(NGTask):
    def setTaskDriver(self):
        self.Driver="docker"
        self.Config=DriverConfig(
            image=self.image,
            force_pull=self.force_pull_image,
            port_map=[]
        )

    def setDockerAuth(self, username, password):
        self.Config.auth=[
            DockerDriverAuth(
                username=username,
                password=password,
            )
        ]
