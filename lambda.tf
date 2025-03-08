resource "aws_lambda_function" "login_register_lambda" {
  filename      = "${path.module}/user-pool-lambda/user-pool-lambda.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec.arn
  handler       = "user-pool-lambda.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      USER_POOL_ID = aws_cognito_user_pool.user_pool.id
      CLIENT_ID    = aws_cognito_user_pool_client.user_pool_client.id
    }
  }
#   depends_on = [aws_cloudwatch_log_group.lambda_log_group]
}
