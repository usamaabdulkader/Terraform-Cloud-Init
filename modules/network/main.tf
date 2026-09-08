resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(var.tags, {
    Name = "${var.environment}-vpc"
  })
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.environment}-public-subnet"
    Type = "public"
  })
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = merge(var.tags, {
    Name = "${var.environment}-igw"
  })
}

resource "aws_default_route_table" "public_route_table" {
  default_route_table_id = aws_vpc.demo_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-public-route-table"
  })
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_default_route_table.public_route_table.id
}