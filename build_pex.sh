#!/bin/bash

THRIFT_LOCATION=$(pip show thrift | grep ^Location | awk '{print $NF}')
pex -v -r <(grep -v thrift requirements.txt) -o ~/nomadgen.pex ./ ${THRIFT_LOCATION}/thrift
