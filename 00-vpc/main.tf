module "vpc" {
    # source = "../terraform-aws-vpc-86s"
    # vpc_cidr = "10.0.0.0/16"
    # project = "roboshop"
    # environment = "dev"

    
    # VPC
    #source = "../terraform-aws-vpc-86s"
    source = "git::https://github.com/Siva3150/terraform-aws-vpc-86s.git?ref=main"
    vpc_cidr = var.vpc_cidr
    project = var.project
    environment = var.environment
    vpc_tags = var.vpc_tags
    

    # public subnets
    public_subnet_cidrs = var.public_subnet_cidrs
    

    # private subnets
    private_subnet_cidrs = var.private_subnet_cidrs
    

    #database subnets
    database_subnet_cidrs = var.database_subnet_cidrs

    is_peering_required = true 


}

# data "aws_availability_zones" "available" {
#   state = "available"
# }


