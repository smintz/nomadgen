#!/bin/bash

WORKDIR=/tmp/fb
mkdir -p $WORKDIR
FB_TAG='2018.09.10.00'
if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
  brew update
  export PATH="/usr/local/opt/bison/bin:$PATH"
  cd $WORKDIR
  export OPENSSL_ROOT_DIR=/usr/local/opt/openssl
  curl -L https://github.com/facebook/fbthrift/archive/v${FB_TAG}.tar.gz -o fbthrift-${FB_TAG}.tar.gz
  tar xvf fbthrift-${FB_TAG}.tar.gz
  pushd fbthrift-${FB_TAG}
  cmake -Dcompiler_only=ON .
  make -j $(nproc)
  sudo make install 
  popd

  # Install some custom requirements on OS X
  # e.g. brew install pyenv-virtualenv

else
  sudo apt-get update
  sudo bash -x $(dirname $0)/../install_fbthrift.sh
fi
