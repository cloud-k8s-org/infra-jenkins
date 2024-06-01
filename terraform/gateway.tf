resource "aws_internet_gateway" "jenkins_internet_gateway" {
  vpc_id = aws_vpc.jenkins_vpc.id
  tags = {
    "Name" = var.INTERNET_GATEWAY_NAME
  }
}