# Lambda Serverless Target Module

This Terraform module configures Platform Orchestrator to deploy AWS Lambda functions using an ECS-based serverless runner.

## Overview

This module sets up the complete infrastructure needed to deploy Lambda functions through Platform Orchestrator, including:

- Platform Orchestrator project and environment
- ECS serverless runner for Lambda deployments
- IAM policies and roles for Lambda function management
- Resource types and modules for Lambda deployment
- S3 integration for Lambda deployment packages

## Features

- **Automated ECS Runner Setup**: Configures a serverless ECS runner for executing Lambda deployments
- **IAM Policy Management**: Creates necessary IAM policies for Lambda function lifecycle management
- **S3 Integration**: Supports Lambda deployment packages stored in S3
- **Function URL Support**: Optional Lambda function URL configuration
- **CloudWatch Logging**: Automatic setup for Lambda function logging
- **Customizable Runtime**: Configurable Lambda runtime and handler settings

## Prerequisites

- AWS account with appropriate permissions
- S3 bucket for Lambda deployment packages
- Platform Orchestrator organization and API access

## Usage

```hcl
module "lambda_serverless_target" {
  source = "./modules/lambda-serverless-target"

  # Platform Orchestrator Configuration
  org_id               = "your-org-id"
  project_id_prefix    = "lambda-project"
  env_id               = "dev"
  env_type_id_prefix   = "development"

  # AWS Configuration
  aws_region = "eu-central-1"

  # ECS Runner Configuration
  ecs_runner_cluster_name       = "your-ecs-cluster"
  ecs_runner_subnet_ids         = ["subnet-xxxxx"]
  ecs_runner_security_group_ids = ["sg-xxxxx"]
  ecs_runner_prefix             = "lambda-runner"

  # OIDC Configuration
  oidc_hostname              = "your-oidc.hostname.dev"
  existing_oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/your-oidc.hostname.dev"

  # Lambda Configuration
  lambda_package_s3_bucket = "your-lambda-packages-bucket"
  lambda_timeout           = 100

  # Optional: Additional tags
  additional_tags = {
    Environment = "Development"
    Team        = "Platform"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8.0 |
| aws | >= 4.0 |
| random | >= 3.0 |
| platform-orchestrator | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |
| platform-orchestrator | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| org_id | The Platform Orchestrator organization ID | `string` | n/a | yes |
| project_id_prefix | The Platform Orchestrator project ID prefix | `string` | n/a | yes |
| env_id | The environment ID within the project | `string` | n/a | yes |
| ecs_runner_cluster_name | Name of the existing ECS cluster for the runner | `string` | n/a | yes |
| ecs_runner_subnet_ids | List of subnet IDs for the ECS runner | `list(string)` | n/a | yes |
| ecs_runner_security_group_ids | List of security group IDs for the ECS runner | `list(string)` | n/a | yes |
| oidc_hostname | OIDC hostname for authentication | `string` | n/a | yes |
| existing_oidc_provider_arn | ARN of the existing OIDC provider | `string` | n/a | yes |
| lambda_package_s3_bucket | S3 bucket name for Lambda deployment packages | `string` | n/a | yes |
| env_type_id_prefix | The environment type ID prefix | `string` | `"development"` | no |
| aws_region | AWS region where resources will be deployed | `string` | `"eu-central-1"` | no |
| ecs_runner_prefix | Prefix for the ECS runner resources | `string` | `"ecs-runner"` | no |
| ecs_runner_id | The ID of the ECS runner. If not provided, one will be generated using ecs_runner_prefix | `string` | `null` | no |
| ecs_runner_environment | Plain text environment variables to expose in the ECS runner | `map(string)` | `{}` | no |
| ecs_runner_secrets | Secret environment variables to expose in the ECS runner. Each value should be a secret or property ARN | `map(string)` | `{}` | no |
| ecs_runner_force_delete_s3 | Force delete the ECS runner S3 state files bucket on destroy even if it's not empty | `bool` | `false` | no |
| lambda_timeout | Default timeout for Lambda functions in seconds | `number` | `100` | no |
| lambda_module_id_prefix | Prefix for the Lambda module and resource type IDs | `string` | `"lambda-zip"` | no |
| lambda_name_prefix | Prefix for Lambda function names (supports context variables) | `string` | `"$${context.project_id}"` | no |
| lambda_additional_inline_policies | Map of additional inline IAM policies for Lambda execution role | `map(string)` | `{}` | no |
| lambda_runtime | Lambda runtime environment | `string` | `"provided.al2023"` | no |
| lambda_handler | Lambda function handler | `string` | `"bootstrap"` | no |
| lambda_memory_size | Amount of memory in MB for Lambda function (128-10240) | `number` | `128` | no |
| lambda_architectures | Instruction set architecture for Lambda function | `list(string)` | `["x86_64"]` | no |
| lambda_iam_role_arn | Optional IAM role ARN for Lambda function | `string` | `null` | no |
| lambda_iam_role_prefix | Prefix for Lambda execution IAM role names when created by module | `string` | `"lambda-role"` | no |
| lambda_additional_managed_policy_arns | Additional managed IAM policy ARNs for Lambda execution role | `list(string)` | `[]` | no |
| lambda_additional_tags | Additional tags to apply to Lambda function | `map(string)` | `{}` | no |
| lambda_enable_function_url | Enable Lambda function URL | `bool` | `false` | no |
| lambda_function_url_auth_type | Authorization type for Function URL ('NONE' or 'AWS_IAM') | `string` | `"AWS_IAM"` | no |
| lambda_function_url_cors | CORS configuration for Function URL | `object` | `null` | no |
| additional_tags | Additional tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| project_id | The ID of the Platform Orchestrator project |
| environment_id | The ID of the Platform Orchestrator environment |
| ecs_runner_id | The ID of the ECS runner |
| ecs_runner_task_role_name | The name of the ECS runner task role |
| ecs_runner_task_role_arn | The ARN of the ECS runner task role |
| lambda_deployment_policy_arn | The ARN of the IAM policy for Lambda deployment |
| lambda_deployment_policy_name | The name of the IAM policy for Lambda deployment |
| lambda_zip_resource_type_id | The ID of the lambda-zip resource type |
| lambda_zip_module_id | The ID of the lambda-zip module |

## Resources Created

This module creates the following resources:

- **Platform Orchestrator Resources**:
  - Project
  - Environment
  - Runner rule
  - Resource type (lambda-zip)
  - Module configuration
  - Module rule

- **AWS Resources**:
  - IAM policy for Lambda deployment
  - IAM role policy attachment

- **External Modules**:
  - ECS serverless runner (from platform-orchestrator-tf-modules)

## IAM Permissions

The module creates an IAM policy that grants the ECS runner the following permissions:

- Lambda function lifecycle management (create, update, delete)
- Lambda function URL configuration
- IAM role and policy management for Lambda execution roles
- S3 access for deployment packages
- CloudWatch Logs access for Lambda logging

## Security Considerations

- When the module creates IAM roles (`lambda_iam_role_arn` is null), the ECS runner is granted permissions to manage roles matching the `lambda_iam_role_prefix` pattern (default: `lambda-role*`)
- When using a custom IAM role (`lambda_iam_role_arn` is provided), no IAM role/policy management permissions are granted to the ECS runner
- S3 bucket access is limited to the specified deployment package bucket
- Lambda functions have inline policies for accessing project-specific S3 buckets
- All resources are tagged for tracking and governance

## License

This module is part of the Platform Orchestrator use cases repository.

## References

- [Platform Orchestrator Documentation](https://developer.humanitec.com)
- [Platform Orchestrator Terraform Modules](https://github.com/humanitec/platform-orchestrator-tf-modules)
