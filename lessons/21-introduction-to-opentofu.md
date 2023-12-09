---
title: Introduction to OpenTofu
---

## Agenda

- What is OpenTofu?
- IaC Phases
- HashiCorp Configuration Language
- OpenTofu Blocks
- Workflow
- Example

---

## What is OpenTofu?

- Infrastructure as Code Tool
- Open Source
- Fork of Terraform with different License
- Interacts with APIs of Providers
- Uses HCL to declaratively define Infrastructure

---

## IaC Phases

- Infrastructure Set Up
- Infrastructure Maintenance
- Application Set Up

---

## HashiCorp Configuration Language

- Structured Configuration Language
- Interface between Human and Computer
- Targeted for DevOps Tools
- Includes minimal Programming Features

---

## General Syntax

```
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  <IDENTIFIER> = <EXPRESSION>
}
```

---

## OpenTofu Blocks

---

## Terraform Block

```hcl
terraform {
    backend {}
    required_providers = {}
    required_version = ""
}
```

---

## Provider Block

```hcl
provider "example_provider" {}
```

---

## Data Block

```hcl
data "example_data_source" "example" {}
```

---

## Resource Block

```hcl
resource "example_resource" "example" {}
```

---

## Module Block

```hcl
module "example-module" {
    source = "./example"
}
```

---

## Variable Block

```hcl
variable "example_variable" {
    type = string
    default = "example"
    description = "Example"
}
```

---

## Output Block

```hcl
output "example_output" {
    value = "${example_resource.example.name}"
}
```

---

## Locals Block

```hcl
locals {
    example = "example"
}
```

---

## Workflow

- Write
- Plan
- Apply

---

## State

- Information about Infrastructure and Configuration
- Real World vs Configuration
- Metadata
- Contains Sensitive Values
- Shared amongst Team

---

## Example

```hcl
resource "cloudflare_zone" "zhews_dev_zone" {
  account_id = var.cloudflare_account_id
  zone       = "zhews.dev"
}

resource "cloudflare_record" "proton_owner_verification" {
  zone_id = cloudflare_zone.zhews_dev_zone.id
  type    = "TXT"
  name    = "@"
  value   = "protonmail-verification=554d"
}
```
