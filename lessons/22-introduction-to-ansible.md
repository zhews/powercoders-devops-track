---
title: Introduction to Ansible
---

## Agenda

- What is Ansible?
- IaC Phases
- Ansible Concepts

---

## What is Ansible?

- Infrastructure as Code Tools
- Open Source
- Owned by RedHat
- Usually connects with SSH
- Uses YAML to procedurally and declaratively define Infrastructure

---

## IaC Phases

- Infrastructure Maintenance
- Application Set Up
- Application Maintenance

---

## Ansible Concepts

---

## Control Node

- Device of Executor
- Contains the IaC
- Interacts via the CLI

---

## Managed Node

- Target Devices
- Managed through Ansible
- Do not contain any Ansible related Tools

---

## Inventory

- List of Managed Nodes
- Contains Information
  - How to Connect
  - Variables
  - ...
- Groups of Nodes

---

## Inventory Example

```yaml
app:
  hosts:
    app1.example.com: {}
    app2.example.com: {}

db:
  hosts:
    db1.example.com: {}
    db2.example.com: {}

data-center:
  children:
    app: {}
    db: {}
```

---

## Playbook

- Repeatable, Reusable and Simple Config Management
- Defines Plays (execution of tasks)
- Top to Bottom

---

## Playbook Example

```yaml
- name: Update App Servers
  hosts: app
  roles: [common]
  tasks:
    - name: Ensure Go is at the latest version
      ansible.builtin.dnf:
        name: golang
        state: latest
      notify:
        - Inform about update
  handlers:
    - name: Inform about update
      ansible.builtin.debug:
        msg: Updated Go to the latest version
```

---

## Modules

- Binaries to execute a Task
- Specific Use Case = one Module
- Part of Collections

---

## Plugins

- Extend Ansible
  - Connection Method
  - Data Manipulation
  - Prettier Console Output
  - ...

---

## Collections

- Format to Distribute Ansible Components
- Installed through Ansible Galaxy
- Can be used independently
