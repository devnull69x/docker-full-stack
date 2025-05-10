# Alpine Linux Hardening Automation

```text
███████╗██╗░░░██╗██╗░░██╗██████╗░███████╗██████╗░██████╗░██╗░░░██╗███╗░░██╗██║░░██╗███████╗██████╗░
██╔════╝██║░░░██║██║░░██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██║░░░██║████╗░██║██║░░██║██╔════╝██╔══██╗
█████╗░░██║░░░██║███████║██████╔╝█████╗░░██████╔╝██████╔╝██║░░░██║██╔██╗██║███████║█████╗░░██████╔╝
██╔══╝░░██║░░░██║██╔══██║██╔══██╗██╔══╝░░██╔══██╗██╔══██╗██║░░░██║██║╚████║██╔══██║██╔══╝░░██╔══██╗
██║░░░░░╚██████╔╝██║░░██║██║░░██║███████╗██║░░██║██║░░██║╚██████╔╝██║░╚███║██║░░██║███████╗██║░░██║
╚═╝░░░░░░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝░╚═════╝░╚═╝░░╚══╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝
```

**Enterprise-Grade Security Hardening**  
_Aligned with CIS, NIST 800-53, DISA STIG, Singapore IM8, MAS TRM, and CSA Cyber Essentials_

## Table of Contents

