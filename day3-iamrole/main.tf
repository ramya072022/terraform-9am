
provider "aws" {
  region = "us-east-1" # Change if needed
}

# 1. IAM Role for EC2
resource "aws_iam_role" "ec2_admin_role_2" {
  name = "ec2_admin_role_2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# 2. Attach AdministratorAccess Policy
resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.ec2_admin_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# 3. Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_admin_profile_2" {
  name = "ec2_admin_profile_2"
  role = aws_iam_role.ec2_admin_role_2.name
}

# 4. Create EC2 Instance with IAM Role
resource "aws_instance" "my_admin_ec2" {
  ami           = "ami-0de716d6197524dd9" # Amazon Linux 2 AMI (region-specific)
  instance_type = "t3.micro"
  key_name      = "key-s" # Replace with your key name

  # Attach IAM Role via Instance Profile
  iam_instance_profile = aws_iam_instance_profile.ec2_admin_profile_2.name

  tags = {
    Name = "EC-Admin-Role"
  }
}
