# k8s_home_lab

## Overview

This project showcases a self-hosted Kubernetes cluster running in a home lab environment, aimed at developing hands-on DevOps skills. The cluster was manually provisioned using **Vagrant** and **VirtualBox**, with **kubeadm** used for Kubernetes bootstrapping. This lab simulates a production-like environment and includes service deployment, observability tools, ingress routing, and basic autoscaling capabilities.

Watch the project in action:  https://youtu.be/Q8xWTKV2C3M


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
- **Networking**: Calico
- **DNS and Add-ons**: CoreDNS, Metrics Server, Local Path Provisioner

---

## EKS screenshots

<p float="left">
  <img src="path/to/image1.png" width="100" />
  <img src="path/to/image2.png" width="100" />
</p>

## Features Implemented

### Horizontal Pod Autoscaling

- Configured HPA for the `frontend` deployment.
- Autoscaling range: **min 1 pods**, **max 5 pods**
- Target CPU utilization is monitored via the **Metrics Server**.

### Observability

- **Metrics Server** deployed to collect resource usage metrics.
- Enabled **readiness/liveness probes** in deployments.

### Configuration Management

- Created **ConfigMaps** for all the microservice apps
- Environment variables are loaded from these ConfigMaps for cleaner configuration separation.

### Ingress Routing (Gateway API)

- Set up and configured **Gateway API** with **NGINX Gateway Controller**.
- Created `GatewayClass`, `Gateway`, and `HTTPRoute` resources to expose services externally via HTTP.

### Storage

- Used **local-path-provisioner** as the default `StorageClass`.
- Allows dynamic volume provisioning using hostPath, suitable for development and testing on local VMs.
- Mounted persistent volume (frontend-pvc) on the frontend-app

---

## RBAC configurations
### RBAC (Role-Based Access Control) is applied to:

- Restrict access to only necessary service accounts
- Follow the principle of least privilege



---

## CI/CD pipeline 

### CI/CD is managed with GitHub Actions, which automatically applies Kubernetes manifests on push.

#### Key Features

- Loads kubeconfig from a secret

- Uses kubectl apply -f to deploy frontend app

- Can be easily extended for full microservice stack deployments


## ❗ Limitation
Since the Kubernetes cluster runs on a local home lab (192.168.x.x), GitHub-hosted runners cannot reach the cluster directly. The deployment fails with:

```ruby
E0523 12:54:41.667122    2023 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: Get \"https://192.168.56.11:6443/api?timeout=32s\": dial tcp 192.168.56.11:6443: i/o timeout"
error: unable to recognize "deploy.yml": Get "https://192.168.56.11:6443/api?timeout=32s": dial tcp 192.168.56.11:6443: i/o timeout
Error: Process completed with exit code 1.
```
**Solution:**
To fix this I plan to create my own runner then try again , or I will deploy the project on a public cloud platform (AWS-EKS)



## 🛠️ Problems Faced & Solutions

### 1. ❌ VMs Lost Static IP

**Problem:**  
The VMs provisioned with Vagrant would lose their static IPs after reboot.

**Solution:**  
We fixed this by configuring static IPs via `netplan` on each node and adjusted VirtualBox network adapter settings for persistence.

---

### 2. 🌐 Gateway API Misconfigured

**Problem:**  
Gateway and HTTPRoutes were not routing traffic as expected. We were monitoring the wrong node (controlplane).

**Solution:**  
After debugging, we found the Gateway was deployed on `node01`, not the controlplane. We adjusted our DNS or `/etc/hosts` to point to the correct node’s IP.

---

### 3. 📊 Metrics Server Not Reporting

**Problem:**  
Running `kubectl top nodes` failed with:

**Solution:**  
We updated the Metrics Server arguments to:

```yaml
--kubelet-insecure-tls
--kubelet-preferred-address-types=InternalIP,Hostname
--secure-port=4443
--metric-resolution=30s

References: https://serverfault.com/questions/1153770/installed-metrics-server-in-kubernetes-cluster-but-getting-serviceunavailable?utm_source=chatgpt.com





## Requirements to Run Locally

- Vagrant
- VirtualBox
- 16 GB RAM recommended
- 4+ CPU cores

---

## Screenshots



---



