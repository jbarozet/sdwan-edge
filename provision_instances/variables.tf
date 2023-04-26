
variable "edge_ami" {}
variable "instances_type" {}
variable "enable_eip_mgmt" {
  default = false
}
variable "ssh_pubkey" {}
variable "sdwan_org" {}
variable "route53_zone" {
  default = ""
}
data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../provision_vpc/terraform.tfstate"
  }
}

