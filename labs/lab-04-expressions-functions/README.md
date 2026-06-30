# Lab 04 Expressions, Functions & Dynamic Blocks

- **Duration:** 60 min
- **Difficulty:** 3/3
- **Depends on:** Lab 02

## Scenario
You are building a reusable network layer for a small workload. Instead of
copying subnet and network security group blocks, you will describe the network
as data and let Terraform expressions produce the final resources.

This lab is an optional replacement for the remote-state Lab 04 when you want
more practice with the Module 4 topics: expressions, functions, type
constraints, `terraform console`, `for_each`, `for` expressions and `dynamic`
blocks.

## Learning goals
- Use `terraform console` to test expressions before planning.
- Model nested input with `map(object(...))` and `optional(...)` attributes.
- Use string, collection and IP network functions in `locals`.
- Create subnets and NSGs from one input map with `for_each`.
- Generate repeated nested `security_rule` blocks with `dynamic`.
- Output useful maps such as subnet name to CIDR and subnet name to ID.

## What you will build
- One resource group.
- One virtual network.
- Multiple subnets calculated from one address space.
- One network security group per subnet.
- Optional security rules generated from input data.

## Part 1 - Explore expressions in the console

Run the console from the Terraform module directory so it can see `var.subnets`.

```bash
cd starter
terraform init -backend=false
terraform console
```

Try these expressions:

```hcl
lower("TfCourse-AB")
replace(lower("TfCourse-AB"), "-", "")
cidrsubnet("10.42.0.0/16", 8, 1)
merge({ course = "terraform-azure" }, { env = "dev" })
keys(var.subnets)
{ for k, v in var.subnets : k => cidrsubnet(var.address_space, v.newbits, v.index) }
```

Exit with:

```hcl
exit
```

## Part 2 - Complete the starter TODOs

Open `starter/` and complete the TODOs in this order:

1. In `main.tf`, build `local.name_prefix` with `lower`, `replace` and `substr`.
2. In `main.tf`, build `local.tags` with `merge` and `coalesce`.
3. In `main.tf`, build `local.subnet_configs` with a `for` expression, `merge`, `format` and `cidrsubnet`.
4. Confirm the subnet resource consumes `each.value.name`, `each.value.cidr` and `each.value.service_endpoints`.
5. Create NSGs with `for_each = local.subnet_configs`.
6. Generate nested NSG rules with a `dynamic "security_rule"` block.
7. Associate each subnet with the NSG that has the same map key.
8. Review the outputs that use `for` expressions to return useful maps.

## Part 3 - Validate and apply

```bash
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Inspect the result:

```bash
terraform output subnet_cidrs
terraform output subnet_ids
terraform state list
terraform state show 'azurerm_subnet.this["web"]'
```

## Expected deliverables
- A plan showing one VNet, multiple subnets, NSGs and associations.
- `terraform output subnet_cidrs` returns a `name => cidr` map.
- `terraform output subnet_ids` returns a `name => id` map after apply.
- A short note with two console expressions you tested.

## Key teaching points

| Concept | Where it appears |
|---|---|
| Type constraints | `variables.tf` uses `map(object(...))` |
| Validation | `prefix`, `environment`, `address_space`, `subnets` |
| String functions | `lower`, `replace`, `substr`, `format`, `trimspace` |
| Collection functions | `merge`, `keys`, `values`, `alltrue` |
| IP network functions | `cidrsubnet`, `cidrnetmask` |
| `for` expression | `local.subnet_configs`, output maps |
| `for_each` | subnets, NSGs and associations |
| `dynamic` block | repeated NSG `security_rule` blocks |

## Stretch tasks
- Add a new `api` subnet by editing only `var.subnets`.
- Add one more NSG rule to the `web` subnet.
- Change `address_space` and predict the subnet CIDRs in `terraform console`.
- Add a `validation` rule that rejects duplicate subnet indexes.

## Cleanup

```bash
terraform destroy
```

> Solution is in `../solution/`.