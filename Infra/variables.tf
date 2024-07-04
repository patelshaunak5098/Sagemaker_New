variable "lambda_function_name" {
  default = "sagemaker_function"
}

variable "lambda_handler" {
  default = "lambda_function.handler"
}

variable "runtime" {
  default = "python3.12"
}

variable "memory_size" {
  default = 128
}

variable "timeout" {
  default = 300
}

variable "environment_variables" {
  type    = map(string)
  default = {
    foo = "bar"
  }
}
