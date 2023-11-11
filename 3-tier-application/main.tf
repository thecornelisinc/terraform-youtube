# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_tag
  }
}

# Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw
  }
}


# Public Subnet
resource "aws_subnet" "main" {
  count      = 2
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block = var.public_subnet_cidr[count.index]
  tags = {
    Name = "${var.public_subnet_tag} ${count.index + 1}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  count      = 4
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  tags = {
    Name = "${var.private_subnet_tag} ${count.index + 1}"
  }
}

# Database Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = "database_subnet_group"
  subnet_ids = [aws_subnet.private_subnet[2].id, aws_subnet.private_subnet[3].id]
  tags = {
    Name = "My DB subnet group"
  }
}

# Public Subnet Route table
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "Public-Route-table"
  }
}

# Public Route-table Association
resource "aws_route_table_association" "a" {
  count          = 2
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.example.id
}

# Private Route Tables
resource "aws_route_table" "private_subnet_rt" {
  count = 4
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.private_subnet_rt} ${count.index + 1}" 
  }
}

# Public Route-table Association
resource "aws_route_table_association" "b" {
  count          = 4
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_subnet_rt[count.index].id
}

# Elatic IP address
resource "aws_eip" "lb" {
domain = "vpc"
tags = {
    Name = "Training-EIP"
}
}


# Nat Gateway 
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.main[0].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

# Route to the natgateway
resource "aws_route" "r" {
  count = 4
  route_table_id            = aws_route_table.private_subnet_rt[count.index].id
  destination_cidr_block    = var.private_subnet_cidr[count.index]
  nat_gateway_id = aws_nat_gateway.example.id
}



# Presentation layer
# Public EC2 Instances

resource "aws_instance" "web" {
    count=2
  ami           = var.ami
  instance_type = var.instance_type
 subnet_id = aws_subnet.main[count.index].id
  tags = {
    Name = "${var.web_instance_tag} ${count.index + 1}"
  }
}

# Subnet
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
# Load Balancer Target group
resource "aws_lb_target_group" "web-tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}



# Load Balancer for web servers
resource "aws_lb" "web-alb" {
  name               = "WebLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [for subnet in aws_subnet.main : subnet.id]

  tags = {
    Environment = "production"
  }
}

# Target group instance attachment
resource "aws_lb_target_group_attachment" "test" {
    count =2
  target_group_arn = aws_lb_target_group.web-tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}


# Load Balancer lister

resource "aws_lb_listener" "web-lister" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}
# Application Layer
resource "aws_instance" "application" {
    count=2
  ami           = var.ami
  instance_type = var.instance_type
 subnet_id = aws_subnet.private_subnet[count.index].id
  tags = {
    Name = "${var.app_instance_tag} ${count.index + 1}"
  }
}

resource "aws_lb_target_group" "application-tg" {

  name     = "application-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

# Target group instance attachment
resource "aws_lb_target_group_attachment" "test1" {
    count = 2
  target_group_arn = aws_lb_target_group.application-tg.arn
  target_id        = aws_instance.application[count.index].id
  port             = 80
}


# Load Balancer for application servers
resource "aws_lb" "app-alb" {
  name               = "ApplicationLoadBalancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id]

  tags = {
    Environment = "production"
  }
}

# Applicaiton Listinger
resource "aws_lb_listener" "app-lister" {
  load_balancer_arn = aws_lb.app-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application-tg.arn
  }
}
# Database Layer

resource "aws_kms_key" "a" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
  tags = {
    Name = "Training"
  }
}

# Database deployment
resource "aws_db_instance" "default" {
  allocated_storage           = 10
  db_name                     = "mydb"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t3.micro"
  manage_master_user_password = true
  master_user_secret_kms_key_id = aws_kms_key.a.id
  username                    = "foo"
  parameter_group_name        = "default.mysql5.7"
  db_subnet_group_name =  aws_db_subnet_group.default.name
}