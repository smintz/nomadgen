from nomadgen.jobspec.ttypes import *
from nomadgen.jobspec.constants import *
from nomadgen.util import export_if_last

from common.resources import CommonResources

import os

VAULT_TOKEN=os.environ.get('VAULT_TOKEN', None)
VAULT_ADDR=os.environ.get('VAULT_ADDR', 'http://127.0.0.1:8200')
FABIO_HOST=os.environ.get('FABIO_HOST', 'fabio.local')

PACKAGE=Artifact(
    GetterSource="https://github.com/eBay/fabio/releases/download/v1.3.8/fabio-1.3.8-go1.7.5-linux_amd64"
)

job=Job(
    Name='fabio',
    ID='fabio',
    Datacenters=['dc1'],
    Region='global',
    Type="system",
    Update=Update(MaxParallel=1, Stagger=3 * SECOND),
    TaskGroups=[]
)
tg=TaskGroup(
    Name="servers",
    Count=1,
    Tasks=[]
)
task=Task(
    Name='fabio',
    Driver='raw_exec',
    Config=Config(
        command="fabio-1.3.8-go1.7.5-linux_amd64",
    ),
    Env={
        'FABIO_proxy_cs': 'cs=prodcert;type=vault;cert=secret/fabio/cert',
        'FABIO_proxy_addr': ':${NOMAD_PORT_http},:${NOMAD_PORT_https};cs=prodcert',
        'FABIO_ui_addr': ':${NOMAD_PORT_config}',
        'VAULT_ADDR': VAULT_ADDR
    },
    Vault=Vault(
        Policies=['fabio']
    ),
    Artifacts=[
        PACKAGE,
    ],
    LogConfig=LogConfig(),
    Resources=CommonResources() \
        .setPort("http", 80) \
        .setPort("https", 443) \
        .setPort("config"),
    Services=[
        Service(
            Name="fabio",
            PortLabel="config",
            Tags=[ "http", "frontend", "urlprefix-{}/".format(FABIO_HOST)],
            Checks=[
                Check(
                    Type="http",
                    Interval=10 * SECOND,
                    Timeout=2 * SECOND,
                    Path='/'
                )
            ]
        )
    ],
)
tg.Tasks.append(task)
job.TaskGroups.append(tg)
export_if_last(job)
