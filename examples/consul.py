#!/usr/bin/env nomadgen.pex
from nomadgen.api import Job, DockerTask
from nomadgen.util import export_if_last

# Create a job from nomadgen.api.Job
job = Job("consul")

# Set the Datacenters where the job should run in.
job.Datacenters = ["dc1"]

# Set the amount of workers you need. It's recommended to use N + 3, when N is
# the amount of workers required to serve at peak time.
job.setWorkersCount(1)

task = DockerTask("consul", "consul:1.3.0").setPort("http", 8500, 8500)
task.Config.command_args = ["agent", "-dev"]
# task.Config.network_mode = 'host'

job.addTask(task)
export_if_last(job)
