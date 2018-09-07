### Drone CI/CD Server

init script (under this directory): `docker-compose up -d`

### CI Pipeline Example

Put *.drone.yml* under project root folder

> Format of .drone.yml
> Please see `.drone.yml` under example folder

---

# Infrastructure as Code (IaC)

*See: relajet-kws-web folder*

## Quick Example (Integration Packer with Ansible)

set *Ansible* to provisioners (see provisioners section in packer/relajet-kws-web-image.json)

- Setp 0 - Setup awscli (if use terraform remote backend)

  for *mac*

  > script: `pip install awscli`
  > script: `aws configure`

- Step 1 - Packer build AMI

  under *packer* folder

  > script: `packer build relajet-kws-web-image.json`

- Step 2 - Terraform build AMI image from Packer 

  under *terraform* folder

  - If haven't init terraform before
    > script: `terraform init -backend-config config/backend-dev.conf`

  > script: `terraform apply`

- Step 3 - See output

---

## Quick Example - IaC with packer/terraform/ansible (deprecated)

You can see git commit

> commit 025df2a7ab19524a3189d7e8962a269f4f17b328
Author: vergil <vergil.wang@relajet.com>
Date:   Thu Sep 6 17:18:30 2018 +0800

- Step 1 - Packer build AMI

  > script: `packer build packer/relajet-kws-web-image.json`

- Step 2 - Terraform build infrastructure

  > If haven't init terraform before, script: `terraform init`

  > script: `terraform apply`

- Step 3 - Start Ansible Playbook

  required: setup *ansible_host* in hosts.yml (you can get public dns from terraform output)

  > script: `ansible-playbook deploy-playbook.yml`

## Devops Tools

### Packer

Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.

#### Build AWS AMI

*required: setup environment variables first*

- AWS_ACCESS_KEY: need for connection with aws
- AWS_SECRET_KEY: need for connection with aws
- AWS_VPC_ID: need for create t2.micro AMI
- AWS_SUBNET_ID: need for create t2.micro AMI

> You can create .env.sh (see .env.sh.example) &
`source .env.sh` in command-line

> script: `packer build packer/relajet-kws-web-image.json`

### Terraform

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.

Terraform can manage existing and popular service providers as well as custom in-house solutions.

#### Init terraform

> script: `terraform init`

> terraform.tfstate & terraform.tfstate.backup is *important*, this represent overall infrastructure and supervise every diff of your infrastructure, just like .git file

#### Create instance

*required: setup environment variables first*

- TF_VAR_AWS_ACCESS_KEY: need for connection with aws
- TF_VAR_AWS_SECRET_KEY: need for connection with aws
- TF_VAR_AWS_VPC_ID: need for create t2.micro AMI
- TF_VAR_AWS_SUBNET_ID: need for create t2.micro AMI
- TF_VAR_AWS_AMI_ID: need for start an AWS instance by AMI from Packer

> You can create .env.sh (see .env.sh.example) &
`source .env.sh` in command-line

> script: `terraform apply`

#### Destroy

Destroy all

> script: `terraform destroy`

Destroy specific resource

> script: `terraform destroy -target aws_instance=relajet_kws_web`

### Ansible

Ansible delivers simple IT automation that ends repetitive tasks and frees up DevOps teams for more strategic work.

*required: setup below first*

- ansible.cfg (need private_key_file)
  - Create folder for private keys: `mkdir -p privateKeyFiles/aws`
  - Put your private_key.pem under privateKeyFiles/aws & specify it in *private_key_file property* in *ansible.cfg*
- hosts.yml
  - setup *ansible_host* from aws instance created from terraform
  - node_version MUST be full node version

#### Start ansible-playbook

> script: `ansible-playbook deploy-playbook.yml`