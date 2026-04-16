variable "aws_region" {
  default = "ap-south-1"
}

variable "server_count" {
  description = "Number of instances in Auto Scaling Group"
  type        = number
  default     = 2  # no.of server
}