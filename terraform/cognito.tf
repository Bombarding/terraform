module "aws_cognito_user_pool_simple" {
  source = "lgallard/cognito-user-pool/aws"

  user_pool_name = var.cognito_pool_name
  tags = {
    Owner       = "Bombarding"
    Environment = "testing"
    Terraform   = true
  }
}
