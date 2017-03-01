from copy import deepcopy
import os

from nomad.jobspec.ttypes import *
from nomad.jobspec.constants import *
from nomad.util import *

VAULT_TOKEN=os.environ.get('VAULT_TOKEN', '')
VAULT_ADDR=os.environ.get('VAULT_ADDR', 'http://127.0.0.1:8200')

PACKAGE=Artifact(
    GetterSource="https://storage.googleapis.com/hashistack/hashiapp/v1.0.0/hashiapp",
    GetterOptions={
        "checksum": "sha256:d2127dd0356241819e4db5407284a6d100d800ebbf37b4b2b8e9aefc97f48636"
    }
)

job=Job(
    Name='hashiapp',
    ID='hashiapp',
    Datacenters=['dc1'],
    Region="global",
    Type="service",
    Update=Update(MaxParallel=1, Stagger=30 * SECOND),
    TaskGroups=[]
)
tg=TaskGroup(
    Name="servers",
    Count=5,
    Tasks=[]
)
task=Task(
    Name='hashiapp',
    Driver='exec',
    Config=Config(
        command='hashiapp',
    ),
    Artifacts=[
        PACKAGE,
    ],
    Env={
        'VAULT_TOKEN': VAULT_TOKEN,
        'VAULT_ADDR': VAULT_ADDR
    },
    LogConfig=LogConfig(),
    Resources=Resources(
        CPU=50,
        MemoryMB=128,
        Networks=[
            Network(
                MBits=1,
                DynamicPorts=[
                    Port(
                        Label="http"
                    )
                ]
            )
        ]
    ),
    Services=[
        Service(
            Name="hashiapp",
            PortLabel="http",
            Tags=[
                "urlprefix-hashiapp.coupl.in/",
            ],
            Checks=[
                Check(
                    Type="http",
                    Interval=10 * SECOND,
                    Timeout=2 * SECOND,
                    Path='/healthz'
                )
            ]
        )
    ],
)
tg1=deepcopy(tg)
tg.Name='blue'
tg.Count=1
tg1.Name='green'
tg1.Count=1
task1=deepcopy(task)
tg.Tasks.append(task)
tg1.Tasks.append(task1)

job.TaskGroups.append(tg)
job.TaskGroups.append(tg1)
export_if_last(job)
