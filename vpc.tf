# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_tag
  }
}

# Subnet
resource "aws_subnet" "main_subnet" {
vpc_id     = aws_vpc.main_vpc.id
cidr_block = var.subnet_cidr

  tags = {
    Name = var.subnet_tag
  }
  depends_on = [ aws_vpc.main_vpc ]
}

# igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.igw_tag
  }
}


# Route-able
resource "aws_route_table" "main_route-table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.route_table_tag
  }
}

# Route-table association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route-table.id
}

# Routes
resource "aws_route" "public-rt" {
  route_table_id              = aws_route_table.main_route-table.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block    = "0.0.0.0/0"
}