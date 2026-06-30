# Lab 00 — Environment Verification

- **Duration:** 15 min · **Difficulty:** ⭐ · **Depends on:** none

## Scenario
Before any Terraform content, confirm your machine and Azure access are ready.

## Tasks

1. **Verify tools**
   ```bash
   terraform version      # expect >= 1.7
   az version
   git --version
   tfsec --version        # or: checkov --version
   ```

2. **Sign in to Azure**
   ```bash
   az login
   az account set --subscription "<subscription-id>"
   az account show -o table
   ```

3. **Set per-student variables** (PowerShell)
   ```powershell
   $env:TF_VAR_prefix   = "tfcourse-ab"   # use YOUR initials
   $env:TF_VAR_location = "polandcentral"
   $env:TF_VAR_owner    = "ab@example.com"
   ```

4. **Smoke-test Terraform + Azure** in an empty folder:
   ```hcl
   # main.tf
   terraform {
   required_providers {
      azurerm = {
         source  = "hashicorp/azurerm",
         version = "~> 4.0"
      }
   }
   }
   provider "azurerm" {
   features {}
   }

   data "azurerm_subscription" "current" {}

   output "subscription_name" {
   value = data.azurerm_subscription.current.display_name
   }   
   ```
   Write in console, then run:   
   ```bash
   terraform init
   terraform plan -out=tfplan   # reads only; creates nothing
   terraform apply -auto-approve tfplan   # reads only; creates nothing
   ```

## Expected deliverables
- `terraform version` ≥ 1.7 and `az account show` point to the **sandbox** subscription.
- `terraform apply` prints your subscription name as an output.

## Definition of done
You can authenticate to Azure and run the Terraform workflow with no errors.

## Cleanup
```bash
terraform destroy -auto-approve tfplan   # nothing real was created; clears state
```
