output "nginx_url" {
  description = "Open this URL to verify the NGINX cloud-init deployment"
  value       = "http://${module.ec2.instance_public_ip}"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.network.public_subnet_id
}

output "instance_id" {
  description = "ID of the WordPress EC2 instance"
  value       = module.ec2.instance_id
}

output "instance_public_ip" {
  description = "Public IP of the WordPress EC2 instance"
  value       = module.ec2.instance_public_ip
}

output "key_pair_name" {
  description = "Name of the EC2 key pair"
  value       = module.ec2.key_pair_name
}

output "private_key_filename" {
  description = "Filename of the generated private key"
  value       = module.ec2.private_key_filename
}