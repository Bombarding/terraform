module "aws_cognito_user_pool_simple" {

  source = "lgallard/cognito-user-pool/aws"

  user_pool_name = "cognito-pool"

  tags = {
    Owner       = "expuhloiting"
    Environment = "testing"
    Terraform   = true
  }
}
