locals {
  common_name_suffix = "${var.project_name}-${var.environment}" # roboshop-dev

  vpc_id = data.aws_ssm_parameter.vpc_id.value 

  sg_names = [
    # Database
    "mongodb-${local.common_name_suffix}",
    "redis-${local.common_name_suffix}",
    "mysql-${local.common_name_suffix}",
    "rabbitmq-${local.common_name_suffix}",

    #Backend 
    "catalogue-${local.common_name_suffix}",
    "user-${local.common_name_suffix}",
    "cart-${local.common_name_suffix}",
    "shipping-${local.common_name_suffix}",
    "payment-${local.common_name_suffix}",

    #Frontend
    "frontend-${local.common_name_suffix}",

    #Bastion
    "bastion-${local.common_name_suffix}",

    #Frontend-ALB
    "frontend-alb-${local.common_name_suffix}"
    
  ]

}