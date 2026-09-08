output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.demo_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}