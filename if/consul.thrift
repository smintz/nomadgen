struct CheckType {
  1: optional string CheckID
  2: optional string Name
  3: optional string Status
  4: optional string Notes
  5: optional list<string> ScriptArgs
  6: optional string HTTP
  7: optional map<string,list<string>> Header
  8: optional string Method
  9: optional string TCP
  10: optional i64 Interval
  11: optional string AliasNode
  12: optional string AliasService
  13: optional string DockerContainerID
  14: optional string Shell
  15: optional string GRPC
  16: optional bool GRPCUseTLS
  17: optional bool TLSSkipVerify
  18: optional i64 Timeout
  19: optional i64 TTL
  20: optional i64 DeregisterCriticalServiceAfter
}
struct Upstream {
  1: optional string DestinationType
  2: optional string DestinationNamespace
  3: optional string DestinationName
  4: optional string Datacenter
  5: optional string LocalBindAddress
  6: optional i16 LocalBindPort
  7: optional string Config
}
struct ServiceDefinitionConnectProxy {
  1: optional list<string> Command
  2: optional string ExecMode
  3: optional string Config
  4: optional list<Upstream> Upstreams
}
struct ServiceDefinition {
  1: optional string Kind
  2: optional string ID
  3: optional string Name
  4: optional list<string> Tags
  5: optional string Address
  6: optional map<string,string> Meta
  7: optional i16 Port
  8: optional CheckType Check
  9: optional list<CheckType> Checks
  10: optional Weights Weights
  11: optional string Token
  12: optional bool EnableTagOverride
  13: optional string ProxyDestination
  14: optional ConnectProxyConfig Proxy
  15: optional ServiceConnect Connect
}
struct Weights {
  1: optional i16 Passing
  2: optional i16 Warning
}
struct ConnectProxyConfig {
  1: optional string DestinationServiceName
  2: optional string DestinationServiceID
  3: optional string LocalServiceAddress
  4: optional i16 LocalServicePort
  5: optional string Config
  6: optional list<Upstream> Upstreams
}
struct ServiceConnect {
  1: optional bool Native
  2: optional ServiceDefinitionConnectProxy Proxy
  3: optional ServiceDefinition SidecarService
}
struct HealthCheckDefinition {
  1: optional string HTTP
  2: optional bool TLSSkipVerify
  3: optional map<string,list<string>> Header
  4: optional string Method
  5: optional string TCP
  6: optional string Interval
  7: optional string Timeout
  8: optional string DeregisterCriticalServiceAfter
}
struct Node {
  1: optional string ID
  2: optional string Node
  3: optional string Address
  4: optional string Datacenter
  5: optional map<string,string> TaggedAddresses
  6: optional map<string,string> Meta
}
struct NodeService {
  1: optional string Kind
  2: optional string ID
  3: optional string Service
  4: optional list<string> Tags
  5: optional string Address
  6: optional map<string,string> Meta
  7: optional i16 Port
  8: optional Weights Weights
  9: optional bool EnableTagOverride
  10: optional string ProxyDestination
  11: optional ConnectProxyConfig Proxy
  12: optional ServiceConnect Connect
  13: optional bool LocallyRegisteredAsSidecar
}
struct HealthCheck {
  1: optional string Node
  2: optional string CheckID
  3: optional string Name
  4: optional string Status
  5: optional string Notes
  6: optional string Output
  7: optional string ServiceID
  8: optional string ServiceName
  9: optional list<string> ServiceTags
  10: optional HealthCheckDefinition Definition
}
struct ServiceNode {
  1: optional string ID
  2: optional string Node
  3: optional string Address
  4: optional string Datacenter
  5: optional map<string,string> TaggedAddresses
  6: optional map<string,string> NodeMeta
  7: optional string ServiceKind
  8: optional string ServiceID
  9: optional string ServiceName
  10: optional list<string> ServiceTags
  11: optional string ServiceAddress
  12: optional Weights ServiceWeights
  13: optional map<string,string> ServiceMeta
  14: optional i16 ServicePort
  15: optional bool ServiceEnableTagOverride
  16: optional string ServiceProxyDestination
  17: optional ConnectProxyConfig ServiceProxy
  18: optional ServiceConnect ServiceConnect
}
struct NodeServices {
  1: optional Node Node
  2: optional map<string,NodeService> Services
}
struct CheckServiceNode {
  1: optional Node Node
  2: optional NodeService Service
  3: optional list<HealthCheck> Checks
}
struct NodeInfo {
  1: optional string ID
  2: optional string Node
  3: optional string Address
  4: optional map<string,string> TaggedAddresses
  5: optional map<string,string> Meta
  6: optional list<NodeService> Services
  7: optional list<HealthCheck> Checks
}
struct QueryMeta {
  1: optional i64 Index
  2: optional i64 LastContact
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
}
struct IndexedNodes {
  1: optional list<Node> Nodes
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
  5: optional string ConsistencyLevel
}
struct IndexedServices {
  1: optional map<string,list<string>> Services
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
  5: optional string ConsistencyLevel
}
struct IndexedServiceNodes {
  1: optional list<ServiceNode> ServiceNodes
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
  5: optional string ConsistencyLevel
}
struct IndexedNodeServices {
  1: optional NodeServices NodeServices
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
  5: optional string ConsistencyLevel
}
struct IndexedHealthChecks {
  1: optional list<HealthCheck> HealthChecks
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
  5: optional string ConsistencyLevel
}
struct IndexedCheckServiceNodes {
  1: optional list<CheckServiceNode> Nodes
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
  5: optional string ConsistencyLevel
}
struct IndexedNodeDump {
  1: optional list<NodeInfo> Dump
  2: optional i64 Index
  3: optional i64 LastContact
  4: optional bool KnownLeader
  5: optional string ConsistencyLevel
}
