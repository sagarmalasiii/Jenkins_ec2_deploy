provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

# Create public subnets in different availability zones
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Create a route table for the public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate route table with public subnets
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# Launch Template
resource "aws_launch_template" "example" {
  name_prefix   = "jenkins-demo-"
  image_id      = "ami-02457590d33d576c3"
  instance_type = "t2.micro"

  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt update
sudo apt install -y nginx
echo "Hello from Terraform with User Data!" > /var/www/html/index.html
EOF
  )
}

# Auto Scaling Group using created subnets
resource "aws_autoscaling_group" "example" {
  name                 = "jenkins-asg-demo"
  max_size             = 2
  min_size             = 1
  desired_capacity     = 1

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    aws_subnet.public1.id,
    aws_subnet.public2.id,
  ]

  health_check_type = "EC2"
  force_delete     = true

  tag {
    key                 = "Name"
    value               = "ASG Instance"
    propagate_at_launch = true
  }
}
