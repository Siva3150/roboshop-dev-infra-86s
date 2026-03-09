resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id = local.private_subent_id

  tags = merge(
    local.common_tags,
    {
      Name =  "${local.common_name_suffix}-catalogue" # roboshop-dev-catalogue 
    }
  )
}

# catalogue
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id 
  ]

#connection block using to connect to server
  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.catalogue.private_ip
  }

 # terraform copies this file to mongodb server
  provisioner "file" {
    
        source = "catalogue.sh"
        destination = "/tmp/catalogue.sh" 
     
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/catalogue.sh",
        #"sudo sh /tmp/catalogue.sh"
         "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
     ]
    
  }


}

#Stop the catalogue instance
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id 
  state       = "stopped" # The desired state for the instance
  depends_on = [ terraform_data.catalogue ]
}

#Create the AMI from the catalogue instance
resource "aws_ami_from_instance" "catalogue" {
  name               =  "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id 
  depends_on = [ aws_ec2_instance_state.catalogue ]
  # Optional: add a description
  description        = "AMI created from an existing instance via Terraform"

    tags = merge (
        local.common_tags,
        {
            Name = "${local.common_name_suffix}-catalogue-ami" # roboshop-dev-mongodb
        }
  )
}

#Target group
resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name_suffix}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60 # waiting period before deleting the instance

  health_check {
    healthy_threshold = 2
    interval = 10
    matcher = "200-299"
    path = "/health"
    port = 8080
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 2
  }
}

resource "aws_launch_template" "catalogue" {
  name = "${local.common_name_suffix}-catalogue"
  image_id = aws_ami_from_instance.catalogue.id

  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"

  vpc_security_group_ids = [local.catalogue_sg_id]

  # when we run terraform apply again, a new version will be created with new AMI ID
  update_default_version = true

  # tags attached to the instance
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue"
      }
    )
  }

  # tags attached to the volume created by instance
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue"
      }
    )
  }

  # tags attached to the launch template
  tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue"
      }
  )

}