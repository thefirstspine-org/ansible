FROM ubuntu:24.04

RUN apt update
RUN apt install software-properties-common --yes
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt install ansible=9.2.0 --yes

ENV ANSIBLE_PERSISTENT_COMMAND_TIMEOUT=600
