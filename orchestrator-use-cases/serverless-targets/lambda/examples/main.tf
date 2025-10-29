# Example usage of the lambda-serverless-target module

terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    platform-orchestrator = {
      source  = "humanitec/platform-orchestrator"
      version = "~> 2.0"
    }
  }
}

provider "platform-orchestrator" {
  org_id = "your-org-id"
  # api_url = "https://api.humanitec.io"  # Use default production URL or specify custom
}

provider "aws" {
  region = "eu-central-1"
}

# Use the lambda-serverless-target module
module "lambda_serverless" {
  source = "../"

  # Platform Orchestrator Configuration
  org_id             = "your-org-id"
  project_id_prefix  = "lambda-use-case"
  env_id             = "dev"
  env_type_id_prefix = "development"

  # AWS Configuration
  aws_region = "eu-central-1"

  # ECS Runner Configuration
  ecs_runner_cluster_name       = "your-ecs-cluster"
  ecs_runner_subnet_ids         = ["subnet-xxxxxxxxxxxxx"]
  ecs_runner_security_group_ids = ["sg-xxxxxxxxxxxxx"]
  ecs_runner_prefix             = "ecs-runner"

  # OIDC Configuration
  oidc_hostname              = "your-oidc.hostname.dev"
  existing_oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/your-oidc.hostname.dev"

  # Lambda Configuration
  lambda_package_s3_bucket = "your-lambda-function-packages"
  lambda_timeout           = 100

  # Optional: customize the module/resource type ID
  # lambda_module_id_prefix = "lambda-zip"

  # Optional: customize the Lambda function name prefix
  # lambda_name_prefix = "$${context.project_id}-$${context.env_id}"

  # Optional: add or override inline IAM policies for Lambda execution role
  # lambda_additional_inline_policies = {
  #   s3_access = jsonencode({
  #     Version = "2012-10-17"
  #     Statement = [{
  #       Effect   = "Allow"
  #       Action   = ["s3:GetObject", "s3:PutObject"]
  #       Resource = "arn:aws:s3:::my-bucket/*"
  #     }]
  #   })
  # }

  lambda_runtime      = "provided.al2023"
  lambda_handler      = "bootstrap"
  lambda_memory_size  = 128
  # lambda_architectures = ["arm64"]  # Use ARM architecture instead of x86_64

  # Optional: Use a custom IAM role for Lambda
  # lambda_iam_role_arn = "arn:aws:iam::123456789012:role/my-lambda-role"

  # Optional: Add managed IAM policies to Lambda execution role
  # lambda_additional_managed_policy_arns = [
  #   "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  # ]

  # Optional: Add tags to Lambda function
  # lambda_additional_tags = {
  #   Application = "MyApp"
  #   Component   = "Backend"
  # }

  # Function URL Configuration (disabled by default)
  # lambda_enable_function_url = true  # Uncomment to enable function URL
  # lambda_function_url_auth_type = "NONE"  # Make function URL publicly accessible
  # lambda_function_url_cors = {
  #   allow_origins     = ["https://example.com"]
  #   allow_methods     = ["GET", "POST"]
  #   allow_headers     = ["Content-Type"]
  #   max_age           = 300
  # }

  # Optional: Additional tags for ECS runner and other resources
  additional_tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}

# Outputs
output "project_id" {
  description = "The ID of the created project"
  value       = module.lambda_serverless.project_id
}

output "environment_id" {
  description = "The ID of the created environment"
  value       = module.lambda_serverless.environment_id
}

output "ecs_runner_id" {
  description = "The ID of the ECS runner"
  value       = module.lambda_serverless.ecs_runner_id
}

output "lambda_deployment_policy_arn" {
  description = "The ARN of the Lambda deployment policy"
  value       = module.lambda_serverless.lambda_deployment_policy_arn
}
