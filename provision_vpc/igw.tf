/*
  Internet Gateway
*/
resource "aws_internet_gateway" "sdwan_vpc" {
  vpc_id = "${aws_vpc.sdwan_vpc.id}"

  tags = merge(
    var.common_tags,
    {
      Name = "SD-WAN"
    }
  )
}
