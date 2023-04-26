/*
  Security Groups
*/
resource "aws_security_group" "transport" {
  name        = "SD-WAN"
  description = "Allow SD-WAN Control Plane and Management Traffic"

  vpc_id = "${aws_vpc.sdwan_vpc.id}"

  ingress {
    from_port        = 23456
    to_port          = 24156
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 12346
    to_port          = 13046
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = "${var.acl_cidr_blocks}"
    ipv6_cidr_blocks = "${var.acl6_cidr_blocks}"
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = "${var.acl_cidr_blocks}"
    ipv6_cidr_blocks = "${var.acl6_cidr_blocks}"
  }

  ingress {
    from_port        = 8443
    to_port          = 8443
    protocol         = "tcp"
    cidr_blocks      = "${var.acl_cidr_blocks}"
    ipv6_cidr_blocks = "${var.acl6_cidr_blocks}"
  }

  ingress {
    from_port        = 830
    to_port          = 830
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 8
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "SD-WAN"
    }
  )
}

resource "aws_security_group" "service" {

  vpc_id = "${aws_vpc.sdwan_vpc.id}"

  egress {
    from_port   = 0
    to_port 	= 0
    protocol 	= -1
    cidr_blocks	= ["0.0.0.0/0"]
  }

  ingress {
    from_port 	= 0
    to_port 	= 0
    protocol 	= "-1"        
    cidr_blocks = ["0.0.0.0/0"]
  }   

  tags = merge(
    var.common_tags,
    {
      Name = "SD-WAN"
    }
  )
}

