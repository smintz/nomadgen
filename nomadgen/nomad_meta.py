from nomadgen.struct_parser import StructParser
NOMAD_VERSION = '0.8.6'

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
            '/nomad/structs/diff.go',
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
