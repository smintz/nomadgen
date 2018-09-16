all: thrift_gen pex

deps:
	pip install -r requirements.txt

thrift_gen:
	python nomadgen/import_golang_to_thrift.py > if/jobspec.thrift
	thrift1 --gen py -out nomadgen if/jobspec.thrift

test:
	PYTHONPATH=. python -m unittest discover

pex: deps test
	rm -rf ~/.pex/build/nomadgen* ~/.pex/install/nomadgen*
	pex -v -r pex-requirements.txt -o ~/.local/bin/nomadgen.pex ./ ~/.local/lib/python2.7/site-packages/thrift/
