# AWS_TERRAFORM_EXAMPLE:
# https://github.com/terraform-providers/terraform-provider-aws/blob/master/examples/two-tier/README.md
# https://github.com/gruntwork-io/terratest/blob/master/examples/terraform-packer-example/main.tf

# TODO: terraform_remote_state https://www.terraform.io/docs/backends/types/s3.html

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:Name"
    values = ["example"]
  }

}

data "aws_vpc" "selected" {
  id = "${var.AWS_VPC_ID}"
}

data "aws_subnet" "selected" {
  id ="${var.AWS_SUBNET_ID}"
}

# Our default security group to access the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "terraform_example"
  description = "Used in the terraform"
  vpc_id      = "${data.aws_vpc.selected.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Resource type is "aws_instance" and the name is "example."
# The prefix of the type maps to the provider. 
resource "aws_instance" "example" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = "${data.aws_subnet.selected.id}"

  # Must be already loaded up private key name pair in aws
  key_name      = "test"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  tags {
    ENV = "test"
    Name = "IAC Example"
  }

  lifecycle {
    create_before_destroy = true
  }
}
