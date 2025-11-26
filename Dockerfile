FROM ubuntu:18.04

RUN apt update
RUN apt install software-properties-common --yes
RUN apt-add-repository --yes --update ppa:ansible/ansible-2.19
RUN apt install ansible --yes

ENV ANSIBLE_PERSISTENT_COMMAND_TIMEOUT=600
