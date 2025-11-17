#!/bin/bash
# This script iterates through all directories of the repository to execute Terraform actions.
# It does so in any directory having a "main.tf" file.
# Actions are terraform init, fmt, validate, and test

set -e

# Find all directories containing main.tf
echo "Searching for directories with main.tf files..."

while IFS= read -r -d '' main_tf_file; do
  dir=$(dirname "$main_tf_file")
  echo ""
  echo "=========================================="
  echo "Processing directory: $dir"
  echo "=========================================="
  
  cd "$GITHUB_WORKSPACE/$dir"
  
  echo "Initializing terraform in $dir..."
  terraform init -backend=false
  echo "Formatting ..."
  terraform fmt --check --recursive
  echo "Validating ..."
  terraform validate
  echo "Running tests ..."
  terraform test
  
  if [ "$DO_TF_DOCS" == "true" ]; then
    echo "Running terraform-docs ..."
    $GITHUB_WORKSPACE/terraform-docs markdown table --output-file README.md --output-mode inject .
  fi

  # Return to workspace root
  cd "$GITHUB_WORKSPACE"
  
done < <(find . -name "main.tf" -type f -print0)