module "components" {
    source = "../../terraform-roboshop-component-86s"
    component = var.component
    rule_priority = var.rule_priority
  
}