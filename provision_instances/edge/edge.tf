
data "aws_subnet" "transport_subnet" {
  id = var.transport_subnets[0]
}

data "aws_subnet" "service_subnet" {
  id = var.service_subnets[0]
}

resource "aws_instance" "edge" {
  ami           = var.edge_ami
  instance_type = var.instances_type
  user_data     = file("cloud-init/edge.cloud_init")

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.transport.id
  }

  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.service.id
  }

  tags = merge(
    var.common_tags,
    {
      Name = "sdwan-edge"
    }
  )

  depends_on = [aws_network_interface.transport]
}

resource "aws_network_interface" "transport" {
  subnet_id         = var.transport_subnets[0]
  private_ips       = [cidrhost(data.aws_subnet.transport_subnet.cidr_block, 12)]
  security_groups   = ["${var.sg_id}"]
  source_dest_check = false
}

resource "aws_network_interface" "service" {
  subnet_id         = var.service_subnets[0]
  private_ips       = [cidrhost(data.aws_subnet.service_subnet.cidr_block, 12)]
  security_groups   = ["${var.sg_id}"]
  source_dest_check = false
}

# Allocate and assign public IP address

resource "aws_eip" "edge_transport" {
  vpc                       = true
  network_interface         = aws_network_interface.transport.id
  associate_with_private_ip = tolist(aws_network_interface.transport.private_ips)[0]
  depends_on                = [aws_instance.edge]
  tags = merge(
    var.common_tags,
    {
      Name = "edge_eip_transport"
    }
  )
}

