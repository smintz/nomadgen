from nomadgen.jobspec.ttypes import (
    Task, Vault, LogConfig, Service, Template
)
from nomadgen.api.resources import CommonResources
from nomadgen.api.time import SECOND
import os

def mktemplate(path, data, change_mode='noop'):
    return Template(
        DestPath=path,
        EmbeddedTmpl=data,
        ChangeMode=change_mode,
        ChangeSignal='SIGHUP',
    )

# Common cert request header
CERT_HEADER_TEMPLATE = (
    """{{ $common_name := printf "common_name=%s.service.%s" (env "NOMAD_TASK_NAME") (env "meta.consul_domain" ) }}"""
    """{{ $alt_names := printf "alt_names=*.service.%s,*.query.%s" (env "meta.consul_domain") (env "meta.consul_domain")}}"""
    """{{ $ip_sans :=  printf "ip_sans=127.0.0.1,%s" (env "attr.unique.network.ip-address") }}"""
    """{{ with secret "packetca/issue/consul-certs" $common_name $ip_sans $alt_names "format=pem" }}"""
)


class NGTask(Task):

    def __init__(self, name, image=None, change_mode='noop', install_certs=False,
                 force_pull_image=False):
        Task.__init__(self)
        self.Name=name
        self.image=image
        self.force_pull_image = force_pull_image
        self.change_mode=change_mode
        self.setTaskDriver()
        self.Artifacts=[ ]
        self.LogConfig=LogConfig()
        self.Resources=CommonResources()
        self.Services=[ ]
        if install_certs:
            self.installCerts()

    def installCerts(self):
        self.makeCerts()
        self.Templates=[
            self.CA_TEMPLATE,
            self.CERT_TEMPLATE,
            self.KEY_TEMPLATE,
        ]
        self.Vault=Vault(Policies=['certs'])

    def makeCerts(self):
        # Get ROOT CA Certificate
        self.CA_TEMPLATE=self.makeTemplate(
            '${NOMAD_SECRETS_DIR}/ca.crt',
            """{{ with secret "rootca/cert/ca" }}{{ .Data.certificate }}{{ end }}""",
        )

        # Issue a client cert by the intermediate CA
        self.CERT_TEMPLATE=self.makeTemplate(
            '${NOMAD_SECRETS_DIR}/client.crt',
            CERT_HEADER_TEMPLATE + """
{{ .Data.certificate }}
{{ .Data.issuing_ca }}{{ end }}""",
        )

        # Issue a client key by the intermediate CA
        self.KEY_TEMPLATE=self.makeTemplate(
            '${NOMAD_SECRETS_DIR}/client.key',
            CERT_HEADER_TEMPLATE + """
{{ .Data.private_key }}{{ end }}""",
        )

    def setTaskDriver(self):
        raise NotImplementedError()

    def addService(self, name, tags=[], checks=[], port=None, map_to=None, port_label=None):
        if port_label is None:
            port_label = name
        service = Service(
            Name=name,
            PortLabel=port_label,
            Tags=tags,
            Checks=checks,
        )
        self.Services.append(service)
        self.setPort(port_label, port, map_to)
        return self

    def setPort(self, name, port=None, map_to=None):
        self.Resources.setPort(name, port)
        if map_to:
            self.Config.port_map.append({name: str(map_to)})
        return self

    def makeTemplate(self, path, data, prems='0644', change_mode=None):
        if change_mode is None:
            change_mode = self.change_mode

        t = mktemplate(path, data, change_mode=change_mode)
        t.Prems=prems
        return t

    def addTemplate(self, template):
        self.Templates.append(template)
        return self
