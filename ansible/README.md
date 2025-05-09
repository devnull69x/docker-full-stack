# Alpine Linux Ansible Setup

## Overview

This Ansible project provisions and secures Alpine Linux servers with:

- Base system configuration (Asia/Singapore timezone)
- SSH hardening (custom port, fail2ban)
- Docker CE installation

## File Structure

```
F:/github/docker-full-stack/ansible/
├── inventories/          # Server inventories
├── roles/               # Modular components
├── playbooks/           # Top-level playbooks
├── group_vars/          # Global variables
├── files/               # Static files
├── ansible.cfg          # Ansible configuration
└── README.md            # This file
```

## Usage

### 1. First-time setup

```bash
ansible-playbook playbooks/provision.yml
```

### 2. Security hardening only

```bash
ansible-playbook playbooks/secure.yml
```

### 3. Targeting specific nodes

```bash
ansible-playbook playbooks/provision.yml --limit node1,node2
```

## Requirements

- Ansible 2.9+
- Python 3.6+
- SSH access to target servers

## Variables

Edit these files to customize:

- `group_vars/all.yml` - Global settings (timezone, packages)
- `inventories/production/group_vars/alpine_nodes.yml` - Cluster-specific vars
