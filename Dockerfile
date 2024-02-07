FROM ubuntu:18.04

RUN apt update
RUN apt install software-properties-common --yes
RUN apt-add-repository --yes --update ppa:ansible/ansible-2.9
RUN apt install ansible --yes
RUN apt install vim --yes

ENV ANSIBLE_PERSISTENT_COMMAND_TIMEOUT=600

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
