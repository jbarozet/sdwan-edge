/*
  Route Tables
*/
resource "aws_route_table" "service" {
  vpc_id = "${aws_vpc.sdwan_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sdwan_vpc.id}"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "SD-WAN (service)"
      VPC  = "SD-WAN"
    }
  )
}

resource "aws_route_table" "transport" {
  vpc_id = "${aws_vpc.sdwan_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sdwan_vpc.id}"
  }

  tags = merge(
    var.common_tags,
    {
      Name = "SD-WAN (transport)"
      VPC  = "SD-WAN"
    }
  )
}

/*
  Route Table Associations
*/
resource "aws_route_table_association" "subnet_s1_to_rt_public" {
  subnet_id      = "${aws_subnet.service_subnet_az_1.id}"
  route_table_id = "${aws_route_table.service.id}"
}

resource "aws_route_table_association" "subnet_s2_to_rt_public" {
  subnet_id      = "${aws_subnet.service_subnet_az_2.id}"
  route_table_id = "${aws_route_table.service.id}"
}

resource "aws_route_table_association" "subnet_t1_to_rt_public" {
  subnet_id      = "${aws_subnet.transport_subnet_az_1.id}"
  route_table_id = "${aws_route_table.transport.id}"
}

resource "aws_route_table_association" "subnet_t2_to_rt_public" {
  subnet_id      = "${aws_subnet.transport_subnet_az_2.id}"
  route_table_id = "${aws_route_table.transport.id}"
}
