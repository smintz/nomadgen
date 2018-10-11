struct DockerVolumeDriverConfig {
  1: optional string name
  2: optional list<map<string,string>> options
}
struct DockerVolumeOptions {
  1: optional bool no_copy
  2: optional list<map<string,string>> labels
  3: optional list<DockerVolumeDriverConfig> driver_config
}
struct DockerDriverAuth {
  1: optional string username
  2: optional string server_address
  3: optional string password
  4: optional string email
}
struct DockerLoggingOpts {
  1: optional list<map<string,string>> config
  2: optional string type
}
struct DockerMount {
  1: optional string source
  2: optional bool readonly
  3: optional string target
  4: optional list<DockerVolumeOptions> volume_options
}
struct DockerDevice {
  1: optional string host_path
  2: optional string container_path
  3: optional string cgroup_permissions
}
struct QemuDriverConfig {
  1: optional bool graceful_shutdown
  2: optional list<map<string,i16>> port_map
  3: optional string image_path
  4: optional string accelerator
  5: optional list<string> command_args
}
struct ExecDriverConfig {
  1: optional string command
  2: optional list<string> command_args
}
struct JavaDriverConfig {
  1: optional string class_path
  2: optional list<string> jvm_options
  3: optional string jar_path
  4: optional list<string> command_args
  5: optional string java_class
}
struct RktDriverConfig {
  1: optional list<string> dns_servers
  2: optional string group
  3: optional string image
  4: optional list<string> command_args
  5: optional list<map<string,string>> port_map
  6: optional string trust_prefix
  7: optional list<string> dns_search_domains
  8: optional list<string> insecure_options
  9: optional list<string> volumes
  10: optional bool debug
  11: optional string command
  12: optional list<string> net
  13: optional bool no_overlay
}
struct DockerDriverConfig {
  1: optional string load
  2: optional string ipv6_address
  3: optional list<string> dns_servers
  4: optional list<map<string,string>> sysctl
  5: optional string image
  6: optional list<map<string,string>> labels
  7: optional list<string> network_aliases
  8: optional list<string> command_args
  9: optional bool tty
  10: optional bool force_pull
  11: optional list<string> dns_search_domains
  12: optional string pid_mode
  13: optional string work_dir
  14: optional list<map<string,string>> ulimit
  15: optional string hostname
  16: optional list<string> entrypoint
  17: optional string mac_address
  18: optional string command
  19: optional list<string> security_opt
  20: optional list<string> extra_hosts
  21: optional bool cpu_hard_limit
  22: optional bool auth_soft_fail
  23: optional i64 shm_size
  24: optional bool readonly_rootfs
  25: optional list<map<string,string>> port_map
  26: optional string ipv4_address
  27: optional string volume_driver
  28: optional list<DockerDriverAuth> auth
  29: optional string userns_mode
  30: optional list<DockerLoggingOpts> logging
  31: optional string network_mode
  32: optional string uts_mode
  33: optional list<string> cap_add
  34: optional bool advertise_ipv6_address
  35: optional list<DockerDevice> devices
  36: optional bool privileged
  37: optional list<string> dns_options
  38: optional string ipc_mode
  39: optional list<string> volumes
  40: optional list<DockerMount> mounts
  41: optional list<string> cap_drop
  42: optional bool interactive
}
struct DriverConfig {
  1: optional string load
  2: optional string ipv6_address
  3: optional list<string> dns_servers
  4: optional list<map<string,string>> sysctl
  5: optional string accelerator
  6: optional string class_path
  7: optional string java_class
  8: optional string image
  9: optional list<map<string,string>> labels
  10: optional list<string> network_aliases
  11: optional list<string> command_args
  12: optional bool tty
  13: optional bool force_pull
  14: optional list<string> dns_search_domains
  15: optional string pid_mode
  16: optional string jar_path
  17: optional bool no_overlay
  18: optional string group
  19: optional string work_dir
  20: optional list<map<string,string>> ulimit
  21: optional string hostname
  22: optional list<string> entrypoint
  23: optional string mac_address
  24: optional string command
  25: optional list<string> net
  26: optional bool graceful_shutdown
  27: optional list<string> security_opt
  28: optional bool privileged
  29: optional bool cpu_hard_limit
  30: optional bool auth_soft_fail
  31: optional string image_path
  32: optional i64 shm_size
  33: optional bool readonly_rootfs
  34: optional list<map<string,string>> port_map
  35: optional string trust_prefix
  36: optional string ipv4_address
  37: optional bool debug
  38: optional string volume_driver
  39: optional list<DockerDriverAuth> auth
  40: optional string userns_mode
  41: optional list<DockerLoggingOpts> logging
  42: optional list<string> jvm_options
  43: optional string network_mode
  44: optional string uts_mode
  45: optional string name
  46: optional list<string> cap_add
  47: optional bool advertise_ipv6_address
  48: optional list<DockerDevice> devices
  49: optional list<string> extra_hosts
  50: optional list<string> dns_options
  51: optional string ipc_mode
  52: optional list<string> insecure_options
  53: optional list<string> volumes
  54: optional list<DockerMount> mounts
  55: optional list<string> cap_drop
  56: optional list<map<string,string>> options
  57: optional bool interactive
}
struct Port {
  1: optional i16 Value
  2: optional string Label
}
struct CheckRestart {
  1: optional bool IgnoreWarnings
  2: optional i16 Limit
  3: optional i64 Grace
}
struct NetworkResource {
  1: optional list<Port> ReservedPorts
  2: optional i16 MBits
  3: optional string IP
  4: optional list<Port> DynamicPorts
  5: optional string Device
  6: optional string CIDR
}
struct ServiceCheck {
  1: optional i64 Interval
  2: optional string Protocol
  3: optional string Name
  4: optional string InitialStatus
  5: optional string AddressMode
  6: optional list<string> Args
  7: optional CheckRestart CheckRestart
  8: optional bool TLSSkipVerify
  9: optional map<string,list<string>> Header
  10: optional string Command
  11: optional i64 Timeout
  12: optional string PortLabel
  13: optional string Path
  14: optional string Type
  15: optional string Method
}
struct Constraint {
  1: optional string LTarget
  2: optional string Operand
  3: optional string RTarget
  4: optional string str
}
struct Service {
  1: optional string PortLabel
  2: optional string AddressMode
  3: optional list<ServiceCheck> Checks
  4: optional string Name
  5: optional list<string> Tags
}
struct Resources {
  1: optional i16 MemoryMB
  2: optional i16 IOPS
  3: optional i16 DiskMB
  4: optional i16 CPU
  5: optional list<NetworkResource> Networks
}
struct TaskArtifact {
  1: optional string RelativeDest
  2: optional string GetterSource
  3: optional map<string,string> GetterOptions
  4: optional string GetterMode
}
struct Template {
  1: optional bool Envvars
  2: optional string RightDelim
  3: optional string ChangeMode
  4: optional i64 VaultGrace
  5: optional string SourcePath
  6: optional string DestPath
  7: optional i64 Splay
  8: optional string Perms
  9: optional string LeftDelim
  10: optional string ChangeSignal
  11: optional string EmbeddedTmpl
}
struct DispatchPayloadConfig {
  1: optional string File
}
struct Vault {
  1: optional string ChangeSignal
  2: optional string ChangeMode
  3: optional bool Env
  4: optional list<string> Policies
}
struct LogConfig {
  1: optional i16 MaxFiles
  2: optional i16 MaxFileSizeMB
}
struct FieldDiff {
  1: optional string Type
  2: optional string Name
  3: optional list<string> Annotations
  4: optional string New
  5: optional string Old
}
struct ObjectDiff {
  1: optional list<FieldDiff> Fields
  2: optional list<ObjectDiff> Objects
  3: optional string Type
  4: optional string Name
}
struct UpdateStrategy {
  1: optional bool AutoRevert
  2: optional i16 MaxParallel
  3: optional string HealthCheck
  4: optional i64 MinHealthyTime
  5: optional i64 HealthyDeadline
  6: optional i64 Stagger
  7: optional i16 Canary
}
struct MigrateStrategy {
  1: optional i16 MaxParallel
  2: optional string HealthCheck
  3: optional i64 HealthyDeadline
  4: optional i64 MinHealthyTime
}
struct Task {
  1: optional list<Template> Templates
  2: optional i64 ShutdownDelay
  3: optional string KillSignal
  4: optional string Name
  5: optional DispatchPayloadConfig DispatchPayload
  6: optional list<TaskArtifact> Artifacts
  7: optional i64 KillTimeout
  8: optional string Driver
  9: optional bool Leader
  10: optional map<string,string> Meta
  11: optional string User
  12: optional map<string,string> Env
  13: optional list<Service> Services
  14: optional Vault Vault
  15: optional DriverConfig Config
  16: optional LogConfig LogConfig
  17: optional Resources Resources
  18: optional list<Constraint> Constraints
}
struct ReschedulePolicy {
  1: optional i64 MaxDelay
  2: optional string DelayFunction
  3: optional i64 Interval
  4: optional bool Unlimited
  5: optional i64 Delay
  6: optional i16 Attempts
}
struct TaskDiff {
  1: optional list<FieldDiff> Fields
  2: optional list<ObjectDiff> Objects
  3: optional string Type
  4: optional string Name
  5: optional list<string> Annotations
}
struct TaskEvent {
  1: optional string DisplayMessage
  2: optional string TaskSignal
  3: optional i64 KillTimeout
  4: optional string VaultError
  5: optional map<string,string> Details
  6: optional string TaskSignalReason
  7: optional string Type
  8: optional i64 DiskLimit
  9: optional string DriverError
  10: optional string KillReason
  11: optional bool FailsTask
  12: optional string FailedSibling
  13: optional string ValidationError
  14: optional i16 Signal
  15: optional string KillError
  16: optional string DownloadError
  17: optional i64 Time
  18: optional string RestartReason
  19: optional string DriverMessage
  20: optional i64 StartDelay
  21: optional string GenericSource
  22: optional string SetupError
  23: optional string Message
  24: optional i16 ExitCode
}
struct EphemeralDisk {
  1: optional i16 SizeMB
  2: optional bool Migrate
  3: optional bool Sticky
}
struct RestartPolicy {
  1: optional i64 Delay
  2: optional i16 Attempts
  3: optional i64 Interval
  4: optional string Mode
}
struct AllocMetric {
  1: optional list<string> QuotaExhausted
  2: optional i16 NodesExhausted
  3: optional i64 AllocationTime
  4: optional map<string,i16> ClassFiltered
  5: optional i16 CoalescedFailures
  6: optional i16 NodesFiltered
  7: optional map<string,double> Scores
  8: optional map<string,i16> ConstraintFiltered
  9: optional map<string,i16> ClassExhausted
  10: optional map<string,i16> DimensionExhausted
  11: optional i16 NodesEvaluated
  12: optional map<string,i16> NodesAvailable
}
struct TaskGroupDiff {
  1: optional list<TaskDiff> Tasks
  2: optional string Name
  3: optional list<FieldDiff> Fields
  4: optional list<ObjectDiff> Objects
  5: optional map<string,i64> Updates
  6: optional string Type
}
struct TaskGroup {
  1: optional i16 Count
  2: optional list<Task> Tasks
  3: optional string Name
  4: optional ReschedulePolicy ReschedulePolicy
  5: optional EphemeralDisk EphemeralDisk
  6: optional MigrateStrategy Migrate
  7: optional UpdateStrategy Update
  8: optional RestartPolicy RestartPolicy
  9: optional map<string,string> Meta
  10: optional list<Constraint> Constraints
}
struct PeriodicConfig {
  1: optional bool Enabled
  2: optional i64 location
  3: optional string SpecType
  4: optional string TimeZone
  5: optional string Spec
  6: optional bool ProhibitOverlap
}
struct AllocDeploymentStatus {
  1: optional bool Healthy
  2: optional i64 ModifyIndex
}
struct TaskState {
  1: optional string LastRestart
  2: optional i64 Restarts
  3: optional bool Failed
  4: optional string State
  5: optional string FinishedAt
  6: optional string StartedAt
  7: optional list<TaskEvent> Events
}
struct DeploymentState {
  1: optional bool AutoRevert
  2: optional i16 DesiredTotal
  3: optional list<string> PlacedCanaries
  4: optional i16 HealthyAllocs
  5: optional i16 DesiredCanaries
  6: optional bool Promoted
  7: optional i16 PlacedAllocs
  8: optional i16 UnhealthyAllocs
}
struct DesiredUpdates {
  1: optional i64 InPlaceUpdate
  2: optional i64 Migrate
  3: optional i64 DestructiveUpdate
  4: optional i64 Stop
  5: optional i64 Canary
  6: optional i64 Ignore
  7: optional i64 Place
}
struct ParameterizedJobConfig {
  1: optional list<string> MetaRequired
  2: optional string Payload
  3: optional list<string> MetaOptional
}
struct AllocListStub {
  1: optional i64 CreateIndex
  2: optional string FollowupEvalID
  3: optional AllocDeploymentStatus DeploymentStatus
  4: optional i64 JobVersion
  5: optional map<string,TaskState> TaskStates
  6: optional string NodeID
  7: optional string DesiredDescription
  8: optional string JobID
  9: optional string ClientDescription
  10: optional i64 CreateTime
  11: optional i64 ModifyTime
  12: optional string ClientStatus
  13: optional i64 ModifyIndex
  14: optional string DesiredStatus
  15: optional string EvalID
  16: optional string TaskGroup
  17: optional string ID
  18: optional string Name
}
struct Evaluation {
  1: optional string PreviousEval
  2: optional string Namespace
  3: optional i64 ModifyIndex
  4: optional string JobID
  5: optional i16 Priority
  6: optional string WaitUntil
  7: optional i64 CreateIndex
  8: optional string Type
  9: optional string TriggeredBy
  10: optional string Status
  11: optional bool AnnotatePlan
  12: optional map<string,i16> QueuedAllocations
  13: optional string NextEval
  14: optional i64 JobModifyIndex
  15: optional string ID
  16: optional string LeaderACL
  17: optional bool EscapedComputedClass
  18: optional i64 Wait
  19: optional map<string,bool> ClassEligibility
  20: optional map<string,AllocMetric> FailedTGAllocs
  21: optional string StatusDescription
  22: optional string QuotaLimitReached
  23: optional string NodeID
  24: optional i64 SnapshotIndex
  25: optional string BlockedEval
  26: optional string DeploymentID
  27: optional i64 NodeModifyIndex
}
struct JobDiff {
  1: optional list<FieldDiff> Fields
  2: optional list<ObjectDiff> Objects
  3: optional string Type
  4: optional string ID
  5: optional list<TaskGroupDiff> TaskGroups
}
struct Job {
  1: optional string Namespace
  2: optional i64 ModifyIndex
  3: optional i16 Priority
  4: optional i64 Version
  5: optional list<TaskGroup> TaskGroups
  6: optional bool Stable
  7: optional i64 CreateIndex
  8: optional string Type
  9: optional string Status
  10: optional bool AllAtOnce
  11: optional i64 JobModifyIndex
  12: optional bool Stop
  13: optional UpdateStrategy Update
  14: optional string ID
  15: optional ParameterizedJobConfig ParameterizedJob
  16: optional string Name
  17: optional string Region
  18: optional PeriodicConfig Periodic
  19: optional list<string> Datacenters
  20: optional string StatusDescription
  21: optional list<Constraint> Constraints
  22: optional string VaultToken
  23: optional i64 SubmitTime
  24: optional map<string,string> Meta
  25: optional string ParentID
  26: optional list<byte> Payload
}
struct Deployment {
  1: optional string Status
  2: optional i64 CreateIndex
  3: optional i64 JobVersion
  4: optional i64 JobModifyIndex
  5: optional string Namespace
  6: optional i64 ModifyIndex
  7: optional string ID
  8: optional string StatusDescription
  9: optional map<string,DeploymentState> TaskGroups
  10: optional string JobID
  11: optional i64 JobCreateIndex
}
struct PlanAnnotations {
  1: optional map<string,DesiredUpdates> DesiredTGUpdates
}
struct JobPlanResponse {
  1: optional i64 Index
  2: optional string NextPeriodicLaunch
  3: optional string Warnings
  4: optional list<Evaluation> CreatedEvals
  5: optional i64 JobModifyIndex
  6: optional JobDiff Diff
  7: optional map<string,AllocMetric> FailedTGAllocs
  8: optional PlanAnnotations Annotations
}
struct JobPlanRequest {
  1: optional bool PolicyOverride
  2: optional bool Diff
  3: optional Job Job
}
struct DeploymentListResponse {
  1: optional i64 Index
  2: optional i64 LastContact
  3: optional bool KnownLeader
  4: optional list<Deployment> Deployments
}
struct WriteMeta {
  1: optional i64 Index
}
struct QueryMeta {
  1: optional i64 Index
  2: optional bool KnownLeader
  3: optional i64 LastContact
}
struct DeploymentPromoteRequest {
  1: optional string DeploymentID
  2: optional bool All
  3: optional list<string> Groups
}
struct JobRegisterResponse {
  1: optional i64 Index
  2: optional string Warnings
  3: optional i64 JobModifyIndex
  4: optional i64 LastContact
  5: optional i64 EvalCreateIndex
  6: optional bool KnownLeader
  7: optional string EvalID
}
struct JobAllocationsResponse {
  1: optional i64 Index
  2: optional bool KnownLeader
  3: optional list<AllocListStub> Allocations
  4: optional i64 LastContact
}
struct JobRegisterRequest {
  1: optional bool PolicyOverride
  2: optional Job Job
  3: optional i64 JobModifyIndex
  4: optional bool EnforceIndex
}
struct JobDeregisterResponse {
  1: optional i64 Index
  2: optional i64 JobModifyIndex
  3: optional i64 LastContact
  4: optional i64 EvalCreateIndex
  5: optional bool KnownLeader
  6: optional string EvalID
}
