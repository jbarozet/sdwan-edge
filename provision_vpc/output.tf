output "region" {
  value = "${var.region}"
}

output "common_tags" {
  value = "${var.common_tags}"
}

output "vpc_id" {
  value = "${aws_vpc.sdwan_vpc.id}"
}

output "cidr_block" {
  value = "${var.cidr_block}"
}

output "sg_id" {
  value = "${aws_security_group.transport.id}"
}

output "transport_subnets" {
  value = ["${aws_subnet.transport_subnet_az_1.id}", "${aws_subnet.transport_subnet_az_2.id}"]
}

output "service_subnets" {
  value = ["${aws_subnet.service_subnet_az_1.id}", "${aws_subnet.service_subnet_az_2.id}"]
}
