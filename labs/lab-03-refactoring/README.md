# Lab 03 — Safe Refactoring (`import`, `moved`, `removed`)

- **Duration:** 30 min · **Difficulty:** ⭐⭐ · **Depends on:** Lab 01

## Scenario
A resource group was created manually (simulating pre-existing infrastructure).
You will bring it under Terraform management with `import`, then rename a
resource with `moved` — all without destroying anything.

## Tasks

### Part A — Import an existing resource group
1. Create the resource group outside Terraform:
   ```bash
   az group create -n rg-tfcourse-ab-legacy -l polandcentral
   ```
2. In `starter/`, add the resource block and an `import` block pointing at it
   (replace `<SUB_ID>`). See `solution/main.tf` if stuck.
3. Run:
   ```bash
   terraform init
   terraform plan      # expect: "1 to import, 0 to add, 0 to destroy"
   terraform apply
   ```

### Part B — Rename safely with `moved`
1. Rename the resource block from `legacy` to `platform_rg`.
2. Without a `moved` block, run `terraform plan` and **observe the destroy/create** it proposes.
3. Add a `moved` block and re-run `terraform plan` → expect **No changes**.

### Part C — (optional) `removed`
Add a `removed` block to drop a resource from state while keeping it in Azure;
confirm `plan` shows it leaving management with **0 to destroy**.

## Expected deliverables
- The legacy RG is managed by Terraform (visible in `state list`).
- A rename produced a **zero-change** plan (no `-/+` replace).

## Key teaching point
`import` / `moved` / `removed` change **state**, not Azure. Always confirm the
plan shows no replacement after a rename.

## Cleanup
```bash
terraform destroy
```
