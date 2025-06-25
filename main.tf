# ─────────────────────────────────────────────
# VPC Module
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  name     = "sonarqube-vpc"
}

# ─────────────────────────────────────────────
# Subnet Module
module "subnet" {
  source               = "./modules/subnet"
  vpc_id               = module.vpc.vpc_id
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  project              = "sonarqube"
}

# ─────────────────────────────────────────────
# Internet Gateway Module
module "igw" {
  source  = "./modules/internet-gateway"
  vpc_id  = module.vpc.vpc_id
  project = "sonarqube"
}

# ─────────────────────────────────────────────
# NAT Gateway Module
module "nat" {
  source           = "./modules/nat-gateway"
  public_subnet_id = module.subnet.public_subnet_1_id
  igw_id           = module.igw.igw_id
  project          = "sonarqube"
}

# ─────────────────────────────────────────────
# Route Tables Module
module "route_tables" {
  source             = "./modules/route-tables"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.igw.igw_id
  nat_gateway_id     = module.nat.nat_gateway_id
  public_subnet_1_id = module.subnet.public_subnet_1_id
  public_subnet_2_id = module.subnet.public_subnet_2_id
  private_subnet_id  = module.subnet.private_subnet_id
  project            = "sonarqube"
}

# ─────────────────────────────────────────────
module "nacl" {
  source = "./modules/nacl"
  vpc_id = module.vpc.vpc_id
  subnet_ids = [
    module.subnet.public_subnet_1_id,
    module.subnet.public_subnet_2_id,
    module.subnet.private_subnet_id
  ]
  project = "sonarqube"
}

# ─────────────────────────────────────────────
# Security Group Module
module "security_group" {
  source  = "./modules/security-group"
  vpc_id  = module.vpc.vpc_id
  project = "sonarqube"
}

# ─────────────────────────────────────────────
# EC2 SonarQube Instance Module
module "sonarqube_instance" {
  source              = "./modules/ec2/sonarqube"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_name
  subnet_id           = module.subnet.private_subnet_id
  security_group_ids  = [module.security_group.sonarqube_sg_id]
  associate_public_ip = false
  project             = "sonarqube"
  sonar_password      = var.sonar_password

}

# ─────────────────────────────────────────────
# CloudWatch Module (optional)
# module "cloudwatch_alarm" {
#   source       = "./modules/cloudwatch"
#   instance_id  = module.sonarqube_instance.instance_id
#   project      = "sonarqube"
# }


# ─────────────────────────────────────────────
# EC2 Bastion Host (Public Subnet 1)
module "bastion_instance" {
  source             = "./modules/ec2/bastion"
  ami_id             = var.ami_id
  instance_type      = "t2.micro" # lightweight instance
  key_name           = var.key_name
  subnet_id          = module.subnet.public_subnet_1_id
  security_group_ids = [module.security_group.bastion_sg_id]
  project            = "sonarqube"
  ansible_key        = file(var.ansible_key_path)
}

# ─────────────────────────────────────────────
# ALB Module
module "alb" {
  source  = "./modules/alb"
  project = "sonarqube"
  vpc_id  = module.vpc.vpc_id
  subnet_ids = [
    module.subnet.public_subnet_1_id,
    module.subnet.public_subnet_2_id
  ]
  alb_sg_id             = module.security_group.alb_sg_id
  sonarqube_instance_id = module.sonarqube_instance.instance_id
}


