provider "aws" {
  region = "us-east-1"
}

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

resource "aws_autoscaling_group" "example" {
  name                      = "jenkins-asg-demo"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }
  vpc_zone_identifier       = ["subnet-0c1b59f28843d6284", "subnet-0b6dd7690769ced7e"] 
  health_check_type         = "EC2"
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "ASG Instance"
    propagate_at_launch = true
  }
}
