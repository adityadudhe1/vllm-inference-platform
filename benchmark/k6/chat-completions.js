import http from "k6/http";

export default function () {
  const payload = JSON.stringify({
    model: "Qwen/Qwen2.5-1.5B-Instruct",
    messages: [
      {
        role: "user",
        content: "Explain Kubernetes in one paragraph"
      }
    ],
    max_tokens: 100
  });

  http.post(
    "http://<VLLM-ENDPOINT>:8000/v1/chat/completions",
    payload,
    {
      headers: {
        "Content-Type": "application/json"
      }
    }
  );
}
