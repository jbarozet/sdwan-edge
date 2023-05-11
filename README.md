# Create SDWAN Edge in an AWS VPC

## Overview

This repo contains a set of tools to automate the deployment of SD-WAN edge devices (C8000v) in AWS.

All tasks are executed within a docker container that contains all necessary tools and python libraries:

- ansible
- terraform
- python3
- [cisco-sdwan (sastre) - python library for sdwan](https://github.com/CiscoDevNet/sastre)
- [sastre-ansible](https://github.com/reismarcelo/sastre-ansible)

> Note: The tools in this repo only work from a Unix environment with Docker (e.g. Linux, MacOS, etc.) due to issues with Ansible and file permissions mapping between Windows and the Linux container used in play.sh. WSL2 may fix this issue and we will revisit when WSL2 is released.

## Build the container

Build the Docker image

With sdwan-edge as your current folder, execute the following command:

```console
$ docker build -t sdwan-container . 
```

## Configure your environment

Get free UUIDs and tokens from vManage.

Update global parameters in:

- `ansible/group_vars/all/local.yml`
- `ansible/sdwan_inventory.yml`

## Instantiate C8kv in a VPC

- With `bin` as your current directory
- Execute: `./play.sh /ansible/onboard-edges.yml


## Setup Inter region VPC peering

To setup ipsec tunnels directly between Border Routers in **different regions**
using private IP addresses, you need to setup a peering connection between each pair of VPCs.

**STEP1** - Go to folder **vpc-peering/region1-region2**

**STEP2** - fill in parameters in `variables.auto.tfvars.json`

**STEP3** Create peering connection:

- execute `terraform init`
- execute `terraform apply -auto-approve`



## NOTES


Install sastre tools: `pip install cisco-sdwan`

[sastre-ansible](https://github.com/CiscoDevNet/sastre-ansible)