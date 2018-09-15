from nomadgen.jobspec.ttypes import (
    DriverConfig, DockerDriverAuth,
)
from nomadgen.api.task import NGTask
import os

class ExecTask(NGTask):
    def setTaskDriver(self):
        self.Driver="exec"
        self.Config=DriverConfig()
        return self

