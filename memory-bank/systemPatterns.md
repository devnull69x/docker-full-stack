# System Patterns

This file documents recurring patterns and standards used in the project.
2025-05-13 09:34:45 - Log of updates made.

## Architectural Patterns

- **Service Discovery Pattern**

  - All services register with Traefik automatically
  - Uses Docker labels for configuration
  - Example: See 01.2-traefik.yml

- **High Availability Pattern**
  - Redis cluster with 3 nodes
  - XtraDB cluster configuration
  - GlusterFS for shared storage

## Security Patterns

- **Defense in Depth**

  - CrowdSec for intrusion prevention
  - Authelia for authentication
  - Network segmentation between services

- **Immutable Infrastructure**
  - All services run in containers
  - Configuration through compose files
- **Reverse Proxy Pattern**

  - Traefik as edge router with Docker provider
  - Middleware chains for security (authelia + default)
  - TLS 1.3 with modern cipher suites
  - Sticky sessions with secure cookies
  - Centralized logging configuration

- **Container Networking Pattern**
  - External internet access via proxy network
  - Isolated internal networks per service group
  - Local-persist driver for volume management
  - Update policies with health checks

2025-05-13 09:35:12 - Added reverse proxy and container networking patterns

- No direct host modifications
