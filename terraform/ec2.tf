data "aws_ami" "latest_jenkins_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = var.JENKINS_IMAGE_FILTERS
  }
}

/*resource "aws_key_pair" "ssh_key" {
  key_name   = "jenkins_ssh"
  public_key = var.rsa_public
}*/

data "template_file" "startup_script" {
  template = file("${path.module}/userdata.sh")
  vars = {
    JENKINS_DOMAIN_NAME = var.JENKINS_DOMAIN_NAME
    CERTBOT_EMAIL       = var.CERTBOT_EMAIL
  }
}

resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.latest_jenkins_ami.id
  instance_type          = var.JENKINS_EC2_INSTANCE_TYPE
  key_name               = var.JENKINS_KEY_PAIR
  subnet_id              = aws_subnet.jenkins_subnet[0].id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = data.template_file.startup_script.rendered

  root_block_device {
    delete_on_termination = true
    volume_size           = var.JENKINS_DISK_SIZE
    volume_type           = var.JENKINS_DISK_TYPE
  }

  tags = {
    Name = var.JENKINS_EC2_NAME
  }
}

