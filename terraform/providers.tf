# The provider block is used to configure the named provider, in our case "aws".
provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "us-east-1"
}