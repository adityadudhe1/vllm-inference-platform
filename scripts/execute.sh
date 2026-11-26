# Total Worker Budget (0.60 / 60%): 6.0 GiB requested memory for the worker (10.0 GiB × 0.60).
# Model Weights + vLLM Runtime: 5.6 GiB consumed by non-KV usages.
# KV Cache Allocated: 0.4 GiB (6.0 GiB - 5.6 GiB = 0.4 GiB).
# Token Capacity: That 0.4 GiB of KV cache gives you 14,976 tokens of total capacity—meaning it can easily handle your 1,024-token limit with 14.62x concurrency headroom.

kubectl port-forward svc/vllm -n vllm 8000:8000

curl http://localhost:8000/v1/models

curl http://localhost:8000/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{
  "model":"Qwen/Qwen2.5-0.5B-Instruct",
  "messages":[
    {
      "role":"user",
      "content":"Explain Kubernetes in one sentence"
    }
  ]
}'

To get Grafana admin password:
kubectl --namespace monitoring get secrets prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

To load prom UI:
kubectl port-forward svc/prometheus-grafana -n monitoring 3000:80



Execute K6 thhgouh pod in kubernetes:
pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: k6
  namespace: vllm
spec:
  containers:
    - name: k6
      image: grafana/k6
      command:
        - sleep
        - infinity
        
#kubectl cp chat-completion.js vllm/k6:/tmp/chat-completion.js

#kubectl exec -it k6 -n vllm -- k6 run /tmp/chat-completion.js

Below metrics to monitor in Grafana:
vllm:num_requests_running
vllm:num_requests_waiting
vllm:time_to_first_token_seconds_count
node_memory_MemAvailable_bytes

VUs           : 5
Duration      : 1 minute
Requests      : 20
Failure Rate  : 0%
Avg Latency   : 17.8 sec
P95 Latency   : 21.24 sec
Max Latency   : 22.89 sec
