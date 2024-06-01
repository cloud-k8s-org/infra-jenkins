variable "REGION" {
  type    = string
  default = "us-east-1"
}

variable "PROFILE" {
  type    = string
  default = "dev"
}

variable "JENKINS_VPC_CIDR" {
  type    = string
  default = "10.0.0.0/16"
}

variable "JENKINS_VPC_TAG_NAME" {
  type    = string
  default = "JenkinsVPC"
}

variable "PUBLIC_SUBNET_NAMES" {
  type    = list(string)
  default = ["PublicSubnet1"]
}

variable "INTERNET_GATEWAY_NAME" {
  type    = string
  default = "JenkinsInternetGateway"
}

variable "JENKINS_VPC_SECURITY_GROUP_NAME" {
  type    = string
  default = "JenkinsSecurityGroup"
}

variable "JENKINS_DISK_SIZE" {
  type    = number
  default = 50
}

variable "JENKINS_DISK_TYPE" {
  type    = string
  default = "gp2"
}

variable "JENKINS_EC2_NAME" {
  type    = string
  default = "JenkinsServer"
}

variable "JENKINS_IMAGE_FILTERS" {
  type    = list(string)
  default = ["jenkins-ami-*"]
}

variable "JENKINS_EC2_INSTANCE_TYPE" {
  type    = string
  default = "t2.micro"
}

variable "JENKINS_DOMAIN_NAME" {
  type = string
}

variable "CERTBOT_EMAIL" {
  type = string
}

variable "JENKINS_KEY_PAIR" {
  type    = string
  default = "jenkins_ec2"
}

variable "JENKINS_AMI_OWNERS" {
  type = list(string)
}

/*variable "" {
  type =
  default =
}*/
