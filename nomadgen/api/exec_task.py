from nomadgen.jobspec.ttypes import DriverConfig
from nomadgen.api.task import NGTask


class ExecTask(NGTask):
    def setTaskDriver(self):
        self.Driver = "exec"
        self.Config = DriverConfig()
        return self
