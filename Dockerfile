FROM ubuntu:24.04

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        pipx \
        sshpass \
        git \
        curl \
        ca-certificates

# Install Ansible 12.3 via pipx (isolated environment)
RUN pipx install --include-deps ansible==12.3.0

# Ensure ansible is on PATH
ENV PATH="/root/.local/bin:${PATH}"

# Validate installation
RUN ansible --version

ENV ANSIBLE_PERSISTENT_COMMAND_TIMEOUT=600
