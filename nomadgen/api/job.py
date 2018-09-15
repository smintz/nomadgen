from nomadgen.jobspec.ttypes import (
    Job, TaskGroup, Task, UpdateStrategy, Constraint,
)
from nomadgen.api.time import SECOND

import os

class NGJob(Job):
    def __init__(self, id, dc=[], region='global', type='service'):
        Job.__init__(self)
        self.Name=id
        self.ID=id
        self.Datacenters=dc
        self.Region=region
        self.Type=type
        self.TaskGroups=[]
        self.Constraints=[]

    def addTaskGroup(self, name="servers", workers=3):
        tg = TaskGroup(
            Name=name,
            Count=workers,
            Tasks=[],
        )
        if self.Type != 'batch':
            tg.Update=UpdateStrategy(
                MaxParallel=1,
                Stagger=3 * SECOND,
                HealthyDeadline=300 * SECOND,
                Canary=1,
            )
        self.TaskGroups.append(tg)

    def getIndexOrCreateTaskGroup(self, group="servers"):
        arr = [g for g in self.TaskGroups if g.Name == group]
        if len(arr) < 1:
            self.addTaskGroup(group)
            return self.getIndexOrCreateTaskGroup(group)
        else:
            return self.TaskGroups.index(arr[0])

    def addTask(self, task, group="servers"):
        assert isinstance(task, Task)
        index = self.getIndexOrCreateTaskGroup(group)
        self.TaskGroups[index].Tasks.append(task)
        return self

    def setWorkersCount(self, num, group="servers"):
        index = self.getIndexOrCreateTaskGroup(group)
        self.TaskGroups[index].Count = num
        return self

    def setEphemeralDisk(self, disk, group="servers"):
        assert isinstance(disk, EphemeralDisk)
        index = self.getIndexOrCreateTaskGroup(group)
        self.TaskGroups[index].EphemeralDisk = disk
        return self

    def tierConstraint(self, tiers=['shared']):
        return Constraint(
            LTarget='${meta.tier}',
            Operand='regexp',
            RTarget='(%s)' % '|'.join(tiers)
        )

    def setTiers(self, tiers=['shared']):
        tier_constraint = self.tierConstraint(tiers)
        if len(self.Constraints) > 0:
            self.Constraints[0] = tier_constraint
        else:
            self.Constraints.append(tier_constraint)
        return self
