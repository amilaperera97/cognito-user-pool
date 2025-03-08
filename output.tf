output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "api_gateway_url" {
  value = aws_api_gateway_stage.user_pool_stage.invoke_url
}
