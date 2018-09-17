FROM ubuntu:18.04

COPY . /work

WORKDIR /work

RUN apt-get update && apt-get install -y sudo

RUN bash -x ./install_fbthrift.sh

RUN make deps && make
