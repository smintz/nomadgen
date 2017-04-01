from nomadgen.jobspec.ttypes import Resources, Port, Network

class CommonResources(Resources):

    def __init__(self, cpu=50, memory=128):
        Resources.__init__(self)
        self.CPU=cpu
        self.MemoryMB=memory
        self.Networks=[
            Network(
                MBits=1,
                DynamicPorts=[],
                ReservedPorts=[]
            )
        ]

    def setPort(self, name, port=None):
        if port:
            self.Networks[0].ReservedPorts.append(Port(Label=name, Value=port))
        else:
            self.Networks[0].DynamicPorts.append(Port(Label=name))

        return self

