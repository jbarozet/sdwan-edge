# Create SDWAN Edge in an AWS VPC

## Instantiate C8kv in a VPC

**STEP1** - Get a free UUIDs and tokens from vManage

**STEP2** - update global parameters

- Update `input.json` with your own parameters including UUID

**STEP3** - Generate variables files for Ansible and Terraform:

With `instance/bin` as your current directory

- Execute: `./create_vars.sh`
- This will generate 3 files that contain variables used by Ansible and Terraform:
  - **ansible/vars.yml**
  - **provision_vpc/my_variables.auto.tfvars.json**
  - **provision_instances/my_variables.auto.tfvars.json**

**STEP4** - Generate Bootstrap configuration for this instance

- With `instance/bin` as your current directory
- Execute: `./get_device_token.yml`

**STEP5** - Create VPC, subnets, route tables, igw and eip:

- With `provision_vpc` as your current directory
  - execute `terraform init`
  - execute `terraform apply -auto-approve`

**STEP5** - Instantiate C8kv in the newly created vpc:

- With `provison_instance` as your current directory
  - execute `terraform init`
  - execute `terraform apply -auto-approve`

## Setup Inter region VPC peering

To setup ipsec tunnels directly between Border Routers in **different regions**
using private IP addresses, you need to setup a peering connection between each pair of VPCs.

**STEP1** - Go to folder **vpc-peering/region1-region2**

**STEP2** - fill in parameters in `variables.auto.tfvars.json`

**STEP3** Create peering connection:

- execute `terraform init`
- execute `terraform apply -auto-approve`
