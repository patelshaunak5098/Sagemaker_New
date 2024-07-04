resource "null_resource" "package_lambda" {
  provisioner "local-exec" {
    command = "powershell.exe -ExecutionPolicy Bypass -File ./package_lambda.ps1"
    working_dir = path.module
  }

  # Trigger re-execution whenever the script changes
  triggers = {
    script = filebase64sha256("${path.module}/package_lambda.ps1")
  }
}


resource "aws_lambda_function" "lambda_function" {
  depends_on = [null_resource.package_lambda]  # Ensure the ZIP file is created first

  filename         = "lambda_function.zip"  # Path to your Lambda function zip file
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = var.lambda_handler
  runtime          = var.runtime
  source_code_hash = filebase64sha256("lambda_function.zip")

  environment {
    variables = var.environment_variables
  }

  timeout     = var.timeout
  memory_size = var.memory_size

  lifecycle {
    create_before_destroy = true  # Optional: to avoid downtime
  }
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

