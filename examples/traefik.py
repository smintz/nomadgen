#!/usr/bin/env nomadgen.pex
from nomadgen.api import Job, DockerTask
from nomadgen.jobspec.ttypes import Template
from nomadgen.util import export_if_last

# Create a job from nomadgen.api.Job
job = Job("traefik")

# Set the Datacenters where the job should run in.
job.Datacenters = ["dc1"]

# Set the amount of workers you need. It's recommended to use N + 3, when N is
# the amount of workers required to serve at peak time.
job.setWorkersCount(1)

task = (
    DockerTask("traefik", "traefik:latest")
    .setPort("http", 80)
    .setPort("traefik", 19999, map_to=19999)
)

task.Leader = True
task.Config.network_mode = "host"
task.Config.command_args = ["-c", "/local/traefik.toml", "--api"]

config_template = Template(
    DestPath="local/traefik.toml",
    EmbeddedTmpl="""
logLevel = "ERROR"
defaultEntryPoints = ["http", "https"]
[entryPoints]
    [entryPoints.http]
        address = ":{{env "NOMAD_PORT_http"}}"
    [entryPoints.traefik]
        address = ":{{env "NOMAD_PORT_traefik"}}"
[ping]
[api]
[accessLog]
format="json"
[traefikLog]
[consulCatalog]
    exposedByDefault = false
    watch = true
    prefix = "lb"
[metrics]
    [metrics.prometheus]
        entryPoint = "traefik"
""",
)

task.addTemplate(config_template)

job.addTask(task)
export_if_last(job)
