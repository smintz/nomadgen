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
  2: optional string password
  3: optional string email
  4: optional string server_address
}
struct DockerLoggingOpts {
  1: optional string type
  2: optional list<map<string,string>> config
}
struct DockerMount {
  1: optional string target
  2: optional string source
  3: optional bool readonly
  4: optional list<DockerVolumeOptions> volume_options
}
struct DockerDevice {
  1: optional string host_path
  2: optional string container_path
  3: optional string cgroup_permissions
}
struct DockerDriverConfig {
  1: optional string image
  2: optional string load
  3: optional string command
  4: optional list<string> command_args
  5: optional list<string> entrypoint
  6: optional string ipc_mode
  7: optional string network_mode
  8: optional list<string> network_aliases
  9: optional string ipv4_address
  10: optional string ipv6_address
  11: optional string pid_mode
  12: optional string uts_mode
  13: optional string userns_mode
  14: optional list<map<string,string>> port_map
  15: optional bool privileged
  16: optional list<map<string,string>> sysctl
  17: optional list<map<string,string>> ulimit
  18: optional list<string> dns_servers
  19: optional list<string> dns_search_domains
  20: optional list<string> dns_options
  21: optional list<string> extra_hosts
  22: optional string hostname
  23: optional list<map<string,string>> labels
  24: optional list<DockerDriverAuth> auth
  25: optional bool auth_soft_fail
  26: optional bool tty
  27: optional bool interactive
  28: optional i64 shm_size
  29: optional string work_dir
  30: optional list<DockerLoggingOpts> logging
  31: optional list<string> volumes
  32: optional list<DockerMount> mounts
  33: optional string volume_driver
  34: optional bool force_pull
  35: optional string mac_address
  36: optional list<string> security_opt
  37: optional list<DockerDevice> devices
  38: optional list<string> cap_add
  39: optional list<string> cap_drop
  40: optional bool readonly_rootfs
  41: optional bool advertise_ipv6_address
  42: optional bool cpu_hard_limit
  43: optional i64 pids_limit
}
struct ExecDriverConfig {
  1: optional string command
  2: optional list<string> command_args
}
struct QemuDriverConfig {
  1: optional string image_path
  2: optional string accelerator
  3: optional bool graceful_shutdown
  4: optional list<map<string,i16>> port_map
  5: optional list<string> command_args
}
struct JavaDriverConfig {
  1: optional string java_class
  2: optional string class_path
  3: optional string jar_path
  4: optional list<string> jvm_options
  5: optional list<string> command_args
}
struct RktDriverConfig {
  1: optional string image
  2: optional string command
  3: optional list<string> command_args
  4: optional string trust_prefix
  5: optional list<string> dns_servers
  6: optional list<string> dns_search_domains
  7: optional list<string> net
  8: optional list<map<string,string>> port_map
  9: optional list<string> volumes
  10: optional list<string> insecure_options
  11: optional bool no_overlay
  12: optional bool debug
  13: optional string group
}
struct DriverConfig {
  1: optional string name
  2: optional list<map<string,string>> options
  3: optional string image
  4: optional string load
  5: optional string command
  6: optional list<string> command_args
  7: optional list<string> entrypoint
  8: optional string ipc_mode
  9: optional string network_mode
  10: optional list<string> network_aliases
  11: optional string ipv4_address
  12: optional string ipv6_address
  13: optional string pid_mode
  14: optional string uts_mode
  15: optional string userns_mode
  16: optional list<map<string,string>> port_map
  17: optional bool privileged
  18: optional list<map<string,string>> sysctl
  19: optional list<map<string,string>> ulimit
  20: optional list<string> dns_servers
  21: optional list<string> dns_search_domains
  22: optional list<string> dns_options
  23: optional list<string> extra_hosts
  24: optional string hostname
  25: optional list<map<string,string>> labels
  26: optional list<DockerDriverAuth> auth
  27: optional bool auth_soft_fail
  28: optional bool tty
  29: optional bool interactive
  30: optional i64 shm_size
  31: optional string work_dir
  32: optional list<DockerLoggingOpts> logging
  33: optional list<string> volumes
  34: optional list<DockerMount> mounts
  35: optional string volume_driver
  36: optional bool force_pull
  37: optional string mac_address
  38: optional list<string> security_opt
  39: optional list<DockerDevice> devices
  40: optional list<string> cap_add
  41: optional list<string> cap_drop
  42: optional bool readonly_rootfs
  43: optional bool advertise_ipv6_address
  44: optional bool cpu_hard_limit
  45: optional i64 pids_limit
  46: optional string image_path
  47: optional string accelerator
  48: optional bool graceful_shutdown
  49: optional string java_class
  50: optional string class_path
  51: optional string jar_path
  52: optional list<string> jvm_options
  53: optional string trust_prefix
  54: optional list<string> net
  55: optional list<string> insecure_options
  56: optional bool no_overlay
  57: optional bool debug
  58: optional string group
}
struct Port {
  1: optional string Label
  2: optional i16 Value
}
struct CheckRestart {
  1: optional i16 Limit
  2: optional i64 Grace
  3: optional bool IgnoreWarnings
}
struct ServiceCheck {
  1: optional string Name
  2: optional string Type
  3: optional string Command
  4: optional list<string> Args
  5: optional string Path
  6: optional string Protocol
  7: optional string PortLabel
  8: optional string AddressMode
  9: optional i64 Interval
  10: optional i64 Timeout
  11: optional string InitialStatus
  12: optional bool TLSSkipVerify
  13: optional string Method
  14: optional map<string,list<string>> Header
  15: optional CheckRestart CheckRestart
  16: optional string GRPCService
  17: optional bool GRPCUseTLS
}
struct NetworkResource {
  1: optional string Device
  2: optional string CIDR
  3: optional string IP
  4: optional i16 MBits
  5: optional list<Port> ReservedPorts
  6: optional list<Port> DynamicPorts
}
struct Service {
  1: optional string Name
  2: optional string PortLabel
  3: optional string AddressMode
  4: optional list<string> Tags
  5: optional list<string> CanaryTags
  6: optional list<ServiceCheck> Checks
}
struct Vault {
  1: optional list<string> Policies
  2: optional bool Env
  3: optional string ChangeMode
  4: optional string ChangeSignal
}
struct Template {
  1: optional string SourcePath
  2: optional string DestPath
  3: optional string EmbeddedTmpl
  4: optional string ChangeMode
  5: optional string ChangeSignal
  6: optional i64 Splay
  7: optional string Perms
  8: optional string LeftDelim
  9: optional string RightDelim
  10: optional bool Envvars
  11: optional i64 VaultGrace
}
struct Resources {
  1: optional i16 CPU
  2: optional i16 MemoryMB
  3: optional i16 DiskMB
  4: optional i16 IOPS
  5: optional list<NetworkResource> Networks
}
struct DispatchPayloadConfig {
  1: optional string File
}
struct LogConfig {
  1: optional i16 MaxFiles
  2: optional i16 MaxFileSizeMB
}
struct TaskArtifact {
  1: optional string GetterSource
  2: optional map<string,string> GetterOptions
  3: optional string GetterMode
  4: optional string RelativeDest
}
struct FieldDiff {
  1: optional string Type
  2: optional string Name
  3: optional list<string> Annotations
  4: optional string New
  5: optional string Old
}
struct ObjectDiff {
  1: optional string Type
  2: optional string Name
  3: optional list<FieldDiff> Fields
  4: optional list<ObjectDiff> Objects
}
struct UpdateStrategy {
  1: optional i64 Stagger
  2: optional i16 MaxParallel
  3: optional string HealthCheck
  4: optional i64 MinHealthyTime
  5: optional i64 HealthyDeadline
  6: optional i64 ProgressDeadline
  7: optional bool AutoRevert
  8: optional i16 Canary
}
struct TaskEvent {
  1: optional string Type
  2: optional i64 Time
  3: optional string Message
  4: optional string DisplayMessage
  5: optional map<string,string> Details
  6: optional bool FailsTask
  7: optional string RestartReason
  8: optional string SetupError
  9: optional string DriverError
  10: optional i16 ExitCode
  11: optional i16 Signal
  12: optional i64 KillTimeout
  13: optional string KillError
  14: optional string KillReason
  15: optional i64 StartDelay
  16: optional string DownloadError
  17: optional string ValidationError
  18: optional i64 DiskLimit
  19: optional string FailedSibling
  20: optional string VaultError
  21: optional string TaskSignalReason
  22: optional string TaskSignal
  23: optional string DriverMessage
  24: optional string GenericSource
}
struct RescheduleEvent {
  1: optional i64 RescheduleTime
  2: optional string PrevAllocID
  3: optional string PrevNodeID
  4: optional i64 Delay
}
struct Constraint {
  1: optional string LTarget
  2: optional string RTarget
  3: optional string Operand
  4: optional string str
}
struct MigrateStrategy {
  1: optional i16 MaxParallel
  2: optional string HealthCheck
  3: optional i64 MinHealthyTime
  4: optional i64 HealthyDeadline
}
struct RestartPolicy {
  1: optional i16 Attempts
  2: optional i64 Interval
  3: optional i64 Delay
  4: optional string Mode
}
struct Task {
  1: optional string Name
  2: optional string Driver
  3: optional string User
  4: optional DriverConfig Config
  5: optional map<string,string> Env
  6: optional list<Service> Services
  7: optional Vault Vault
  8: optional list<Template> Templates
  9: optional list<Constraint> Constraints
  10: optional Resources Resources
  11: optional DispatchPayloadConfig DispatchPayload
  12: optional map<string,string> Meta
  13: optional i64 KillTimeout
  14: optional LogConfig LogConfig
  15: optional list<TaskArtifact> Artifacts
  16: optional bool Leader
  17: optional i64 ShutdownDelay
  18: optional string KillSignal
}
struct EphemeralDisk {
  1: optional bool Sticky
  2: optional i16 SizeMB
  3: optional bool Migrate
}
struct ReschedulePolicy {
  1: optional i16 Attempts
  2: optional i64 Interval
  3: optional i64 Delay
  4: optional string DelayFunction
  5: optional i64 MaxDelay
  6: optional bool Unlimited
}
struct TaskDiff {
  1: optional string Type
  2: optional string Name
  3: optional list<FieldDiff> Fields
  4: optional list<ObjectDiff> Objects
  5: optional list<string> Annotations
}
struct DeploymentState {
  1: optional bool AutoRevert
  2: optional i64 ProgressDeadline
  3: optional string RequireProgressBy
  4: optional bool Promoted
  5: optional list<string> PlacedCanaries
  6: optional i16 DesiredCanaries
  7: optional i16 DesiredTotal
  8: optional i16 PlacedAllocs
  9: optional i16 HealthyAllocs
  10: optional i16 UnhealthyAllocs
}
struct DesiredTransition {
  1: optional bool Migrate
  2: optional bool Reschedule
  3: optional bool ForceReschedule
}
struct TaskState {
  1: optional string State
  2: optional bool Failed
  3: optional i64 Restarts
  4: optional string LastRestart
  5: optional string StartedAt
  6: optional string FinishedAt
  7: optional list<TaskEvent> Events
}
struct AllocDeploymentStatus {
  1: optional bool Healthy
  2: optional string Timestamp
  3: optional bool Canary
  4: optional i64 ModifyIndex
}
struct RescheduleTracker {
  1: optional list<RescheduleEvent> Events
}
struct TaskGroup {
  1: optional string Name
  2: optional i16 Count
  3: optional UpdateStrategy Update
  4: optional MigrateStrategy Migrate
  5: optional list<Constraint> Constraints
  6: optional RestartPolicy RestartPolicy
  7: optional list<Task> Tasks
  8: optional EphemeralDisk EphemeralDisk
  9: optional map<string,string> Meta
  10: optional ReschedulePolicy ReschedulePolicy
}
struct PeriodicConfig {
  1: optional bool Enabled
  2: optional string Spec
  3: optional string SpecType
  4: optional bool ProhibitOverlap
  5: optional string TimeZone
  6: optional i64 location
}
struct ParameterizedJobConfig {
  1: optional string Payload
  2: optional list<string> MetaRequired
  3: optional list<string> MetaOptional
}
struct DesiredUpdates {
  1: optional i64 Ignore
  2: optional i64 Place
  3: optional i64 Migrate
  4: optional i64 Stop
  5: optional i64 InPlaceUpdate
  6: optional i64 DestructiveUpdate
  7: optional i64 Canary
}
struct TaskGroupDiff {
  1: optional string Type
  2: optional string Name
  3: optional list<FieldDiff> Fields
  4: optional list<ObjectDiff> Objects
  5: optional list<TaskDiff> Tasks
  6: optional map<string,i64> Updates
}
struct AllocMetric {
  1: optional i16 NodesEvaluated
  2: optional i16 NodesFiltered
  3: optional map<string,i16> NodesAvailable
  4: optional map<string,i16> ClassFiltered
  5: optional map<string,i16> ConstraintFiltered
  6: optional i16 NodesExhausted
  7: optional map<string,i16> ClassExhausted
  8: optional map<string,i16> DimensionExhausted
  9: optional list<string> QuotaExhausted
  10: optional map<string,double> Scores
  11: optional i64 AllocationTime
  12: optional i16 CoalescedFailures
}
struct Deployment {
  1: optional string ID
  2: optional string Namespace
  3: optional string JobID
  4: optional i64 JobVersion
  5: optional i64 JobModifyIndex
  6: optional i64 JobSpecModifyIndex
  7: optional i64 JobCreateIndex
  8: optional map<string,DeploymentState> TaskGroups
  9: optional string Status
  10: optional string StatusDescription
  11: optional i64 CreateIndex
  12: optional i64 ModifyIndex
}
struct AllocListStub {
  1: optional string ID
  2: optional string EvalID
  3: optional string Name
  4: optional string NodeID
  5: optional string JobID
  6: optional i64 JobVersion
  7: optional string TaskGroup
  8: optional string DesiredStatus
  9: optional string DesiredDescription
  10: optional string ClientStatus
  11: optional string ClientDescription
  12: optional DesiredTransition DesiredTransition
  13: optional map<string,TaskState> TaskStates
  14: optional AllocDeploymentStatus DeploymentStatus
  15: optional string FollowupEvalID
  16: optional RescheduleTracker RescheduleTracker
  17: optional i64 CreateIndex
  18: optional i64 ModifyIndex
  19: optional i64 CreateTime
  20: optional i64 ModifyTime
}
struct Job {
  1: optional bool Stop
  2: optional string Region
  3: optional string Namespace
  4: optional string ID
  5: optional string ParentID
  6: optional string Name
  7: optional string Type
  8: optional i16 Priority
  9: optional bool AllAtOnce
  10: optional list<string> Datacenters
  11: optional list<Constraint> Constraints
  12: optional list<TaskGroup> TaskGroups
  13: optional UpdateStrategy Update
  14: optional PeriodicConfig Periodic
  15: optional ParameterizedJobConfig ParameterizedJob
  16: optional bool Dispatched
  17: optional list<byte> Payload
  18: optional map<string,string> Meta
  19: optional string VaultToken
  20: optional string Status
  21: optional string StatusDescription
  22: optional bool Stable
  23: optional i64 Version
  24: optional i64 SubmitTime
  25: optional i64 CreateIndex
  26: optional i64 ModifyIndex
  27: optional i64 JobModifyIndex
}
struct PlanAnnotations {
  1: optional map<string,DesiredUpdates> DesiredTGUpdates
}
struct Evaluation {
  1: optional string ID
  2: optional string Namespace
  3: optional i16 Priority
  4: optional string Type
  5: optional string TriggeredBy
  6: optional string JobID
  7: optional i64 JobModifyIndex
  8: optional string NodeID
  9: optional i64 NodeModifyIndex
  10: optional string DeploymentID
  11: optional string Status
  12: optional string StatusDescription
  13: optional i64 Wait
  14: optional string WaitUntil
  15: optional string NextEval
  16: optional string PreviousEval
  17: optional string BlockedEval
  18: optional map<string,AllocMetric> FailedTGAllocs
  19: optional map<string,bool> ClassEligibility
  20: optional string QuotaLimitReached
  21: optional bool EscapedComputedClass
  22: optional bool AnnotatePlan
  23: optional map<string,i16> QueuedAllocations
  24: optional string LeaderACL
  25: optional i64 SnapshotIndex
  26: optional i64 CreateIndex
  27: optional i64 ModifyIndex
}
struct JobDiff {
  1: optional string Type
  2: optional string ID
  3: optional list<FieldDiff> Fields
  4: optional list<ObjectDiff> Objects
  5: optional list<TaskGroupDiff> TaskGroups
}
struct QueryMeta {
  1: optional i64 Index
  2: optional i64 LastContact
  3: optional bool KnownLeader
}
struct WriteMeta {
  1: optional i64 Index
}
struct DeploymentListResponse {
  1: optional list<Deployment> Deployments
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
}
struct DeploymentPromoteRequest {
  1: optional string DeploymentID
  2: optional bool All
  3: optional list<string> Groups
}
struct JobAllocationsResponse {
  1: optional list<AllocListStub> Allocations
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
}
struct JobPlanRequest {
  1: optional Job Job
  2: optional bool Diff
  3: optional bool PolicyOverride
}
struct JobPlanResponse {
  1: optional PlanAnnotations Annotations
  2: optional map<string,AllocMetric> FailedTGAllocs
  3: optional i64 JobModifyIndex
  4: optional list<Evaluation> CreatedEvals
  5: optional JobDiff Diff
  6: optional string NextPeriodicLaunch
  7: optional string Warnings
  8: optional i64 Index
}
struct JobDeregisterResponse {
  1: optional string EvalID
  2: optional i64 EvalCreateIndex
  3: optional i64 JobModifyIndex
  4: optional i64 Index
  5: optional i64 LastContact
  6: optional bool KnownLeader
}
struct JobRegisterRequest {
  1: optional Job Job
  2: optional bool EnforceIndex
  3: optional i64 JobModifyIndex
  4: optional bool PolicyOverride
}
struct JobRegisterResponse {
  1: optional string EvalID
  2: optional i64 EvalCreateIndex
  3: optional i64 JobModifyIndex
  4: optional string Warnings
  5: optional i64 Index
  6: optional i64 LastContact
  7: optional bool KnownLeader
}
