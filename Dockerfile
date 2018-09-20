FROM ubuntu:18.04

COPY ./install_fbthrift.sh /

RUN apt-get update && apt-get install -y sudo && bash -x /install_fbthrift.sh

