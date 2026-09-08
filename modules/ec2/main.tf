resource "tls_private_key" "ec2_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ec2_key.public_key_openssh

  tags = merge(var.tags, {
    Name = var.key_name
  })
}

resource "local_sensitive_file" "ec2_private_key" {
  content         = tls_private_key.ec2_key.private_key_openssh
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0600"
}

resource "aws_security_group" "nginx_sg" {
  name        = "${var.environment}-nginx-sg"
  description = "Security group for the cloud-init NGINX EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from trusted IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-nginx-sg"
  })
}

resource "aws_instance" "app_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true

  user_data                   = file("${path.module}/cloud-init.yaml")
  user_data_replace_on_change = true

  tags = merge(var.tags, {
    Name = "${var.environment}-cloud-init-nginx"
  })
}