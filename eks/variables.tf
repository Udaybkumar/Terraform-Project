variable "aws-region" {default = "ap-southeast-1"}
variable "env" {default = "dev"}
variable "cluster-name" {default = "eks-cluster"}
variable "vpc-cidr-block" {default = "10.0.0.0/16"}
variable "vpc-name" {default = "vpc"}
variable "igw-name" {default = "igw"}
variable "pub-subnet-count" {default = 3}
variable "pub-cidr-block" {
  type = list(string)
  default = [
    "10.0.100.0/24",
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}
variable "pub-availability-zone" {
  type = list(string)
  default = [
    "ap-southeast-1a",
    "ap-southeast-1b",
    "ap-southeast-1c"
  ]
}
variable "pub-sub-name" {default = "subnet-public"}
variable "pri-subnet-count" {default = 3}
variable "pri-cidr-block" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"]
}
variable "pri-availability-zone" {
  type = list(string)
  default = [ 
    "ap-southeast-1a",
    "ap-southeast-1b",
    "ap-southeast-1c"
  ] 
}
variable "pri-sub-name" { default = "subnet-private"}
variable "public-rt-name" {default = "public-route-table"}
variable "private-rt-name" {default = "private-route-table"}
variable "eip-name" {default = "elasticip-ngw"}
variable "ngw-name" {default = "ngw"}
variable "eks-sg" {default = "eks-sg" }


# EKS
variable "is-eks-cluster-enabled" { default = true}
variable "cluster-version" {  default = "1.33" }
variable "endpoint-private-access" {  default = true }
variable "endpoint-public-access" { default = false }
variable "ondemand_instance_types" {
  default = ["t3.micro"]
  type = list(string)
}
variable "spot_instance_types" {
  default = ["t3.micro"]
  type = list(string) 
}

variable "docker_image_uri" {
  description = "Docker image URI for the website"
  type        = string
  default     = "493263630011.dkr.ecr.ap-southeast-1.amazonaws.com/website:latest"
}

//variable "spot_instance_types" {}
variable "desired_capacity_on_demand" { default = 1}
variable "min_capacity_on_demand" { default = 1}
variable "max_capacity_on_demand" { default = 3}
variable "desired_capacity_spot" { default = 1}
variable "min_capacity_spot" { default = 1}
variable "max_capacity_spot" { default = 3}
variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

}