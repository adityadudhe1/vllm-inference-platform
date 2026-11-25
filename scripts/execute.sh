# Total Worker Budget (0.60 / 60%): 6.0 GiB requested memory for the worker (10.0 GiB × 0.60).
# Model Weights + vLLM Runtime: 5.6 GiB consumed by non-KV usages.
# KV Cache Allocated: 0.4 GiB (6.0 GiB - 5.6 GiB = 0.4 GiB).
# Token Capacity: That 0.4 GiB of KV cache gives you 14,976 tokens of total capacity—meaning it can easily handle your 1,024-token limit with 14.62x concurrency headroom.

kubectl port-forward svc/vllm -n vllm 8000:8000

curl http://localhost:8000/v1/models

curl http://localhost:8000/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{
  "model":"Qwen/Qwen2.5-1.5B-Instruct",
  "messages":[
    {
      "role":"user",
      "content":"Explain Kubernetes in one sentence"
    }
  ]
}'
