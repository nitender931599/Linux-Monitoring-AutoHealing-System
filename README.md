# Linux Monitoring & Auto-Healing System

A production-inspired Linux infrastructure monitoring and auto-healing solution designed to proactively detect system issues, generate alerts, and automatically recover failed services.

This project simulates real-world Technical Operations, Linux Administration, and Site Reliability Engineering (SRE) workflows by integrating monitoring, alerting, incident logging, and automated remediation.

---

## Features

- Continuous Linux server health monitoring
- CPU, Memory, and Disk utilization checks
- Automatic service recovery (Auto-Healing)
- Incident logging and troubleshooting
- Containerized monitoring stack using Docker
- Infrastructure monitoring with Prometheus
- Production-style SOP and RCA documentation
- Support for future integration with Grafana and Microsoft Teams/Slack alerts

---

## Tech Stack

| Category | Technologies |
|----------|-------------|
| Operating System | Ubuntu Linux |
| Scripting | Bash Shell |
| Containerization | Docker, Docker Compose |
| Monitoring | Prometheus |
| Logging | Linux Logs |
| Documentation | Markdown |
| Version Control | Git, GitHub |

---

## Project Architecture

```text
+-----------------------------------------------------+
|                  Linux Server                       |
+-----------------------------------------------------+
|                                                     |
|  Bash Monitoring Script (monitor.sh)               |
|                                                     |
|      +------------------------------+               |
|      | Health Checks                |               |
|      |------------------------------|               |
|      | CPU Usage                    |               |
|      | Memory Usage                 |               |
|      | Disk Usage                   |               |
|      | Service Status               |               |
|      +------------------------------+               |
|                                                     |
|                  |                                  |
|                  v                                  |
|      Incident Detection                             |
|                  |                                  |
|                  v                                  |
|      Auto-Healing Engine                            |
|                  |                                  |
|                  v                                  |
|      Restart Failed Services                        |
|                                                     |
|                  |                                  |
|                  v                                  |
|      Incident Logs (incident.log)                  |
|                                                     |
+-----------------------------------------------------+

                |
                v

+----------------------------------+
| Prometheus Monitoring Stack      |
| Docker Compose                   |
+----------------------------------+
