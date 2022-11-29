module "aws_ecs" {
  source = "./aws_ecs"
  app_environment = var.app_environment
  app_name = var.app_name  
}