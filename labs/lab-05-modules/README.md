# Lab 05 — Author & Compose a Module

- **Duration:** 45 min · **Difficulty:** ⭐⭐ · **Depends on:** Lab 02, Lab 04

## Scenario
Encapsulate networking into a reusable local module with a clean input/output
contract, then consume it **twice** (dev and test) via composition. This module
mirrors what an AVM Resource module does — you'll replace it with AVM in Lab 7.

## Structure
```
lab-05-modules/
├─ modules/network/      # the reusable child module
│  ├─ variables.tf
│  ├─ main.tf
│  └─ outputs.tf
└─ solution/             # root module consuming it twice
   └─ main.tf
```

## Tasks
1. Review the `modules/network` module contract (inputs/outputs). Note how
   internals (resource names, `for_each`) are hidden behind a small interface.
2. In `solution/main.tf`, instantiate the module twice with different prefixes
   and address spaces (dev + test).
3. Run:
   ```bash
   cd solution
   terraform init     # registers the local module
   terraform plan
   terraform apply
   ```
4. Inspect the composed outputs:
   ```bash
   terraform output
   ```

## Expected deliverables
- A working `network` module reused by two `module` blocks.
- Outputs from each instance surfaced at the root.

## Discussion
- What belongs in the module **interface** vs. hidden internals?
- Why composition (wiring modules) over inheritance?

## Bridge to AVM (Lab 7)
Keep this module — in Lab 7 you'll swap it for `Azure/avm-res-network-virtualnetwork/azurerm`
and compare effort and built-in security defaults.

## Cleanup
```bash
terraform destroy
```
