from nomad.jobspec.ttypes import *
from nomad.jobspec.constants import *
from nomad.util import *
import os

BASE_DOMAIN=os.environ.get('BASE_DOMAIN', 'domain.local')

PROMETHEUS_CONFIG="""
global:
  scrape_interval:     15s
  evaluation_interval: 15s
  external_labels:
      monitor: 'codelab-monitor'

rule_files:

scrape_configs:
  - job_name: 'prometheus'

    scrape_interval: 5s
    consul_sd_configs:
    - server: 'localhost:8500'
"""
PROMETHEUS_TAR=Artifact(
    GetterSource="https://github.com/prometheus/prometheus/releases/download/v1.5.2/prometheus-1.5.2.linux-amd64.tar.gz",
)
GRAFANA_CONFIG="""
[server]
http_port={{env "NOMAD_PORT_http"}}
"""
GRAFANA_VERSION='4.1.2-1486989747'
GRAFANA_TAR=Artifact(
    GetterSource="https://grafanarel.s3.amazonaws.com/builds/grafana-%s.linux-x64.tar.gz" % GRAFANA_VERSION,
)
job=Job(
    Name='monitoring',
    ID='monitoring',
    Datacenters=['dc1'],
    Region="global",
    Type="service",
    Update=Update(MaxParallel=1, Stagger=30 * SECOND),
    TaskGroups=[]
)
prometheus_tg=TaskGroup(
    Name="prometheus",
    Count=1,
    Tasks=[]
)
prometheus_task=Task(
    Name='prometheus',
    Driver='exec',
    Config=Config(
        command='prometheus-1.5.2.linux-amd64/prometheus',
        Args=[
            "-config.file", "config.yml",
            "-web.listen-address=:${NOMAD_PORT_http}"
        ]
    ),
    Artifacts=[
        PROMETHEUS_TAR,
    ],
    Templates=[
        Template(
            DestPath="config.yml",
            EmbeddedTmpl=PROMETHEUS_CONFIG,
            ChangeMode="restart"
        )
    ],
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
            Name="prometheus",
            PortLabel="http",
            Tags=[
                "urlprefix-prometheus.{}/".format(BASE_DOMAIN),
            ],
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

prometheus_tg.Tasks.append(prometheus_task)
job.TaskGroups.append(prometheus_tg)
grafana_tg=TaskGroup(
    Name="grafana",
    Count=1,
    Tasks=[]
)
grafana_task=Task(
    Name='grafana',
    Driver='docker',
    Config=Config(
        image = "grafana/grafana",
        port_map = [{"http": "3000"}]
    ),
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
            Name="grafana",
            PortLabel="http",
            Tags=[
                "urlprefix-grafana.{}/".format(BASE_DOMAIN),
            ],
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
grafana_tg.Tasks.append(grafana_task)
job.TaskGroups.append(grafana_tg)
export_if_last(job)

