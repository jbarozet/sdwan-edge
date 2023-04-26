
/*
Create VPC Peering
*/

data "aws_vpc" "primary" {
  provider = aws.primary
  filter {
    name   = "tag:Name"
    values = [var.vpc_name_primary]
  }
}

data "aws_vpc" "secondary" {
  provider = aws.secondary
  filter {
    name   = "tag:Name"
    values = [var.vpc_name_secondary]
  }
}

data "aws_caller_identity" "secondary" {
  provider = aws.secondary
}

/**
 * VPC peering connection.
 *
 * Establishes a relationship resource between the "primary" and "secondary" VPC.
 */

# Requester's side of the connection.

resource "aws_vpc_peering_connection" "pcx" {
  provider = aws.primary
  vpc_id      = data.aws_vpc.primary.id
  peer_vpc_id = data.aws_vpc.secondary.id
  peer_owner_id = data.aws_caller_identity.secondary.account_id
  peer_region   = var.region_secondary
  auto_accept = false

  tags = {
    Name = "${var.name}-pcx-requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "pcx" {
  provider                  = aws.secondary
  vpc_peering_connection_id = aws_vpc_peering_connection.pcx.id
  auto_accept               = true

  tags = {
    Name = "${var.name}-pcx-accepter"
  }
}


/**
 * Route rules.
 *
 * Creates a new route rule on the "primary" VPC route tables. All requests
 * to the "secondary" VPC's CIDR block will be directed to the VPC peering
 * connection.
 *
 * Creates a new route rule on the "secondary" VPC route tables. All
 * requests to the "primary" VPC's CIDR will be directed to the VPC
 * peering connection.
 *
 * NOTE:
 * To send traffic from your instance to an instance in a peer VPC 
 * using private IPv4 addresses, you must add a route to the route table 
 * that's associated with the subnet in which the instance resides.
 * Updating all route tables for now
 *
 */

data "aws_route_tables" "secondary" {
  provider = aws.secondary
  vpc_id = data.aws_vpc.secondary.id
}

data "aws_route_tables" "primary" {
  provider = aws.primary
  vpc_id = data.aws_vpc.primary.id
}

resource "aws_route" "secondary" {
  provider = aws.secondary
  count                     = length(data.aws_route_tables.secondary.ids)
  route_table_id            = data.aws_route_tables.secondary.ids[count.index]
  destination_cidr_block    = data.aws_vpc.primary.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.pcx.id
}

resource "aws_route" "primary" {
  provider = aws.primary
  count                     = length(data.aws_route_tables.primary.ids)
  route_table_id            = data.aws_route_tables.primary.ids[count.index]
  destination_cidr_block    = data.aws_vpc.secondary.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.pcx.id
}

