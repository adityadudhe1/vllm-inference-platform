# vllm-inference-platform

Cloud-native LLM inference platform built using Terraform, Azure Kubernetes Service (AKS), vLLM, Qwen models, Prometheus, Grafana, and benchmarking tools.

## Overview

This project demonstrates how to deploy, operate, observe, and benchmark an OpenAI-compatible Large Language Model (LLM) inference platform on Kubernetes.

The primary objective is to gain hands-on experience with AI Platform Engineering concepts including infrastructure automation, model serving, observability, and performance benchmarking.

Unlike managed AI services, this project focuses on self-managed inference workloads running on Kubernetes using vLLM.

---

## Architecture

```text
                     +----------------+
                     |   Terraform    |
                     +--------+-------+
                              |
                              v
                     +----------------+
                     |      AKS       |
                     +--------+-------+
                              |
                              v
                     +----------------+
                     |     vLLM       |
                     +--------+-------+
                              |
                              v
                     +----------------+
                     |  Qwen Model    |
                     +--------+-------+
                              |
                              v
                     +----------------+
                     | OpenAI API     |
                     | Compatible     |
                     +--------+-------+
                              |
          +-------------------+-------------------+
          |                                       |
          v                                       v
 +----------------------+             +----------------------+
 |     Prometheus       |             |      Grafana         |
 +----------------------+             +----------------------+

                              |
                              v
                     +----------------+
                     | Benchmarking   |
                     |      k6        |
                     +----------------+
```

---

## Objectives

- Provision AKS infrastructure using Terraform.
- Deploy vLLM on Kubernetes.
- Serve Qwen models through OpenAI-compatible APIs.
- Monitor inference workloads using Prometheus and Grafana.
- Benchmark model performance under load.
- Evaluate CPU and GPU-based inference deployments.
- Understand production-oriented LLM serving patterns.

---

## Technology Stack

| Component | Technology |
|------------|------------|
| Cloud | Azure |
| Infrastructure as Code | Terraform |
| Container Platform | Azure Kubernetes Service (AKS) |
| Model Serving | vLLM |
| Foundation Model | Qwen |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Benchmarking | k6 |
| Container Runtime | Docker |
| Package Manager | Helm |
| Source Control | GitHub |

---

## Repository Structure

```text
vllm-inference-platform
│
├── terraform
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── network.tf
│   └── aks.tf
│
├── kubernetes
│   ├── vllm
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── config.yaml
│   │
│   ├── monitoring
│   │   ├── prometheus
│   │   └── grafana
│   │
│   └── benchmarking
│       └── k6
│
├── docs
│
└── README.md
```

---

## Development Roadmap

### Phase 1 - Infrastructure

- [ ] Create Azure Resource Group
- [ ] Create Virtual Network
- [ ] Create AKS Cluster
- [ ] Configure kubectl access

### Phase 2 - LLM Inference

- [ ] Deploy vLLM
- [ ] Deploy Qwen 2.5 1.5B
- [ ] Expose OpenAI-compatible endpoint
- [ ] Validate inference requests

### Phase 3 - Observability

- [ ] Deploy kube-prometheus-stack
- [ ] Configure Grafana dashboards
- [ ] Monitor CPU and memory utilization
- [ ] Monitor inference workloads

### Phase 4 - Benchmarking

- [ ] Configure k6 load tests
- [ ] Capture latency metrics
- [ ] Measure throughput
- [ ] Compare performance across workloads

### Phase 5 - GPU Enablement

- [ ] GPU node pool
- [ ] NVIDIA GPU Operator
- [ ] DCGM Exporter
- [ ] GPU monitoring dashboard
- [ ] GPU-based model serving

---

## Current Scope (Phase 1)

Initial implementation focuses on CPU-based inference.

```text
Terraform
    ↓
AKS
    ↓
CPU Node Pool
    ↓
vLLM
    ↓
Qwen 2.5 1.5B
    ↓
Prometheus
    ↓
Grafana
    ↓
k6 Benchmarking
```

This phase establishes the platform architecture before introducing GPU acceleration.

---

## Benchmarking Goals

### Latency Metrics

- Average Latency
- P95 Latency
- P99 Latency

### Throughput Metrics

- Requests Per Second (RPS)
- Tokens Per Second (TPS)

### Resource Metrics

- CPU Utilization
- Memory Consumption
- Pod Resource Usage

### Load Testing Scenarios

- Single User
- Multiple Concurrent Users
- Sustained Load
- Burst Traffic

---

## Sample Inference Flow

```text
User Request
      ↓
AKS Service
      ↓
vLLM
      ↓
Qwen
      ↓
Generated Response
```

---

## Future Enhancements

### Infrastructure

- Private AKS Cluster
- Azure Key Vault Integration
- Managed Identity Authentication
- GitHub Actions CI/CD

### AI Platform

- Qwen 7B
- Llama Models
- DeepSeek Models
- Multi-Model Routing
- Model Versioning

### Scalability

- Horizontal Pod Autoscaler (HPA)
- KEDA Event-Driven Scaling
- Cluster Autoscaler
- Multi-Node Deployments

### Observability

- OpenTelemetry
- Distributed Tracing
- Centralized Logging
- Service Level Objectives (SLOs)

### GPU Platform

```text
Terraform
    ↓
AKS
    ↓
GPU Node Pool
    ↓
NVIDIA GPU Operator
    ↓
DCGM Exporter
    ↓
vLLM
    ↓
Qwen 7B
    ↓
Prometheus
    ↓
Grafana
```

---

## Learning Outcomes

By completing this project, the following areas will be covered:

- Terraform Automation
- AKS Administration
- Kubernetes Workloads
- vLLM Deployment
- LLM Inference Architecture
- OpenAI-Compatible APIs
- Prometheus Monitoring
- Grafana Dashboards
- Benchmarking and Performance Analysis
- GPU-Based AI Workloads

---

## Milestones

| Milestone | Target Date |
|------------|------------|
| AKS Deployment | Nov 28 |
| vLLM Deployment | Dec 1 |
| Monitoring Stack | Dec 3 |
| Benchmarking | Dec 5 |
| GPU Experiments | Dec 15 |
| GPU Operator Integration | Dec 20 |

---

## Status

🚧 Work In Progress

---
## Lessons Learned

### CPU Backend

The standard `vllm/vllm-openai` image failed on CPU-only AKS nodes with the error:

```text
Failed to infer device type
```

The solution was to use:

```text
vllm/vllm-openai-cpu:latest-x86_64
```

and configure:

```text
VLLM_TARGET_DEVICE=cpu
```

### Shared Memory

vLLM required additional `/dev/shm` space for shared-memory communication between processes.

### Memory Constraints

Running Qwen2.5-1.5B on an AKS Standard_D4s_v5 node required reducing:

- max-model-len
- max-num-seqs
- gpu-memory-utilization

to fit memory constraints during KV cache allocation.
