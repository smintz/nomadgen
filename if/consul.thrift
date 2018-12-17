struct CheckType {
  1: optional string CheckID
  2: optional string Status
  3: optional string DockerContainerID
  4: optional string HTTP
  5: optional string Name
  6: optional string AliasNode
  7: optional list<string> ScriptArgs
  8: optional string Notes
  9: optional i64 Interval
  10: optional string TCP
  11: optional bool TLSSkipVerify
  12: optional map<string,list<string>> Header
  13: optional i64 DeregisterCriticalServiceAfter
  14: optional string Shell
  15: optional string GRPC
  16: optional bool GRPCUseTLS
  17: optional i64 Timeout
  18: optional i64 TTL
  19: optional string AliasService
  20: optional string Method
}
struct ServiceDefinitionConnectProxy {
  1: optional list<string> Command
  2: optional string ExecMode
  3: optional string Config
  4: optional list<Upstream> Upstreams
}
struct Upstream {
  1: optional string Datacenter
  2: optional string LocalBindAddress
  3: optional string DestinationName
  4: optional string DestinationNamespace
  5: optional string DestinationType
  6: optional i16 LocalBindPort
  7: optional string Config
}
struct ServiceDefinition {
  1: optional string ProxyDestination
  2: optional string Kind
  3: optional string Name
  4: optional list<string> Tags
  5: optional CheckType Check
  6: optional bool EnableTagOverride
  7: optional list<CheckType> Checks
  8: optional string Token
  9: optional map<string,string> Meta
  10: optional Weights Weights
  11: optional ServiceConnect Connect
  12: optional string Address
  13: optional string ID
  14: optional i16 Port
  15: optional ConnectProxyConfig Proxy
}
struct ConnectProxyConfig {
  1: optional string LocalServiceAddress
  2: optional i16 LocalServicePort
  3: optional list<Upstream> Upstreams
  4: optional string DestinationServiceName
  5: optional string DestinationServiceID
  6: optional string Config
}
struct Weights {
  1: optional i16 Passing
  2: optional i16 Warning
}
struct ServiceConnect {
  1: optional ServiceDefinition SidecarService
  2: optional ServiceDefinitionConnectProxy Proxy
  3: optional bool Native
}
struct HealthCheckDefinition {
  1: optional string HTTP
  2: optional string Interval
  3: optional string TCP
  4: optional bool TLSSkipVerify
  5: optional map<string,list<string>> Header
  6: optional string DeregisterCriticalServiceAfter
  7: optional string Timeout
  8: optional string Method
}
struct Node {
  1: optional string Node
  2: optional string Datacenter
  3: optional map<string,string> TaggedAddresses
  4: optional map<string,string> Meta
  5: optional string Address
  6: optional string ID
}
struct HealthCheck {
  1: optional string Node
  2: optional string CheckID
  3: optional string Name
  4: optional HealthCheckDefinition Definition
  5: optional string Notes
  6: optional string Status
  7: optional string ServiceName
  8: optional string ServiceID
  9: optional string Output
  10: optional list<string> ServiceTags
}
struct NodeService {
  1: optional string ProxyDestination
  2: optional string Kind
  3: optional string Service
  4: optional bool LocallyRegisteredAsSidecar
  5: optional list<string> Tags
  6: optional bool EnableTagOverride
  7: optional string ID
  8: optional map<string,string> Meta
  9: optional Weights Weights
  10: optional ConnectProxyConfig Proxy
  11: optional string Address
  12: optional i16 Port
  13: optional ServiceConnect Connect
}
struct NodeServices {
  1: optional Node Node
  2: optional map<string,NodeService> Services
}
struct ServiceNode {
  1: optional string Node
  2: optional string Datacenter
  3: optional Weights ServiceWeights
  4: optional ConnectProxyConfig ServiceProxy
  5: optional string Address
  6: optional map<string,string> ServiceMeta
  7: optional string ServiceProxyDestination
  8: optional map<string,string> TaggedAddresses
  9: optional i16 ServicePort
  10: optional string ServiceName
  11: optional string ServiceAddress
  12: optional string ServiceID
  13: optional ServiceConnect ServiceConnect
  14: optional string ServiceKind
  15: optional list<string> ServiceTags
  16: optional map<string,string> NodeMeta
  17: optional bool ServiceEnableTagOverride
  18: optional string ID
}
struct NodeInfo {
  1: optional string Node
  2: optional map<string,string> TaggedAddresses
  3: optional string ID
  4: optional map<string,string> Meta
  5: optional string Address
  6: optional list<NodeService> Services
  7: optional list<HealthCheck> Checks
}
struct CheckServiceNode {
  1: optional Node Node
  2: optional list<HealthCheck> Checks
  3: optional NodeService Service
}
struct IndexedCheckServiceNodes {
  1: optional i64 Index
  2: optional list<CheckServiceNode> Nodes
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedNodes {
  1: optional i64 Index
  2: optional list<Node> Nodes
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedNodeServices {
  1: optional NodeServices NodeServices
  2: optional i64 Index
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedServiceNodes {
  1: optional i64 Index
  2: optional list<ServiceNode> ServiceNodes
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedServices {
  1: optional map<string,list<string>> Services
  2: optional i64 Index
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedHealthChecks {
  1: optional i64 Index
  2: optional list<HealthCheck> HealthChecks
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedNodeDump {
  1: optional i64 Index
  2: optional list<NodeInfo> Dump
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct QueryMeta {
  1: optional i64 Index
  2: optional bool KnownLeader
  3: optional string ConsistencyLevel
  4: optional i64 LastContact
}
