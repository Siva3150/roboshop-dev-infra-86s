# resource "aws_key_pair" "openvpn" {
#   key_name   = "daws-88s"
#   public_key = file("C:\\Users\\HP\\Devops\\daws-88s\\openvpn.pub")
# }


resource "aws_instance" "openvpn" {
  ami           = "ami-06e5a963b2dadea6f"
  #ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.open_vpn_sg_id]
  subnet_id = local.public_subent_ids
  key_name = "daws-88s" # make sure this key exist in AWS -- id you have already keypair created
  #key_name = aws_key_pair.openvpn.key_name
  user_data = file("vpn.sh") 
 
    
  tags = merge(
    local.common_tags,
    {
      Name =  "${local.common_name_suffix}-openvpn"
    }
  )
}

resource "aws_route53_record" "openvpn" {
  zone_id = var.zone_id
  name    = "openvpn.${var.domain_name}" # openvpn.sivadevops.space 
  type    = "A"
  ttl     = 1
  records = [aws_instance.openvpn.public_ip]
  allow_overwrite = true
}