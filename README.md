# vllm-inference-platform

Cloud-native LLM inference platform built on Azure Kubernetes Service (AKS) using Terraform, vLLM, Qwen, Prometheus, Grafana, and k6.

## Overview

This project demonstrates how to deploy, monitor, and benchmark an OpenAI-compatible LLM inference platform on Kubernetes.

Key focus areas:

- Infrastructure as Code with Terraform
- Kubernetes-based LLM serving
- OpenAI-compatible APIs
- Observability with Prometheus and Grafana
- Load testing with k6

## Architecture

```text
Terraform
   ↓
AKS
   ↓
vLLM (CPU Backend)
   ↓
Qwen 2.5 0.5B Instruct
   ↓
OpenAI-Compatible API
   ↓
Prometheus
   ↓
Grafana
   ↓
k6 Load Testing
```

## Technology Stack

| Component | Technology |
|------------|------------|
| Cloud | Azure |
| Infrastructure | Terraform |
| Kubernetes | AKS |
| Model Serving | vLLM |
| Model | Qwen 2.5 0.5B Instruct |
| Monitoring | Prometheus |
| Visualization | Grafana |
| Benchmarking | k6 |
| Package Manager | Helm |

## Implementation

### Infrastructure

- Azure Resource Group
- Virtual Network
- Subnet
- AKS Cluster

### Inference Platform

- vLLM CPU Backend
- Qwen 2.5 0.5B Instruct
- OpenAI-Compatible API Endpoints

### Observability

- kube-prometheus-stack
- Prometheus
- Grafana
- ServiceMonitor
- vLLM Metrics Collection

### Benchmarking

- k6 Load Testing
- Concurrent User Testing
- Latency Analysis

## Monitoring Metrics

```text
vllm:num_requests_running

vllm:num_requests_waiting

vllm:time_to_first_token_seconds_count

node_memory_MemAvailable_bytes
```

## Benchmark Results

| Concurrent Users (VUs) | Avg Latency | P95 Latency | Failure Rate |
|------------------------|------------|------------|-------------|
| 1 | 3.87s | 4.76s | 0% |
| 5 | 17.80s | 21.24s | 0% |
| 10 | 32.89s | 44.67s | 0% |

### Observations

- All benchmark runs completed without request failures.
- Latency increased as concurrency increased.
- CPU resources became the primary bottleneck under load.
- Single-node AKS deployment was sufficient for functional validation.
- GPU-based inference is expected to significantly improve throughput and latency.

## Lessons Learned

### CPU Backend

The standard GPU-oriented vLLM image failed on CPU-only AKS nodes.

Solution:

```text
vllm/vllm-openai-cpu:latest-x86_64
```

```yaml
VLLM_TARGET_DEVICE=cpu
```

### Shared Memory

vLLM required additional shared memory allocation.

```yaml
emptyDir:
  medium: Memory
```

mounted to:

```text
/dev/shm
```

### KV Cache Memory Constraints

Initial deployment failed due to insufficient KV cache memory.

Working configuration:

```text
Qwen/Qwen2.5-0.5B-Instruct

--max-model-len=1024

--max-num-seqs=1

--gpu-memory-utilization=0.60
```

### Prometheus Target Discovery

Prometheus was unable to discover vLLM metrics until the Service label matched the ServiceMonitor selector.

```yaml
metadata:
  labels:
    app: vllm
```

## Current Status

✅ Terraform

✅ AKS

✅ vLLM CPU Backend

✅ Qwen 2.5 0.5B Instruct

✅ OpenAI-Compatible API

✅ Prometheus

✅ Grafana

✅ ServiceMonitor

✅ vLLM Metrics

✅ k6 Benchmarking

## Next Phase

```text
AKS GPU Node Pool
   ↓
NVIDIA GPU Operator
   ↓
vLLM
   ↓
Qwen 7B
   ↓
Prometheus
   ↓
Grafana
   ↓
CPU vs GPU Benchmark Comparison
```
