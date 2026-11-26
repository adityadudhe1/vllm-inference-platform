import http from "k6/http";

export const options = {
  vus: 10,
  duration: "1m",
};

export default function () {
  http.post(
    "http://vllm:8000/v1/chat/completions",
    JSON.stringify({
      model: "Qwen/Qwen2.5-0.5B-Instruct",
      messages: [
        {
          role: "user",
          content: "Explain Kubernetes in one sentence"
        }
      ]
    }),
    {
      headers: {
        "Content-Type": "application/json"
      }
    }
  );
}
