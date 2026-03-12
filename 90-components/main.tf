# module "components" {
#     source = "../../terraform-roboshop-component-86s"
#     component = var.component
#     rule_priority = var.rule_priority
  
# }

module "components" {
    for_each = var.components
    source = "git::https://github.com/Siva3150/terraform-roboshop-component-86s.git?ref=main"
    component = each.key
    rule_priority = each.value 
  
}