- [Alpine Linux Hardening Automation](#alpine-linux-hardening-automation)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Prerequisites](#prerequisites)
  - [File Structure](#file-structure)
  - [Quick Start](#quick-start)
  - [Core Operations](#core-operations)
    - [Docker Host Hardening (NEW)](#docker-host-hardening-new)
    - [Full Hardening](#full-hardening)
    - [Targeted Hardening](#targeted-hardening)
  - [Compliance Operations](#compliance-operations)
    - [Multi-Standard Validation](#multi-standard-validation)
    - [Manual Compliance Checks](#manual-compliance-checks)
  - [Command Reference](#command-reference)
    - [Core Hardening Workflows](#core-hardening-workflows)
    - [Component-Specific Execution](#component-specific-execution)
    - [Tag Reference](#tag-reference)
    - [Utility Commands](#utility-commands)
  - [Module Reference](#module-reference)
  - [Customization](#customization)
    - [Compliance Profile Selection](#compliance-profile-selection)
    - [Template Overrides](#template-overrides)
  - [Testing \& Quality Assurance](#testing--quality-assurance)
    - [Linting](#linting)
    - [Integration Tests](#integration-tests)
  - [Compliance Mapping Reference](#compliance-mapping-reference)
    - [Framework Coverage](#framework-coverage)
    - [Control Density by Task](#control-density-by-task)
    - [Mapping Details](#mapping-details)
  - [Troubleshooting](#troubleshooting)
    - [Recovery Commands](#recovery-commands)
    - [Debugging](#debugging)
  - [Resources](#resources)

## Overview

This project provides automated security hardening for Alpine Linux environments, with comprehensive compliance mappings to major security frameworks including CIS, NIST 800-53, DISA STIG, Singapore IM8, MAS TRM, and CSA Cyber Essentials.

**New in v2.0**:  
Integrated Docker Host Security with CIS Benchmark compliance, plus expanded support for Singapore IM8 and MAS TRM requirements. The compliance framework now cross-references controls across 6 major standards with automated validation.

## Prerequisites

- Ansible Core ≥ 2.12
- Alpine Linux ≥ 3.18
- Python 3.8+
- SSH root/sudo access
- Docker CE ≥ 24.0 (for Docker hardening)
- jq 1.6+ (for compliance validation)

## File Structure

```plaintext
alpine-hardening/
├── .ansible-lint                  # Linting config
├── ansible.cfg                    # Ansible settings
├── inventory/                     # Environment inventories
├── compliance/                    # Compliance mappings
├── defaults/                      # Default variables
├── vars/                          # Environment vars
├── tasks/                         # Hardening modules
├── templates/                     # Configuration templates
├── handlers/                      # Service handlers
├── meta/                          # Role metadata
└── tests/                         # Test cases
```

## Quick Start

```bash
# Clone & Initialize
git clone https://github.com/your-org/alpine-hardening.git
cd alpine-hardening
ansible-galaxy install -r requirements.yml
```

## Core Operations

### Docker Host Hardening (NEW)

```bash
# Docker Host Hardening (CIS Docker Benchmark)
ansible-playbook site.yml -i inventory/production/hosts.yml \
 -e "docker_required=true cis_docker_profile=hardened"

# Docker Configuration Rollback
ansible-playbook tasks/docker/rollback.yml -e "docker_clean_state=true"
```

### Full Hardening

```bash
# Production (CIS L2 + IM8)
ansible-playbook site.yml -i inventory/production/hosts.yml

# Development (CSA Essentials)
ansible-playbook site.yml -i inventory/staging/hosts.yml -e "profile=development"
```

### Targeted Hardening

```bash
# Kernel Hardening Only
ansible-playbook tasks/03_kernel_hardening.yml

# SG IM8 Compliance
ansible-playbook site.yml --tags "im8"
```

## Compliance Operations

### Multi-Standard Validation

````bash
# Validate against all standards simultaneously
ansible-playbook site.yml --tags "compliance_matrix" \
  -e "cis_profile=hardened im8_profile=enhanced nist_profile=moderate"

| Standard      | Version | Controls Mapped | Coverage | Activation Flag          |
| ------------- | ------- | --------------- | -------- | ------------------------ |
| CIS Docker    | v1.4.0  | 68/68           | 100%     | `docker_required: true`  |
| CSA CyberEss  | v3.0    | 42/42           | 100%     | `csa_compliance: true`   |
```

### Framework Validation

| Command                                                                   | Purpose                  | Output | Example               |
| ------------------------------------------------------------------------- | ------------------------ | ------ | --------------------- |
| `ansible-playbook site.yml --tags "compliance_check" -e "framework=cis"`  | CIS Benchmark validation | JSON   | `-e "framework=cis"`  |
| `ansible-playbook site.yml --tags "compliance_check" -e "framework=im8"`  | Singapore IM8 validation | JSON   | `-e "framework=im8"`  |
| `ansible-playbook site.yml --tags "compliance_check" -e "framework=stig"` | DISA STIG validation     | JSON   | `-e "framework=stig"` |

### Report Generation

| Command                                                                 | Format                | Output Location                    |
| ----------------------------------------------------------------------- | --------------------- | ---------------------------------- |
| `ansible-playbook site.yml --tags "compliance_report" -e "format=html"` | Interactive HTML      | `./reports/compliance-{date}.html` |
| `ansible-playbook site.yml --tags "compliance_report" -e "format=pdf"`  | Printable PDF         | `./reports/compliance-{date}.pdf`  |
| `ansible-playbook site.yml --tags "compliance_report" -e "format=json"` | Machine-readable JSON | `./reports/compliance-{date}.json` |

```bash
# CIS Validation
ansible-playbook site.yml --tags "compliance_check" -e "framework=cis"

# Generate HTML Report
ansible-playbook site.yml --tags "compliance_report" -e "format=html"
````

### Manual Compliance Checks

```bash
# Count implemented CIS controls
grep -r "CIS" compliance/ | wc -l

# Verify STIG mappings
ansible-inventory -i inventory/production/hosts.yml --list | jq '.all.vars.stig'

# Check IM8 coverage
ansible-playbook site.yml --tags "compliance_check" -e "framework=im8" | jq '.stats.coverage'
```

## Command Reference

### Core Hardening Workflows

| Command                                                  | Purpose            | Standards     | Example                                                       |
| -------------------------------------------------------- | ------------------ | ------------- | ------------------------------------------------------------- |
| `ansible-playbook site.yml -i inventory/<env>/hosts.yml` | Full hardening     | CIS+IM8+STIG  | `ansible-playbook site.yml -i inventory/production/hosts.yml` |
| `ansible-playbook site.yml --tags "<tag>"`               | Targeted hardening | Varies by tag | `ansible-playbook site.yml --tags "kernel,network"`           |
| `ansible-playbook site.yml --skip-tags "<tag>"`          | Exclude components | N/A           | `ansible-playbook site.yml --skip-tags "crypto"`              |

### Component-Specific Execution

| Module          | Command                                          | Key Controls    | Time Estimate |
| --------------- | ------------------------------------------------ | --------------- | ------------- |
| Preflight       | `ansible-playbook tasks/01_preflight.yml`        | IM8 4.3.1       | 1-2 min       |
| Minimal Install | `ansible-playbook tasks/02_minimal_install.yml`  | CIS 1.1.1-1.2.3 | 3-5 min       |
| Kernel          | `ansible-playbook tasks/03_kernel_hardening.yml` | NIST SC-7       | 2-3 min       |
| Filesystem      | `ansible-playbook tasks/04_filesystem.yml`       | STIG V-204456   | 4-6 min       |
| Authentication  | `ansible-playbook tasks/05_user_auth.yml`        | MAS TRM 6.1.2   | 3-5 min       |
| Services        | `ansible-playbook tasks/06_services.yml`         | CSA CE 3.2.1    | 5-7 min       |
| Logging         | `ansible-playbook tasks/07_logging.yml`          | NIST AU-3       | 2-4 min       |
| Network         | `ansible-playbook tasks/08_network.yml`          | CIS 3.1.1-3.3.8 | 4-6 min       |
| Crypto          | `ansible-playbook tasks/09_crypto.yml`           | FIPS 140-2      | 3-5 min       |

### Tag Reference

| Tag          | Maps To                 | Description              |
| ------------ | ----------------------- | ------------------------ |
| `preflight`  | 01_preflight.yml        | System validation checks |
| `minimal`    | 02_minimal_install.yml  | Package minimization     |
| `kernel`     | 03_kernel_hardening.yml | Kernel parameters        |
| `filesystem` | 04_filesystem.yml       | Secure mounts            |
| `auth`       | 05_user_auth.yml        | PAM/MFA configuration    |
| `services`   | 06_services.yml         | SSH/cron hardening       |
| `logging`    | 07_logging.yml          | Auditd configuration     |
| `network`    | 08_network.yml          | Network stack hardening  |
| `crypto`     | 09_crypto.yml           | TLS/SSH cryptography     |

### Utility Commands

```bash
# Run all hardening modules sequentially
ansible-playbook site.yml --tags "preflight,minimal,kernel,filesystem,auth,services,logging,network,crypto"

# Dry run (check mode)
ansible-playbook site.yml --check --diff

# Start from specific task
ansible-playbook site.yml --start-at-task "05_user_auth"

# Generate compliance report
ansible-playbook site.yml --tags "compliance_report" -e "report_format=html"
```

## Module Reference

| Task File                 | Purpose              | Key Controls  |
| ------------------------- | -------------------- | ------------- |
| `01_preflight.yml`        | System Validation    | IM8 4.3.1     |
| `02_minimal_install.yml`  | Package Minimization | CIS 1.1       |
| `03_kernel_hardening.yml` | Kernel Parameters    | NIST SC-7     |
| `04_filesystem.yml`       | Secure Mounts        | STIG V-204456 |
| `05_user_auth.yml`        | PAM/MFA              | MAS TRM 6.1.2 |
| `06_services.yml`         | Service Hardening    | CSA CE 3.2    |
| `07_logging.yml`          | Audit Configuration  | NIST AU-3     |
| `08_network.yml`          | Network Hardening    | CIS 3.1.1     |
| `09_crypto.yml`           | Cryptography         | FIPS 140-2    |

## Customization

### Compliance Profile Selection

````yaml
# inventory/group_vars/alpine_servers.yml
compliance_profiles:
  base: "cis-hardened"
  regional:
    - "im8-enhanced"
    - "mas-trm-2023"
  optional:
    - "nist-moderate"
    - "docker-cis"

### Security Profiles

```yaml
# vars/production.yml
security_level: high
enable_fips: true
audit_profile: full
````

### Template Overrides

```bash
ansible-playbook site.yml -e "sshd_template=custom/ssh_config.j2"
```

## Testing & Quality Assurance

### Linting

```bash
ansible-lint site.yml --profile=production
yamllint .
```

### Integration Tests

```bash
cd tests/
molecule test -s alpine-lts
pytest -v
```

## Compliance Mapping Reference

### Framework Coverage

| Standard      | Version | Controls Mapped | Coverage | Mapped Tasks            |
| ------------- | ------- | --------------- | -------- | ----------------------- |
| CIS Benchmark | v1.0    | 192/192         | 100%     | All (01-09)             |
| Singapore IM8 | 2023    | 85/89           | 95%      | 02,05,07,09             |
| DISA STIG     | V4R1    | 134/145         | 92%      | 03,04,06,08             |
| MAS TRM       | 2023    | 47/52           | 90%      | 05,07,09                |
| NIST 800-53   | Rev5    | 112/128         | 87%      | 03,05,07,08             |
| CIS Docker    | v1.4.0  | 68/68           | 100%     | `docker_required: true` |
| CSA CyberEss  | v3.0    | 42/42           | 100%     | `csa_compliance: true`  |

### Control Density by Task

| Task File               | CIS | IM8 | STIG | MAS TRM | NIST |
| ----------------------- | --- | --- | ---- | ------- | ---- |
| 01_preflight.yml        | 6   | 2   | 3    | 1       | 4    |
| 02_minimal_install.yml  | 18  | 5   | 9    | 3       | 7    |
| 03_kernel_hardening.yml | 22  | 7   | 15   | 5       | 12   |
| 04_filesystem.yml       | 16  | 4   | 14   | 2       | 8    |
| 05_user_auth.yml        | 24  | 12  | 11   | 9       | 15   |
| 06_services.yml         | 28  | 8   | 19   | 6       | 11   |
| 07_logging.yml          | 20  | 10  | 13   | 7       | 14   |
| 08_network.yml          | 32  | 9   | 21   | 8       | 18   |
| 09_crypto.yml           | 26  | 11  | 19   | 6       | 13   |

### Mapping Details

```yaml
# Example: CIS 1.1.1 mapping in compliance/cis.yml
cis_1.1.1:
  title: "Filesystem Configuration"
  tasks:
    - 02_minimal_install.yml
    - 04_filesystem.yml
  implementation: "auto"
  severity: "high"
```

## Troubleshooting

### Recovery Commands

```bash
# SSH Recovery
ansible-playbook tasks/recover_ssh.yml

# Rollback Kernel Changes
ansible-playbook site.yml --tags "rollback" -e "component=kernel"
```

### Debugging

```bash
ANSIBLE_LOG_PATH=./debug.log ansible-playbook site.yml -vvv
```

## Resources

- [CIS Alpine Benchmark](https://www.cisecurity.org)
- [Singapore IM8 Guidelines](https://www.csa.gov.sg)
- [NIST SP 800-53](https://csrc.nist.gov/projects/risk-management/sp800-53-controls) - [CIS Docker Benchmark](https://www.cisecurity.org/benchmark/docker)
- [MAS TRM Guidelines](https://www.mas.gov.sg)
- [IM8 Technical Guide](https://www.csa.gov.sg/im8)

> **Note**: Always test in staging before production deployment.  
> Maintain idempotence with `--check` before full runs.
