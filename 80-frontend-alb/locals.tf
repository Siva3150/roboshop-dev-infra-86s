locals {
  common_name_suffix = "${var.project_name}-${var.environment}"
  frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value 
  frontend_alb_certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value
  public_subent_ids = split("," , data.aws_ssm_parameter.public_subent_ids.value)
  common_tags = {
    Project = "roboshop"
    environment = "dev"
    Terraform = true 
  }

}