## Infrastructure as Code (IaC)

### Drone CI/CD Server

init > script (under this directory): $ `docker-compose up -d`

### CI Pipeline Example

Please see `.drone.yml` under example folder

---

## Quick demo

- Step 1 - Packer Build AMI

  > script: `packer build packer/example-image.json`

- Step 2 - Terraform build infrastructure

  > script: `terraform init` && `terraform apply`

- Step 3 - Start Ansible Playbook

  required: setup *ansible_host* in hosts.yml (you can get public dns from terraform output)

  > script: `ansible-playbook deploy-playbook.yml`

### Packer

Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration.

#### Build AWS AMI

*required: setup environment variables first*

- AWS_ACCESS_KEY: need for connection with aws
- AWS_SECRET_KEY: need for connection with aws
- AWS_VPC_ID: need for create t2.micro AMI
- AWS_SUBNET_ID: need for create t2.micro AMI

> You can create .env.sh (see .env.sh.example) & `source .env.sh` in command-line

> script: `packer build packer/example-image.json`

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

> You can create .env.sh (see .env.sh.example) & `source .env.sh` in command-line

> script: `terraform apply`

### Ansible

Ansible delivers simple IT automation that ends repetitive tasks and frees up DevOps teams for more strategic work.

*required: setup below first*

- ansible.cfg (need private_key_file)
- hosts.yml
  - setup *ansible_host* from aws instance created from terraform
  - node_version MUST be full node version

#### Start ansible-playbook

> script: `ansible-playbook deploy-playbook.yml`