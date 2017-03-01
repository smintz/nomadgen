struct Constraint {
  1: optional string LTarget
  2: optional string RTarget
  3: optional string Operand
}

typedef map<string,string> Meta
struct ParamaterizedJob {}
struct Update {
  1: optional i64 MaxParallel
  2: optional i64 Stagger
}
struct Periodic {
  1: optional bool Enabled
  2: optional string SpecType
  3: optional string Spec
  4: optional bool ProhibitOverlap
}
struct RestartPolicy {
  1: optional i64 Attempts
  2: optional i64 Interval
  3: optional i64 Delay
  4: optional string Mode
}
struct Artifact {
  1: required string GetterSource
  2: optional string RetrivalDest
  3: optional map<string,string> GetterOptions
}
struct LogConfig {
  1: required i32 MaxFiles = 3
  2: required i32 MaxFileSizeMB = 10
}
struct Port {
  1: required string Label
  2: optional i32 Value
}
struct Network {
  1: optional i64 MBits
  2: optional list<Port> DynamicPorts
  3: optional list<Port> ReservedPorts
}
struct Resources {
  1: optional i64 CPU
  2: optional i64 DiskMB
  3: optional i16 IOPS
  4: optional i64 MemoryMB
  5: optional list<Network> Networks
}
struct Check {
  1: required string Type
  2: required string Name
  3: required i64 Interval = 10000000000
  4: required i64 Timeout = 2000000000
  5: optional string Path
  6: optional string Protocol
  7: optional string Command
  8: optional list<string> Args
}
struct Service {
  1: required string Name
  2: optional list<string> Tags
  3: optional string PortLabel
  4: optional list<Check> Checks
}
struct Template {
  1: optional string SourcePath
  2: optional string EmbeddedTmpl
  3: required string DestPath
  4: optional string ChangeMode
  5: optional string ChangeSignal
  6: optional i64 Splay
}
struct Config {
  1: optional string image
  2: optional string command
  3: optional map<string,i32> port_map
  4: optional list<string> Args
}
struct Vault {
  1: required list<string> Policies
  2: optional bool Env = 1
  3: optional string ChangeMode = "noop"
  4: optional string ChangeSignal
}
struct Task {
  1: optional list<Artifact> Artifacts
  2: optional Config Config
  3: optional list<Constraint> Constraints
  4: optional string DispatchPayload
  5: required string Driver
  6: optional map<string,string> Env
  7: optional i64 KillTimeout
  8: optional LogConfig LogConfig
  9: optional Meta Meta
  10: required string Name
  11: required Resources Resources
  12: optional list<Service> Services
  13: optional list<Template> Templates
  14: optional string User
  15: optional Vault Vault
}
struct TaskGroup {
  1: optional list<Constraint> Constraints
  2: optional i64 Count
  3: optional Meta Meta
  4: required string Name
  5: optional RestartPolicy RestartPolicy
  6: optional list<Task> Tasks
}
struct Job {
  1: optional bool AllAtOnce
  2: optional list<Constraint> Constraints
  3: optional list<string> Datacenters
  4: optional list<TaskGroup> TaskGroups
  5: optional Meta Meta
  6: optional ParamaterizedJob ParamaterizedJob
  7: optional string Payload
  8: optional i16 Priority = 50
  9: optional string Region
  10: optional string Type
  11: optional Update Update
  12: optional Periodic Periodic
  13: required string Name
  14: required string ID
}

struct NomadJob {
  1: Job Job
  2: optional bool Diff
}


