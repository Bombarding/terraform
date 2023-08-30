module "aws_cognito_user_pool_simple" {
  source = "lgallard/cognito-user-pool/aws"

  user_pool_name = var.cognito_pool_name
  tags = {
    Owner       = "Bombarding"
    Environment = "Testing"
    Terraform   = true
  }

  password_policy = {
    minimum_length                   = 10
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 90
  }

  recovery_mechanisms = [
    {
      name     = "verified_email"
      priority = 1
    },
    {
      name     = "verified_phone_number"
      priority = 2
    }
  ]
}
