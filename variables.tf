variable "default_region" {
  type    = string
  default = "eu-west-1"
}

variable "user_pool_name" {
  type    = string
  default = "my-user-pool"
}

variable "user_pool_client_name" {
  type    = string
  default = "my-user-pool-client"
}

variable "callback_urls" {
  type    = list(string)
  default = ["http://localhost:3000/callback"]
}

variable "lambda_function_name" {
  type    = string
  default = "LoginRegisterFunction"
}