all: thrift_gen install

thrift_gen:
	thrift --gen py -out nomad if/jobspec.thrift

install:
	sudo python setup.py install

test: all
	python examples/hashiapp.py
