resource "aws_cognito_user_pool" "user_pool" {
  name = var.user_pool_name

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  auto_verified_attributes = ["email"]

  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    mutable             = false

    string_attribute_constraints {
      min_length = 5
      max_length = 50
    }
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                      = var.user_pool_client_name
  user_pool_id              = aws_cognito_user_pool.user_pool.id
  generate_secret           = false
  allowed_oauth_flows       = ["code", "implicit"]
  allowed_oauth_scopes      = ["email", "openid"]
  supported_identity_providers = ["COGNITO"]
  callback_urls             = var.callback_urls
}
