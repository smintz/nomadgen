all: thrift_gen pex

thrift_gen:
	python nomadgen/import_golang_to_thrift.py > if/jobspec.thrift
	thrift1 --gen py -out nomadgen if/jobspec.thrift

pex:
	pex -r pex-requirements.txt -D . -o ~/.local/bin/nomadgen.pex
