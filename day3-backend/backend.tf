terraform {
  backend "s3" {
    bucket = "s3bukkeeett"           #your created bucket name
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
