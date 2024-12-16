variable "default_region" {
  default = "eu-west-1"
}

variable "user_pool_name" {
  default = "my-user-pool"
}

variable "user_pool_client_name" {
  default = "my-user-pool-client"
}

variable "callback_urls" {
  type    = list(string)
  default = ["http://localhost:3000/callback"] # Adjust for your app
}
