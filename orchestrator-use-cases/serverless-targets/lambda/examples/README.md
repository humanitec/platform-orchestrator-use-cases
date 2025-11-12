# Lambda Serverless Target Module - Example

This example demonstrates how to use the lambda-serverless-target module to set up Lambda deployment capabilities with Platform Orchestrator.

## What This Example Does

This example creates:

1. A Platform Orchestrator project for Lambda deployments
2. A development environment
3. An ECS-based serverless runner
4. IAM policies for Lambda function management
5. Resource types and modules for Lambda deployment
6. Integration with S3 for deployment packages

## Prerequisites

Before running this example, ensure you have:

- AWS credentials configured
- Platform Orchestrator credentials configured
- An S3 bucket for Lambda deployment packages

## Usage

1. Update the values in [main.tf](main.tf) to match your environment:
   - Replace `your-org-id` with your Platform Orchestrator organization ID
   - Update the ECS cluster name
   - Update subnet IDs and security group IDs
   - Update the OIDC configuration
   - Update the S3 bucket name
   - Update the Lambda module source repository

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. Review the planned changes:

   ```bash
   terraform plan
   ```

4. Apply the configuration:

   ```bash
   terraform apply
   ```

## Cleanup

To destroy all resources created by this example:

```bash
terraform destroy
```

## Next Steps

After applying this configuration, you can deploy Lambda functions through Platform Orchestrator using the configured resource types and modules.
