output "instance_id" {
  description = "ID of the WordPress EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP of the WordPress EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "security_group_id" {
  description = "ID of the NGINX security group"
  value       = aws_security_group.nginx_sg.id
}

output "key_pair_name" {
  description = "Name of the EC2 SSH key pair"
  value       = aws_key_pair.ec2_key.key_name
}

output "private_key_filename" {
  description = "Local path of the generated private key"
  value       = local_sensitive_file.ec2_private_key.filename
}