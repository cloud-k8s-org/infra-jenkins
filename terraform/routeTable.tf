resource "aws_route_table" "jenkins_route_table" {
  vpc_id = aws_vpc.jenkins_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_internet_gateway.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "aws_public_route_table_association" {
  count          = length(var.PUBLIC_SUBNET_NAMES)
  subnet_id      = aws_subnet.jenkins_subnet[count.index].id
  route_table_id = aws_route_table.jenkins_route_table.id
}

