data "aws_ami" "joindevops" {
    owners           = ["973714476881"]
    most_recent      = true

    filter {
        name = "name"
        values = ["OpenVPN Access Server Community Image-3b5882c4-*"]
    }

     filter {
        name = "root-device-type"
        values = ["ebs"]
    }
    
        filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    
    
}

data "aws_ssm_parameter" "bastion_sg_id" {
    name = "/${var.project_name}/${var.environment}/bastion_sg_id"

}

data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/public_subnet_ids"

}

data "aws_ssm_parameter" "open_vpn_sg_id" {
    name = "/${var.project_name}/${var.environment}/open_vpn_sg_id"

}