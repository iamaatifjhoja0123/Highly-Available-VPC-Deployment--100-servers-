
resource "aws_launch_template" "web" {
  name_prefix   = "web-server-"
  image_id      = "ami-051a31ab2f4d498f5" 
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  #  script Nginx web server install 
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "Hello World from Terraform Server" > /usr/share/nginx/html/index.html
              EOF
  )
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  
  
  desired_capacity    = var.server_count
  min_size            = 1
  max_size            = 150 # Upper limit set 

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
}