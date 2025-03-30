resource "aws_eip" "jenkins_elastic_ip" {
  domain   = "vpc"
  instance = aws_instance.jenkins_server.id
}

/*data "aws_eip" "existing_eip" {
  public_ip = var.aws_elastic_ip
}
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.jenkins_server.id
  allocation_id = data.aws_eip.existing_eip.id
}

output "eip_allocation_id" {
  value = data.aws_eip.existing_eip.id
}*/

data "aws_route53_zone" "hosted_zone" {
  name = var.JENKINS_DOMAIN_NAME
}

resource "aws_route53_record" "jenkins_dns_record" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = data.aws_route53_zone.hosted_zone.name
  type    = "A"
  ttl     = "60"
  records = [aws_eip.jenkins_elastic_ip.public_ip]
}