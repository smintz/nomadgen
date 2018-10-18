all: pex

deps:
	pip install -r requirements.txt

thrift_gen: deps
	PYTHONPATH=. python nomadgen/nomad_meta.py > if/jobspec.thrift
	thrift1 --gen py:json -out nomadgen if/jobspec.thrift
	PYTHONPATH=. python nomadgen/consul_meta.py > if/consul.thrift
	thrift1 --gen py:json -out nomadgen if/consul.thrift

test: thrift_gen
	pip install -r dev-requirements.txt
	PYTHONPATH=. python -m unittest discover

pex: thrift_gen
	rm -rf ~/.pex/build/nomadgen* ~/.pex/install/nomadgen*
	./build_pex.sh
