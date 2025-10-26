#!/bin/bash
set -euo pipefail

# Build image inside minikube so cluster can pull it
minikube image build -t flask-demo:1 .

# Apply manifests
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service-nodeport.yaml

# Wait for rollout
kubectl -n demo-flask rollout status deploy/flask-deploy

# Show and test URL
URL=$(minikube service -n demo-flask flask-svc --url)
echo "Service URL: $URL"
echo "Testing endpoints:"
echo -n "/moshe -> "; curl -s "$URL/moshe"; echo
echo -n "/edi   -> "; curl -s "$URL/edi"; echo
