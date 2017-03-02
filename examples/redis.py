from nomad.jobspec.ttypes import *
from nomad.jobspec.constants import *
from nomad.util import export_if_last

from copy import deepcopy
job=Job(
    Name='redis',
    ID='redis',
    Datacenters=['dc1'],
    Region='global',
    Type="service",
    Update=Update(MaxParallel=1, Stagger=3 * SECOND),
    TaskGroups=[]
)
tg=TaskGroup(
    Name="docker",
    Count=1,
    Tasks=[]
)
task=Task(
    Name='redis',
    Driver='docker',
    Config=Config(
        image="redis:3.2",
        port_map=[{'db': '6379'}]
    ),
    LogConfig=LogConfig(),
    Artifacts=[],
    Resources=Resources(
        CPU=500,
        MemoryMB=256,
        Networks=[
            Network(
                MBits=1,
                DynamicPorts=[
                    Port(
                        Label="db",
                    ),
                ]
            )
        ]
    ),
    Services=[
        Service(
            Name="global-redis-check",
            PortLabel="db",
            Tags=[ "global", "cache" ],
            Checks=[
                Check(
                    Type="tcp",
                    Interval=10 * SECOND,
                    Timeout=2 * SECOND,
                    Name="alive"
                )
            ]
        )
    ],
)

rkt_tg = deepcopy(tg)
rkt_task = deepcopy(task)

rkt_tg.Name='rkt'

rkt_task.Driver="rkt"
rkt_task.Config.image="docker://redis:3.2"
rkt_task.Config.port_map=[{'db': '6379-tcp'}]

qemu_tg = deepcopy(tg)
qemu_task = deepcopy(task)

qemu_tg.Name='qemu'

qemu_task.Driver="qemu"
qemu_task.Config=Config(
    image_path="osv-redis-memonly-v0.24.qemu.qcow2",
    accelerator="kvm",
    port_map=[{'db': '6379'}]
)
qemu_task.Artifacts=[
    Artifact(
        GetterSource="http://downloads.osv.io.s3.amazonaws.com/cloudius/osv-redis-memonly/osv-redis-memonly-v0.24.qemu.qcow2"
    )
]

tg.Tasks.append(task)
rkt_tg.Tasks.append(rkt_task)
qemu_tg.Tasks.append(qemu_task)

job.TaskGroups.append(tg)
job.TaskGroups.append(rkt_tg)
job.TaskGroups.append(qemu_tg)
export_if_last(job)
