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
# resource "aws_ec2_instance_state" "catalogue" {
#   instance_id = aws_instance.bastion.id
#   state       = "stopped" # The desired state for the instance
#   depends_on = [ terraform_data.catalogue ]
# }

# Create the AMI from the catalogue instance
# resource "aws_ami_from_instance" "catalogue" {
#   name               =  "${local.common_name_suffix}-catalogue-ami"
#   source_instance_id = aws_instance.catalogue.id 
#   depends_on = [ aws_ec2_instance_state.catalogue ]
#   # Optional: add a description
#   description        = "AMI created from an existing instance via Terraform"

#     tags = merge (
#         local.common_tags,
#         {
#             Name = "${local.common_name_suffix}-catalogue-ami" # roboshop-dev-mongodb
#         }
#   )
# }