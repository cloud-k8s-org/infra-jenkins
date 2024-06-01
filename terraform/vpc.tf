resource "aws_vpc" "jenkins_vpc" {
  cidr_block           = var.JENKINS_VPC_CIDR
  enable_dns_hostnames = true
  tags = {
    Name = var.JENKINS_VPC_TAG_NAME
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "jenkins_subnet" {
  count                   = length(var.PUBLIC_SUBNET_NAMES)
  vpc_id                  = aws_vpc.jenkins_vpc.id
  cidr_block              = cidrsubnet(var.JENKINS_VPC_CIDR, 8, count.index + 10)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.PUBLIC_SUBNET_NAMES[count.index]
  }
}

