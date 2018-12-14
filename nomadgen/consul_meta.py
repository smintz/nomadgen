from nomadgen.struct_parser import StructParser

CONSUL_VERSION = "1.3.0"

if __name__ == "__main__":
    StructParser(
        version="v" + CONSUL_VERSION,
        product="consul",
        override_field={
            "ServiceDefinitionConnectProxy": {"Config": "string"},
            "ConnectProxyConfig": {"Config": "string"},
            "Upstream": {"Config": "string"},
            "ServiceNode": {"ServiceKind": "string"},
        },
        tr_types={
            "api.ReadableDuration": "string",
            "types.NodeID": "string",
            "types.CheckID": "string",
        },
        file_paths=[
            "/agent/structs/structs.go",
            "/agent/structs/service_definition.go",
            "/agent/structs/acl.go",
            "/agent/structs/catalog.go",
            "/agent/structs/check_definition.go",
            "/agent/structs/check_type.go",
            "/agent/structs/connect.go",
            "/agent/structs/connect_ca.go",
            "/agent/structs/connect_proxy_config.go",
            "/agent/structs/errors.go",
            "/agent/structs/intention.go",
            "/agent/structs/operator.go",
            "/agent/structs/prepared_query.go",
            "/agent/structs/snapshot.go",
            "/agent/structs/txn.go",
        ],
        start_keys=[
            "QueryMeta",
            "IndexedNodes",
            "IndexedServices",
            "IndexedServiceNodes",
            "IndexedNodeServices",
            "IndexedHealthChecks",
            "IndexedCheckServiceNodes",
            "IndexedNodeDump",
        ],
    ).print_all()
