
# variables (`source .env.sh` first)

# env
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_VPC_ID" {
  description = "Already existed VPC id"
}

variable "AWS_SUBNET_ID" {
  description = "Already existed VPC id which is public"
}