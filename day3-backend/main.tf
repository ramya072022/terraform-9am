resource "aws_instance" "name" {
    ami = "ami-0de716d6197524dd9"
    instance_type = "t3.small"
    tags = {
      Name = "ec2server"
    }
  
}