locals {
  common_name_suffix = "${var.project_name}-${var.environment}"
  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value 
  private_subent_ids = split("," , data.aws_ssm_parameter.private_subent_ids.value)
  common_tags = {
    Project = "roboshop"
    environment = "dev"
    Terraform = true 
  }

}