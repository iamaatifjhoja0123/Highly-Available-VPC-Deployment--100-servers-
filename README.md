# Highly Available AWS VPC Deployment via Terraform 🚀

## 📌 Project Overview
This project demonstrates a production-grade, highly available (HA) multi-tier network architecture on AWS using **Terraform (Infrastructure as Code)**. The core objective was to automate the deployment of a scalable web infrastructure that can spin up from 2 to 100+ servers with a single configuration change.

The architecture is designed across multiple Availability Zones (AZs) to ensure zero downtime and follows security best practices by isolating compute resources in private subnets.

![Top10News Architecture Diagram](diagram.png)

## 🏗️ Architecture Design
- **Networking:** Custom VPC with 2 Public Subnets (for ALB/NAT) and 2 Private Subnets (for App Servers) across 2 AZs.
- **Security:** Strict Security Group rules. Instances in private subnets only accept traffic from the Application Load Balancer.
- **Compute:** Auto Scaling Group (ASG) with Launch Templates for automated Nginx deployment.
- **Connectivity:** Internet Gateway for public access and NAT Gateway for private instances to fetch updates securely.
- **Load Balancing:** Application Load Balancer (ALB) to distribute incoming traffic evenly.

## 🛠️ Tech Stack
- **Cloud Provider:** AWS (Amazon Web Services)
- **IaC Tool:** Terraform
- **Web Server:** Nginx
- **OS:** Amazon Linux 2

## 📁 Project Structure
```text
.
├── providers.tf      # AWS Provider configuration
├── variables.tf      # Input variables (Region, Server Count, etc.)
├── network.tf        # VPC, Subnets, IGW, NAT, Route Tables
├── security.tf       # Security Groups for ALB and EC2
├── alb.tf            # Application Load Balancer & Target Groups
├── compute.tf        # ASG & Launch Templates
├── outputs.tf        # Public DNS of the Load Balancer
└── .gitignore        # Prevents sensitive .tfstate files from being pushed


🚀 Deployment Steps
Clone the repo:

git clone [https://github.com/iamaatifjhoja0123/Highly-Available-VPC-Deployment--100-servers-.git](https://github.com/iamaatifjhoja0123/Highly-Available-VPC-Deployment--100-servers-.git)
cd Highly-Available-VPC-Deployment--100-servers-

Initialize Terraform:

terraform init
terraform plan
terraform apply -auto-approve


⚡ The "1-Click Scaling" Magic
This project is built for scale. To increase the capacity from 2 servers to 100 servers:

Go to variables.tf

Update server_count default value to 100.

Run terraform apply.
Terraform will automatically provision 98 additional instances and register them with the Load Balancer without affecting the existing network.

🛡️ Cloud & DevOps Best Practices Implemented
Immutability: Infrastructure is defined as code, ensuring consistent deployments.

Security In Depth: No Public IPs for backend servers. Access is strictly managed via NAT Gateway and ALB.

High Availability: Resources are distributed across multiple AZs to survive a single data center failure.

Automated Provisioning: Used user_data scripts to automate Nginx installation upon instance launch.

🧠 Challenges & Troubleshooting
NAT Gateway Routing: Solved the issue where private instances couldn't install Nginx by implementing a NAT Gateway and updating Private Route Tables.

State Management: Used .gitignore to ensure environment-specific state files are not committed to version control.