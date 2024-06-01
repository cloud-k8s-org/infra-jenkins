resource "aws_eip" "jenkins_elastic_ip" {
  domain   = "vpc"
  instance = aws_instance.jenkins_server.id
}

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