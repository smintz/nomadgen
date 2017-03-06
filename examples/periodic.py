from nomadgen.jobspec.ttypes import *
from nomadgen.jobspec.constants import *
from nomadgen.util import export_if_last

job=Job(
    Name='periodic',
    ID='periodic',
    Datacenters=['dc1'],
    Region='global',
    Type="batch",
    Update=Update(MaxParallel=1, Stagger=3 * SECOND),
    Periodic=Periodic(
        Enabled=True,
        SpecType="cron",
        Spec="* * * * *",
        ProhibitOverlap=True
    ),
    TaskGroups=[]
)
tg=TaskGroup(
    Name="servers",
    Count=1,
    Tasks=[]
)
task=Task(
    Name='hello_world',
    Driver='exec',
    Config=Config(
        command="echo",
        command_args=["hello", "world"]
    ),
    LogConfig=LogConfig(),
    Resources=Resources(
        CPU=50,
        MemoryMB=128,
        Networks=[ ]
    ),
)
tg.Tasks.append(task)
job.TaskGroups.append(tg)
export_if_last(job)
