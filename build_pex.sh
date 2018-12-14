#!/bin/bash

PY_VERSION=${TOX_ENV_NAME:-$(python -c 'import sys; print("py" + "".join(map(str, sys.version_info[:2])))')}
THRIFT_LOCATION=$(pip show thrift | grep ^Location | awk '{print $NF}')
pex -v -r <(grep -v thrift requirements.txt) -o $(dirname $0)/build/nomadgen-$(uname | tr "[A-Z]" "[a-z]")-${PY_VERSION}.pex ./ ${THRIFT_LOCATION}/thrift
