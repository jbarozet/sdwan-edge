FROM ubuntu:22.04

ARG arch=amd64
ARG terraform_version=1.4.4

# Update Ubuntu

RUN apt update
RUN apt install -y curl genisoimage git python-is-python3 python3-pip unzip
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

# Install Terraform

RUN curl -#O https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_${arch}.zip
RUN unzip terraform_${terraform_version}_linux_${arch}.zip
RUN mv terraform /usr/bin
RUN rm terraform_${terraform_version}_linux_${arch}.zip

# Install dependancies

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ENV ANSIBLE_HOST_KEY_CHECKING=false
ENV ANSIBLE_RETRY_FILES_ENABLED=false
ENV ANSIBLE_SSH_PIPELINING=true
ENV ANSIBLE_LOCAL_TMP=/tmp
ENV ANSIBLE_REMOTE_TMP=/tmp

# Install sastre-ansible

RUN git clone https://github.com/reismarcelo/sastre-ansible.git /tmp/sastre-ansible
RUN ansible-galaxy collection build /tmp/sastre-ansible/cisco/sastre --output-path /tmp/sastre-ansible
RUN ansible-galaxy collection install -f /tmp/sastre-ansible/cisco-sastre-1.0.16.tar.gz
RUN rm -fr /tmp/sastre-ansible

WORKDIR /ansible
