#!/bin/bash

WORKDIR=/tmp/fb
mkdir -p $WORKDIR
FB_TAG='2018.09.10.00'
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  cd $WORKDIR
  curl -L https://github.com/facebook/fbthrift/archive/v${FB_TAG}.tar.gz -o fbthrift-${FB_TAG}.tar.gz
  tar xvf fbthrift-${FB_TAG}.tar.gz
  pushd fbthrift-${FB_TAG}
  cmake -Dcompiler_only=ON .
  make -j $(nproc)
  sudo make install 
  popd

  # Install some custom requirements on OS X
  # e.g. brew install pyenv-virtualenv

  case "${TOXENV}" in
    py32)
      # Install some custom Python 3.2 requirements on OS X
      ;;
    py33)
      # Install some custom Python 3.3 requirements on OS X
      ;;
  esac
else
  bash -x $(dirname $0)/../install_fbthrift.sh
fi
