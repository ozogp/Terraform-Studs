# Lab 02 — Expressions, Functions & `for_each`

- **Duration:** 30 min · **Difficulty:** ⭐⭐ · **Depends on:** Lab 01

## Scenario
Drive multiple Azure resources from a single map using `for_each`, and compute
values with built-in functions. You will build a virtual network with several
subnets defined in one variable.

## Learning goals
- Use `for_each` over a map to create many resources from one block.
- Compute subnet CIDRs with `cidrsubnet`.
- Merge tags with `merge`; explore values in `terraform console`.

## Tasks

1. Complete `starter/` so that:
   - a VNet uses `var.address_space`,
   - subnets are created from `var.subnets` (a `map(object)`),
   - each subnet output is a map `name => id`.
2. Use the console from the Terraform module directory to verify your expressions **before** applying:
   ```bash
   cd starter
   terraform init
   terraform console
   > cidrsubnet("10.40.0.0/16", 8, 1)
   > { for k, v in var.subnets : k => v.cidr }
   > exit
   ```

   `terraform console` only sees variables declared in the current Terraform configuration. If you run it from `slides/day1`, `var.subnets` is not declared there.
3. From the same `starter/` directory, apply and inspect state:
   ```bash
   terraform apply
   terraform state list
   terraform state show 'azurerm_subnet.this["web"]'
   ```

## Expected deliverables
- One VNet + 2–3 subnets created from a single `for_each` block.
- Output map of subnet name → ID.
- A short note of two console expressions you tested.

## Why `for_each` (not `count`)
With a map, each instance has a **stable key** (`["web"]`). Reordering the list
with `count` would churn resources; `for_each` keeps identity stable.

## Cleanup
```bash
terraform destroy
```

> Solution in `../solution/`.
