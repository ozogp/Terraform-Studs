# Lab 01 — First Azure Resources

- **Duration:** 30 min · **Difficulty:** ⭐ · **Depends on:** Lab 00

## Scenario
Provision a parameterized resource group and a storage account, using variables,
locals, tags and an output. This config becomes the base for later labs.

## Learning goals
- Configure the AzureRM provider.
- Declare typed variables and supply values via env vars / `tfvars`.
- Use `locals` for a naming convention and merged tags.
- Run the full workflow and expose an output.

## Tasks

1. Open `starter/` and complete the `TODO`s in `variables.tf`, `main.tf`, `outputs.tf`.
2. Create a resource group named `rg-<prefix>-dev`.
3. Create a storage account whose name is derived (lowercase, no dashes, ≤24 chars).
4. Apply a merged tag map (default tags + `env = "dev"`).
5. Output the storage account's primary blob endpoint.

Run:
```bash
cd starter
terraform init
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

## Expected deliverables
- A resource group and storage account deployed in your sandbox.
- `terraform output` shows the blob endpoint.
- `terraform fmt` and `validate` are clean.

## Validation
```bash
terraform output storage_primary_blob_endpoint
az storage account show -g rg-tfcourse-ab-dev -n <name> -o table
```

## Difficulty stretch (optional)
- Add `validation` to the `prefix` variable (lowercase letters + digits only).
- Add a second `env` and reuse via `terraform workspace` or a `tfvars` file.

## Cleanup
```bash
terraform destroy
```

## Hints
- Storage account names: 3–24 chars, lowercase letters/numbers only.
  Use `replace(lower("st${var.prefix}dev"), "-", "")` and `substr(...)`.
- Solution is in `../solution/` — try first before peeking.
