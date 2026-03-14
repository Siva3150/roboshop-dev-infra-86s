#  data "aws_ami" "openvpn" {
# owners           = ["679593333241"]
# #   owners           = ["137112412989"]

#    most_recent      = true

#   filter {
#      name   = "name"
#      values = ["OpenVPN Access Server Community Image-fe8020db-5343-4c43-9e65-5ed4a825c931"]
#    }



#   filter {
#      name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {    
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#  }

# data "aws_ami" "openvpn" {
#   image_id = "ami-06e5a963b2dadea6f"
# }


data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project_name}/${var.environment}/bastion_sg_id"

}

data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/public_subnet_ids"

}

data "aws_ssm_parameter" "open_vpn_sg_id" {
    name = "/${var.project_name}/${var.environment}/open_vpn_sg_id"

}