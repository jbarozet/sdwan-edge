output "transport-EIP" {
  value = aws_eip.edge_transport.public_ip
}

output "transport-private-ip" {
  value = aws_network_interface.transport.private_ips
}

output "service-private-ip" {
  value = aws_network_interface.service.private_ips
}

