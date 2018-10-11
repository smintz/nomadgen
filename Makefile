all: thrift_gen pex

deps:
	pip install -r requirements.txt

thrift_gen:
	python nomadgen/import_golang_to_thrift.py > if/jobspec.thrift
	thrift1 --gen py:json -out nomadgen if/jobspec.thrift

test:
	pip install -r dev-requirements.txt
	PYTHONPATH=. python -m unittest discover

pex: deps test
	rm -rf ~/.pex/build/nomadgen* ~/.pex/install/nomadgen*
	./build_pex.sh
