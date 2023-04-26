
/*
  Subnets: Transport
*/

resource "aws_subnet" "transport_subnet_az_1" {
  vpc_id            = "${aws_vpc.sdwan_vpc.id}"
  cidr_block        = cidrsubnet("${var.cidr_block}", 2, 0)
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = merge(
    var.common_tags,
    {
      Name = "subnet_transport_az_1"
      VPC  = "SD-WAN"
    }
  )
}

resource "aws_subnet" "transport_subnet_az_2" {
  vpc_id            = "${aws_vpc.sdwan_vpc.id}"
  cidr_block        = cidrsubnet("${var.cidr_block}", 2, 2)
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags = merge(
    var.common_tags,
    {
      Name = "subnet_transport_az_2"
      VPC  = "SD-WAN"
    }
  )
}

/*
  Subnets: Service
*/

resource "aws_subnet" "service_subnet_az_1" {
  vpc_id            = "${aws_vpc.sdwan_vpc.id}"
  cidr_block        = cidrsubnet("${var.cidr_block}", 2, 1)
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = merge(
    var.common_tags,
    {
      Name = "subnet_service_az_1"
      VPC  = "SD-WAN"
    }
  )
}

resource "aws_subnet" "service_subnet_az_2" {
  vpc_id            = "${aws_vpc.sdwan_vpc.id}"
  cidr_block        = cidrsubnet("${var.cidr_block}", 2, 3)
  availability_zone = "${data.aws_availability_zones.available.names[1]}"

  tags = merge(
    var.common_tags,
    {
      Name = "subnet_service_az_2"
      VPC  = "SD-WAN"
    }
  )
}

