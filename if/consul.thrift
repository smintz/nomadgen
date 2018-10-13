struct ServiceDefinitionConnectProxy {
  1: optional string Config
  2: optional string ExecMode
  3: optional list<string> Command
}
struct ServiceConnect {
  1: optional ServiceDefinitionConnectProxy Proxy
  2: optional bool Native
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
  4: optional string ServiceName
  5: optional HealthCheckDefinition Definition
  6: optional string Notes
  7: optional string Status
  8: optional string ServiceID
  9: optional list<string> ServiceTags
  10: optional string Output
}
struct NodeService {
  1: optional string ProxyDestination
  2: optional string Kind
  3: optional string Service
  4: optional list<string> Tags
  5: optional bool EnableTagOverride
  6: optional i16 Port
  7: optional map<string,string> Meta
  8: optional ServiceConnect Connect
  9: optional string Address
  10: optional string ID
}
struct NodeServices {
  1: optional Node Node
  2: optional map<string,NodeService> Services
}
struct ServiceNode {
  1: optional string Node
  2: optional string Datacenter
  3: optional ServiceConnect ServiceConnect
  4: optional map<string,string> ServiceMeta
  5: optional string ServiceName
  6: optional map<string,string> TaggedAddresses
  7: optional string ServiceProxyDestination
  8: optional i16 ServicePort
  9: optional string ServiceID
  10: optional string ServiceAddress
  11: optional string Address
  12: optional string ServiceKind
  13: optional list<string> ServiceTags
  14: optional map<string,string> NodeMeta
  15: optional bool ServiceEnableTagOverride
  16: optional string ID
}
struct NodeInfo {
  1: optional string Node
  2: optional map<string,string> TaggedAddresses
  3: optional list<HealthCheck> Checks
  4: optional map<string,string> Meta
  5: optional string Address
  6: optional list<NodeService> Services
  7: optional string ID
}
struct CheckServiceNode {
  1: optional Node Node
  2: optional list<HealthCheck> Checks
  3: optional NodeService Service
}
struct IndexedNodeServices {
  1: optional NodeServices NodeServices
  2: optional i64 Index
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
struct IndexedServiceNodes {
  1: optional i64 Index
  2: optional list<ServiceNode> ServiceNodes
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedCheckServiceNodes {
  1: optional i64 Index
  2: optional list<CheckServiceNode> Nodes
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
struct IndexedHealthChecks {
  1: optional list<HealthCheck> HealthChecks
  2: optional i64 LastContact
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 Index
}
struct IndexedNodeDump {
  1: optional i64 Index
  2: optional string ConsistencyLevel
  3: optional bool KnownLeader
  4: optional list<NodeInfo> Dump
  5: optional i64 LastContact
}
struct QueryMeta {
  1: optional i64 Index
  2: optional bool KnownLeader
  3: optional string ConsistencyLevel
  4: optional i64 LastContact
}
struct IndexedNodes {
  1: optional i64 Index
  2: optional list<Node> Nodes
  3: optional bool KnownLeader
  4: optional string ConsistencyLevel
  5: optional i64 LastContact
}
