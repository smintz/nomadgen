#!/bin/bash

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  eval "$(pyenv init -)"
  echo "PYTHON=${PYTHON}"
  pyenv local $PYTHON
  python --version
  pip install --upgrade pip
fi

exec $@
