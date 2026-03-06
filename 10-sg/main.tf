# Using Open source module
# module "sg" {

#     source = "terraform-aws-modules/security-group/aws"

#   name        = "${local.common_name_suffix}-catalogue"
#   use_name_prefix = false
#   description = "Security group for catalogue with custom ports open within VPC, egress all traffic"
#   vpc_id = data.aws_ssm_parameter.vpc_id.value 

# }

#Using variables
module "sg" {
    count = length(var.sg_names)
    source = "git::https://github.com/Siva3150/terraform-aws-sg-86s.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    sg_name = var.sg_names[count.index]
    sg_description = "Created for ${var.sg_names[count.index]}"
    vpc_id = local.vpc_id


  
}

# #Using Locals
# module "sg" {
#     count = length(local.sg_names)
#     source = "git::https://github.com/Siva3150/terraform-aws-sg-86s.git?ref=main"
#     project_name = var.project_name
#     environment = var.environment
#     sg_name = local.sg_names[count.index]
#     sg_description = "Created for ${var.sg_names[count.index]}"
#     vpc_id = local.vpc_id


  
# }

