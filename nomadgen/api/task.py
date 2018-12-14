from nomadgen.jobspec.ttypes import Task, LogConfig, Service, Template
from nomadgen.api.resources import NGResources


class NGTask(Task):
    def __init__(
        self,
        name,
        image=None,
        change_mode="noop",
        force_pull_image=False,
        cpu=100,
        memory=128,
    ):
        Task.__init__(self)
        self.Name = name
        self.image = image
        self.force_pull_image = force_pull_image
        self.change_mode = change_mode
        self.setTaskDriver()
        self.Artifacts = []
        self.LogConfig = LogConfig()
        self.Resources = NGResources(cpu, memory)
        self.Services = []
        self.Templates = []

    def setTaskDriver(self):
        raise NotImplementedError()

    def addService(
        self, name, tags=[], checks=[], port=None, map_to=None, port_label=None
    ):
        if port_label is None:
            port_label = name
        service = Service(
            Name=name, PortLabel=port_label, Tags=tags, Checks=checks
        )
        self.Services.append(service)
        self.setPort(port_label, port, map_to)
        return self

    def setPort(self, name, port=None, map_to=None):
        self.Resources.setPort(name, port)
        if map_to:
            self.Config.port_map.append({name: str(map_to)})
        return self

    def makeTemplate(self, path, data, perms="0644", change_mode=None):
        if change_mode is None:
            change_mode = self.change_mode

        return Template(
            DestPath=path,
            EmbeddedTmpl=data,
            ChangeMode=change_mode,
            ChangeSignal="SIGHUP",
            Perms=perms,
        )

    def addTemplate(self, template):
        self.Templates.append(template)
        return self
