from nomad.jobspec.ttypes import *
from nomad.jobspec.constants import *
from nomad.util import export_if_last

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
        'FABIO_proxy_addr': ':80,:443;cs=prodcert',
        'VAULT_ADDR': VAULT_ADDR
    },
    Vault=Vault(
        Policies=['fabio']
    ),
    Artifacts=[
        PACKAGE,
    ],
    LogConfig=LogConfig(),
    Resources=Resources(
        CPU=50,
        MemoryMB=128,
        Networks=[
            Network(
                MBits=1,
                ReservedPorts=[
                    Port(
                        Label="http",
                        Value=80
                    ),
                    Port(
                        Label="https",
                        Value=443
                    ),
                    Port(
                        Label="config",
                        Value=9998
                    )
                ]
            )
        ]
    ),
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
