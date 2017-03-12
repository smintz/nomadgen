from copy import deepcopy
import os

from nomadgen.jobspec.ttypes import *
from nomadgen.jobspec.constants import *
from nomadgen.util import *

from common.resources import CommonResources

VAULT_ADDR=os.environ.get('VAULT_ADDR', 'http://127.0.0.1:8200')
HASHIAPP_HOST=os.environ.get('HASHIAPP_HOST', 'hashiapp.com')
DB_HOST=os.environ.get('DB_HOST', '127.0.0.1')

GREEN_VERSION='1.0.0'
BLUE_VERSION='2.0.0'

GREEN_WORKERS=1
BLUE_WORKERS=1

BLUE_PACKAGE=Artifact(
    GetterSource="https://storage.googleapis.com/hashistack/hashiapp/v{}/hashiapp".format(BLUE_VERSION),
)
GREEN_PACKAGE=Artifact(
    GetterSource="https://storage.googleapis.com/hashistack/hashiapp/v{}/hashiapp".format(GREEN_VERSION),
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
    Name="temp",
    Count=0,
    Tasks=[]
)
task=Task(
    Name='hashiapp',
    Driver='exec',
    Config=Config(
        command='hashiapp',
    ),
    Artifacts=[
        BLUE_PACKAGE,
    ],
    Env={
        'VAULT_ADDR': VAULT_ADDR,
        'HASHIAPP_DB_HOST': DB_HOST,
    },
    Vault=Vault(
        Policies=['hashiapp']

    ),
    LogConfig=LogConfig(),
    Resources=CommonResources().setPort("http"),
    Services=[
        Service(
            Name="hashiapp",
            PortLabel="http",
            Tags=[
                "urlprefix-{}/".format(HASHIAPP_HOST),
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
green_tg=deepcopy(tg)
green_tg.Name='green'
green_tg.Count=GREEN_WORKERS
green_task=deepcopy(task)
green_task.Artifacts=[GREEN_PACKAGE]
green_tg.Tasks.append(green_task)
job.TaskGroups.append(green_tg)

blue_tg=deepcopy(tg)
blue_tg.Name='blue'
blue_tg.Count=BLUE_WORKERS
blue_task=deepcopy(task)
blue_task.Artifacts=[BLUE_PACKAGE]
blue_tg.Tasks.append(blue_task)
job.TaskGroups.append(blue_tg)
export_if_last(job)
