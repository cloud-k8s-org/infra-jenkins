data "aws_ami" "latest_jenkins_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = var.JENKINS_IMAGE_FILTERS
  }
  owners = var.JENKINS_AMI_OWNERS
}

resource "aws_key_pair" "ec2_ssh_key" {
  key_name   = var.JENKINS_KEY_PAIR_NAME
  public_key = var.JENKINS_PUBLIC_KEY
}

resource "aws_instance" "jenkins_server" {
  ami           = data.aws_ami.latest_jenkins_ami.id
  instance_type = var.JENKINS_EC2_INSTANCE_TYPE
  key_name      = aws_key_pair.ec2_ssh_key.key_name
  subnet_id     = aws_subnet.jenkins_subnet[0].id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = templatefile("${path.module}/userdata.sh", {
    JENKINS_DOMAIN_NAME = var.JENKINS_DOMAIN_NAME
  })

  root_block_device {
    delete_on_termination = true
    volume_size           = var.JENKINS_DISK_SIZE
    volume_type           = var.JENKINS_DISK_TYPE
  }

  tags = {
    Name = var.JENKINS_EC2_NAME
  }
}

