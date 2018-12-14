from nomadgen.struct_parser import StructParser
NOMAD_VERSION = '0.8.5'

if __name__ == "__main__":
    drivers = StructParser(
        version='v' + NOMAD_VERSION,
        file_paths=[
            '/client/driver/docker.go',
            '/client/driver/exec.go',
            '/client/driver/qemu.go',
            '/client/driver/java.go',
            '/client/driver/rkt.go',
        ],
        start_keys=[
            'DockerDriverConfig',
            'ExecDriverConfig',
            'QemuDriverConfig',
            'JavaDriverConfig',
            'RktDriverConfig',
        ])
    drivers.print_all()
    print(
        drivers.build_struct(
            'DriverConfig', drivers.driver_config_struct['DriverConfig']))
    StructParser(
        version='v' + NOMAD_VERSION,
        override_field={'Task': {'Config': 'DriverConfig'}},
        file_paths=[
            '/nomad/structs/structs.go',
            '/nomad/structs/batch_future.go',
            '/nomad/structs/bitmap.go',
            '/nomad/structs/diff.go',
            '/nomad/structs/errors.go',
            '/nomad/structs/funcs.go',
            '/nomad/structs/network.go',
            '/nomad/structs/node.go',
            '/nomad/structs/node_class.go',
            '/nomad/structs/operator.go',
            '/nomad/structs/streaming_rpc.go',
            '/nomad/structs/structs.generated.go',
            '/nomad/structs/structs_codegen.go',
        ],
        start_keys=[
            'QueryMeta',
            'WriteMeta',
            'DeploymentListResponse',
            'DeploymentPromoteRequest',
            'JobAllocationsResponse',
            'JobPlanRequest',
            'JobPlanResponse',
            'JobDeregisterResponse',
            'JobRegisterRequest',
            'JobRegisterResponse',
        ]).print_all()
