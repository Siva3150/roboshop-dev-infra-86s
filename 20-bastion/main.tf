resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subent_ids

  user_data = file("bastion.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion.name 

  tags = merge(
    local.common_tags,
    {
      Name =  "${local.common_name_suffix}-bastion"
    }
  )
}

resource "aws_iam_instance_profile" "bastion" {
  name = "Bastion"
  role = "Bastion-Role"
}