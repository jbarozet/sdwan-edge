module "edge" {
  source                 = "./edge"
  region                 = "${data.terraform_remote_state.vpc.outputs.region}"
  common_tags            = "${data.terraform_remote_state.vpc.outputs.common_tags}"
  sg_id                  = "${data.terraform_remote_state.vpc.outputs.sg_id}"
  edge_ami               = "${var.edge_ami}"
  instances_type         = "${var.instances_type}"
  enable_eip_mgmt        = "${var.enable_eip_mgmt}"
  ssh_pubkey             = "${var.ssh_pubkey}"
  sdwan_org              = "${var.sdwan_org}"
  route53_zone           = "${var.route53_zone}"
  transport_subnets      = "${data.terraform_remote_state.vpc.outputs.transport_subnets}"
  service_subnets        = "${data.terraform_remote_state.vpc.outputs.service_subnets}"
}