# Deploy SDWAN Edges in an AWS VPCs

## Overview

This repo contains a set of tools to automate the deployment of SD-WAN edge devices (C8000v) in AWS.

All tasks are executed within a docker container that contains all necessary tools and python libraries.

Most important tools:

- ansible
- terraform
- python3

Cisco Libraries used:

- [cisco-sdwan (sastre)](https://github.com/CiscoDevNet/sastre): provides functions to assist with managing configuration elements and visualize information from Cisco SD-WAN deployments.
- [sastre-ansible](https://github.com/reismarcelo/sastre-ansible): the Sastre-Ansible collection exposes Sastre or Sastre-Pro commands to Ansible Playbooks as a set of tasks and lookup plugins. Allowing users to build-up on Sastre functionality to create larger automation workflows.

> Note: The tools in this repo only work from a Unix environment with Docker (e.g. Linux, MacOS, etc.) due to issues with Ansible and file permissions mapping between Windows and the Linux container used in play.sh. WSL2 may fix this issue and we will revisit when WSL2 is released.

## Build the docker image

We use a docker container to run all the Ansible playbooks. This avoids issues with native support for Ansible, Terraform and python.

With sdwan-edge as your current folder, execute the following command:

```console
# docker build -t sdwan-container . 
```

## Configure your environment

Get free UUIDs from vManage.

Rename `ansible/sdwan_inventory_example.yml` to `ansible/sdwan_inventory.yml` and update parameters.

Update global parameters if required in: `ansible/group_vars/all/local.yml`

sdwan_inventory gives you the option to define multiple edges, in multiple vpcs.

## Instantiate SD-WAN edges

- With `bin` as your current directory
- Execute: `./play.sh /ansible/onboard-edges.yml

## Setup inter region VPC peering

To setup ipsec tunnels directly between Border Routers in **different regions**
using private IP addresses, you need to setup a peering connection between each pair of VPCs.

Go to folder **vpc-peering/region1-region2**

Fill in parameters in `variables.auto.tfvars.json`

Create peering connection:

- execute `terraform init`
- execute `terraform apply -auto-approve`
