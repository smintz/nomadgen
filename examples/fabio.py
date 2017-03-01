from nomad.jobspec.ttypes import *
from nomad.jobspec.constants import *
from nomad.util import export_if_last

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
    Driver='exec',
    Config=Config(
        command="fabio-1.3.8-go1.7.5-linux_amd64"
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
                        Value=9999
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
            Name="http",
            PortLabel="config",
            Tags=[ "http", "frontend" ],
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
