# k8s_home_lab

## Overview

This project showcases a self-hosted Kubernetes cluster running in a home lab environment, aimed at developing hands-on DevOps skills. The cluster was manually provisioned using **Vagrant** and **VirtualBox**, with **kubeadm** used for Kubernetes bootstrapping. This lab simulates a production-like environment and includes service deployment, observability tools, ingress routing, and basic autoscaling capabilities.

---

## Lab Setup

### Infrastructure

- **Virtualization**: Managed using Vagrant and VirtualBox.
- **Nodes**: 
  - 1 Control Plane Node
  - 2 Worker Nodes
- **Vagrant Configuration**: The `Vagrantfile` provisions all three nodes, sets static IPs, and enables SSH access. Resources like CPU and memory are specified to simulate a realistic cluster setup.

### Kubernetes Installation

- **Tool**: kubeadm
- **Networking**: Calico (or mention your CNI if different)
- **DNS and Add-ons**: CoreDNS, Metrics Server, Local Path Provisioner

---

## Features Implemented

### Horizontal Pod Autoscaling

- Configured HPA for the `frontend` deployment.
- Autoscaling range: **min 2 pods**, **max 8 pods**
- Target CPU utilization is monitored via the **Metrics Server**.

### Observability

- **Metrics Server** deployed to collect resource usage metrics.
- Enabled **readiness/liveness probes** in deployments.

### Configuration Management

- Created **ConfigMaps** for both:
  - `frontend` deployment
  - `checkoutservice` deployment
- Environment variables are loaded from these ConfigMaps for cleaner configuration separation.

### Ingress Routing (Gateway API)

- Set up and configured **Gateway API** with **NGINX Gateway Controller**.
- Created `GatewayClass`, `Gateway`, and `HTTPRoute` resources to expose services externally via HTTP.

### Storage

- Used **local-path-provisioner** as the default `StorageClass`.
- Allows dynamic volume provisioning using hostPath, suitable for development and testing on local VMs.

---

## Future Improvements

- Integrate **CI/CD pipeline** using GitHub Actions or Jenkins.
- Add monitoring with **Prometheus and Grafana**.
- Include **Helm** for templating and more manageable deployments.
- Secure access with **RBAC**, **network policies**, and **TLS termination** at the ingress level.

---

## Why This Project?

This project is designed to mimic a real-world DevOps environment while remaining lightweight and resource-efficient. It demonstrates knowledge and experience in:

- Cluster setup and management
- Kubernetes core concepts
- Networking, routing, and service discovery
- Infrastructure automation and configuration
- Observability and autoscaling

---

## Requirements to Run Locally

- Vagrant
- VirtualBox
- 16 GB RAM recommended
- 4+ CPU cores

---

## Screenshots

*(Add relevant screenshots of your Grafana dashboard, HPA scaling, Gateway routing, or `kubectl get pods` output here)*

---

## Conclusion

This Kubernetes home lab is a foundational DevOps project that demonstrates both infrastructure and application-level experience in a cloud-native environment.

