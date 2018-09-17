#!/bin/bash
set -e

WORKDIR=/tmp/fb
mkdir -p $WORKDIR
FB_TAG='2018.09.10.00'
sudo apt-get install -y -qq \
  binutils-dev \
  bison \
  cmake \
  curl \
  flex \
  g++ \
  git \
  libboost-all-dev \
  libdouble-conversion-dev \
  libevent-dev \
  libgflags-dev \
  libgoogle-glog-dev \
  libiberty-dev \
  libjemalloc-dev \
  libkrb5-dev \
  liblz4-dev \
  liblzma-dev \
  libsnappy-dev \
  libsodium-dev \
  libssl-dev \
  make \
  pkg-config \
  python-pip \
  zlib1g-dev

#https://github.com/no1msd/mstch
cd $WORKDIR
curl -L https://github.com/no1msd/mstch/archive/1.0.2.tar.gz -o mstch.tar.gz
tar xvf mstch.tar.gz
pushd mstch-1.0.2
cmake .
make -j $(nproc)
sudo make install 
popd
#https://github.com/facebook/zstd.git
cd $WORKDIR
curl -L https://github.com/facebook/zstd/archive/v1.3.5.tar.gz -o zstd.tar.gz
tar xvf zstd.tar.gz
pushd zstd-1.3.5
make -j $(nproc)
sudo make install 
popd
#https://github.com/facebook/folly.git
cd $WORKDIR
curl -L https://github.com/facebook/folly/archive/v${FB_TAG}.tar.gz -o folly-${FB_TAG}.tar.gz
tar xvf folly-${FB_TAG}.tar.gz
pushd folly-${FB_TAG}
cmake .
make -j $(nproc)
sudo make install
cd $WORKDIR
curl -L https://github.com/facebook/fbthrift/archive/v${FB_TAG}.tar.gz -o fbthrift-${FB_TAG}.tar.gz
tar xvf fbthrift-${FB_TAG}.tar.gz
pushd fbthrift-${FB_TAG}
cmake -Dcompiler_only=ON .
make -j $(nproc)
sudo make install 
popd
