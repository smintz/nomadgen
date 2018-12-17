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
  1: optional string accelerator
  2: optional bool graceful_shutdown
  3: optional string image_path
  4: optional list<map<string,i16>> port_map
  5: optional list<string> command_args
}
struct ExecDriverConfig {
  1: optional string command
  2: optional list<string> command_args
}
struct JavaDriverConfig {
  1: optional string class_path
  2: optional list<string> jvm_options
  3: optional string java_class
  4: optional list<string> command_args
  5: optional string jar_path
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
  18: optional i64 pids_limit
  19: optional list<string> security_opt
  20: optional list<string> extra_hosts
  21: optional bool cpu_hard_limit
  22: optional bool auth_soft_fail
  23: optional string ipc_mode
  24: optional i64 shm_size
  25: optional bool readonly_rootfs
  26: optional list<map<string,string>> port_map
  27: optional string ipv4_address
  28: optional string volume_driver
  29: optional list<string> dns_options
  30: optional list<DockerDriverAuth> auth
  31: optional string userns_mode
  32: optional string network_mode
  33: optional list<DockerLoggingOpts> logging
  34: optional list<string> cap_add
  35: optional bool advertise_ipv6_address
  36: optional list<DockerDevice> devices
  37: optional bool privileged
  38: optional string uts_mode
  39: optional string command
  40: optional list<string> volumes
  41: optional list<DockerMount> mounts
  42: optional list<string> cap_drop
  43: optional bool interactive
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
  17: optional i64 pids_limit
  18: optional string group
  19: optional string work_dir
  20: optional list<map<string,string>> ulimit
  21: optional string hostname
  22: optional list<string> entrypoint
  23: optional string mac_address
  24: optional bool no_overlay
  25: optional string command
  26: optional list<string> net
  27: optional bool graceful_shutdown
  28: optional list<string> security_opt
  29: optional bool privileged
  30: optional bool cpu_hard_limit
  31: optional bool auth_soft_fail
  32: optional string image_path
  33: optional i64 shm_size
  34: optional bool readonly_rootfs
  35: optional list<map<string,string>> port_map
  36: optional string trust_prefix
  37: optional string ipv4_address
  38: optional bool debug
  39: optional string volume_driver
  40: optional list<DockerDriverAuth> auth
  41: optional string userns_mode
  42: optional list<DockerLoggingOpts> logging
  43: optional list<string> jvm_options
  44: optional string network_mode
  45: optional string uts_mode
  46: optional string name
  47: optional list<string> cap_add
  48: optional bool advertise_ipv6_address
  49: optional list<DockerDevice> devices
  50: optional list<string> extra_hosts
  51: optional list<string> dns_options
  52: optional string ipc_mode
  53: optional list<string> insecure_options
  54: optional list<string> volumes
  55: optional list<DockerMount> mounts
  56: optional list<string> cap_drop
  57: optional list<map<string,string>> options
  58: optional bool interactive
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
  1: optional list<string> Args
  2: optional string Protocol
  3: optional string Name
  4: optional string GRPCService
  5: optional string InitialStatus
  6: optional string AddressMode
  7: optional i64 Interval
  8: optional CheckRestart CheckRestart
  9: optional bool GRPCUseTLS
  10: optional bool TLSSkipVerify
  11: optional map<string,list<string>> Header
  12: optional string Command
  13: optional i64 Timeout
  14: optional string PortLabel
  15: optional string Path
  16: optional string Type
  17: optional string Method
}
struct Constraint {
  1: optional string LTarget
  2: optional string Operand
  3: optional string RTarget
  4: optional string str
}
struct Service {
  1: optional list<string> CanaryTags
  2: optional string Name
  3: optional list<string> Tags
  4: optional string AddressMode
  5: optional string PortLabel
  6: optional list<ServiceCheck> Checks
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
  3: optional list<string> Policies
  4: optional bool Env
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
  4: optional i64 ProgressDeadline
  5: optional i64 MinHealthyTime
  6: optional i64 HealthyDeadline
  7: optional i64 Stagger
  8: optional i16 Canary
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
  3: optional string Name
  4: optional DispatchPayloadConfig DispatchPayload
  5: optional list<TaskArtifact> Artifacts
  6: optional i64 KillTimeout
  7: optional string Driver
  8: optional map<string,string> Env
  9: optional LogConfig LogConfig
  10: optional map<string,string> Meta
  11: optional string User
  12: optional string KillSignal
  13: optional list<Service> Services
  14: optional Vault Vault
  15: optional DriverConfig Config
  16: optional bool Leader
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
  1: optional i64 DiskLimit
  2: optional string DisplayMessage
  3: optional string TaskSignal
  4: optional i64 KillTimeout
  5: optional string VaultError
  6: optional map<string,string> Details
  7: optional string TaskSignalReason
  8: optional string Type
  9: optional bool FailsTask
  10: optional string DriverError
  11: optional string KillReason
  12: optional string GenericSource
  13: optional string FailedSibling
  14: optional string ValidationError
  15: optional i16 Signal
  16: optional string KillError
  17: optional string DownloadError
  18: optional i64 Time
  19: optional string RestartReason
  20: optional string DriverMessage
  21: optional i64 StartDelay
  22: optional string SetupError
  23: optional string Message
  24: optional i16 ExitCode
}
struct EphemeralDisk {
  1: optional i16 SizeMB
  2: optional bool Migrate
  3: optional bool Sticky
}
struct RescheduleEvent {
  1: optional i64 Delay
  2: optional string PrevNodeID
  3: optional string PrevAllocID
  4: optional i64 RescheduleTime
}
struct RestartPolicy {
  1: optional i64 Delay
  2: optional i16 Attempts
  3: optional i64 Interval
  4: optional string Mode
}
struct AllocMetric {
  1: optional i16 NodesExhausted
  2: optional i64 AllocationTime
  3: optional map<string,i16> ClassFiltered
  4: optional i16 NodesFiltered
  5: optional map<string,double> Scores
  6: optional map<string,i16> ConstraintFiltered
  7: optional i16 CoalescedFailures
  8: optional map<string,i16> ClassExhausted
  9: optional list<string> QuotaExhausted
  10: optional i16 NodesEvaluated
  11: optional map<string,i16> DimensionExhausted
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
struct RescheduleTracker {
  1: optional list<RescheduleEvent> Events
}
struct PeriodicConfig {
  1: optional bool Enabled
  2: optional i64 location
  3: optional string TimeZone
  4: optional string SpecType
  5: optional string Spec
  6: optional bool ProhibitOverlap
}
struct DesiredTransition {
  1: optional bool Migrate
  2: optional bool Reschedule
  3: optional bool ForceReschedule
}
struct AllocDeploymentStatus {
  1: optional bool Healthy
  2: optional string Timestamp
  3: optional i64 ModifyIndex
  4: optional bool Canary
}
struct TaskState {
  1: optional string State
  2: optional i64 Restarts
  3: optional bool Failed
  4: optional string LastRestart
  5: optional string FinishedAt
  6: optional string StartedAt
  7: optional list<TaskEvent> Events
}
struct DeploymentState {
  1: optional bool AutoRevert
  2: optional i16 DesiredTotal
  3: optional list<string> PlacedCanaries
  4: optional i64 ProgressDeadline
  5: optional i16 HealthyAllocs
  6: optional i16 DesiredCanaries
  7: optional string RequireProgressBy
  8: optional bool Promoted
  9: optional i16 PlacedAllocs
  10: optional i16 UnhealthyAllocs
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
  1: optional i64 ModifyIndex
  2: optional string EvalID
  3: optional i64 JobVersion
  4: optional string ClientStatus
  5: optional DesiredTransition DesiredTransition
  6: optional AllocDeploymentStatus DeploymentStatus
  7: optional string JobID
  8: optional string NodeID
  9: optional string DesiredDescription
  10: optional string FollowupEvalID
  11: optional string ClientDescription
  12: optional string Name
  13: optional i64 ModifyTime
  14: optional string DesiredStatus
  15: optional string ID
  16: optional i64 CreateIndex
  17: optional string TaskGroup
  18: optional i64 CreateTime
  19: optional RescheduleTracker RescheduleTracker
  20: optional map<string,TaskState> TaskStates
}
struct Evaluation {
  1: optional string PreviousEval
  2: optional string Namespace
  3: optional i64 ModifyIndex
  4: optional string JobID
  5: optional i16 Priority
  6: optional string WaitUntil
  7: optional i64 CreateIndex
  8: optional string LeaderACL
  9: optional string TriggeredBy
  10: optional string Status
  11: optional bool AnnotatePlan
  12: optional string BlockedEval
  13: optional string NextEval
  14: optional i64 JobModifyIndex
  15: optional string ID
  16: optional bool EscapedComputedClass
  17: optional i64 Wait
  18: optional map<string,bool> ClassEligibility
  19: optional map<string,AllocMetric> FailedTGAllocs
  20: optional string StatusDescription
  21: optional string Type
  22: optional string QuotaLimitReached
  23: optional string NodeID
  24: optional i64 SnapshotIndex
  25: optional map<string,i16> QueuedAllocations
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
  1: optional i64 JobModifyIndex
  2: optional string Namespace
  3: optional i64 ModifyIndex
  4: optional i16 Priority
  5: optional i64 Version
  6: optional list<TaskGroup> TaskGroups
  7: optional bool Stable
  8: optional i64 CreateIndex
  9: optional string Type
  10: optional string Status
  11: optional bool AllAtOnce
  12: optional bool Dispatched
  13: optional bool Stop
  14: optional UpdateStrategy Update
  15: optional string ID
  16: optional ParameterizedJobConfig ParameterizedJob
  17: optional string Name
  18: optional string Region
  19: optional PeriodicConfig Periodic
  20: optional list<string> Datacenters
  21: optional string StatusDescription
  22: optional list<Constraint> Constraints
  23: optional string VaultToken
  24: optional i64 SubmitTime
  25: optional map<string,string> Meta
  26: optional string ParentID
  27: optional list<byte> Payload
}
struct Deployment {
  1: optional i64 JobSpecModifyIndex
  2: optional string Status
  3: optional i64 JobVersion
  4: optional i64 JobModifyIndex
  5: optional string Namespace
  6: optional i64 ModifyIndex
  7: optional string JobID
  8: optional i64 JobCreateIndex
  9: optional map<string,DeploymentState> TaskGroups
  10: optional string ID
  11: optional i64 CreateIndex
  12: optional string StatusDescription
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
  2: optional list<Deployment> Deployments
  3: optional bool KnownLeader
  4: optional i64 LastContact
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
  4: optional bool KnownLeader
  5: optional string EvalID
  6: optional i64 EvalCreateIndex
  7: optional i64 LastContact
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
  3: optional bool KnownLeader
  4: optional i64 LastContact
  5: optional i64 EvalCreateIndex
  6: optional string EvalID
}
