/*
  Requires:
  - AWS Region
  - CIDR block with <= 27 bit prefix length

  Provisions:
  - VPC,
  - iGW,
  - public route table,
  - 4 subnets in 2 different availability zones,
  - security group for the SD-WAN controllers
*/

/*
  Gather Availability Zone Information
*/
data "aws_availability_zones" "available" {
  state = "available"
}

/*
  VPC
*/
resource "aws_vpc" "sdwan_vpc" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_hostnames = true

  tags = merge(
    var.common_tags,
    {
      Name = "SD-WAN"
    }
  )
}


