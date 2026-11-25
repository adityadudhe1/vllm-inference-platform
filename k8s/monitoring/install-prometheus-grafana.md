helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

kubectl apply -f namespace.yaml

helm install prometheus \
  prometheus-community/kube-prometheus-stack \
  --namespace monitoring

kubectl get pods -n monitoring
