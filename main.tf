module "network" {
  source = "./modules/network"
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

module "ec2" {
  source           = "./modules/ec2"
  environment      = var.environment
  vpc_id           = module.network.vpc_id
  subnet_id        = module.network.public_subnet_id
  instance_type    = var.instance_type
  ami_id           = var.ami_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
  key_name         = var.key_name
}