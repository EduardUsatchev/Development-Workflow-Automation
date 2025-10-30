# Flask + Kubernetes on Minikube (NodePort)

## Quick start
```bash
# 1) Start minikube if needed
minikube start

# 2) Build image inside minikube and deploy
bash deploy-minikube.sh
# or:
# make build && make apply

# 3) Get URL and test
minikube service -n demo-flask flask-svc --url
curl "$(minikube service -n demo-flask flask-svc --url)/moshe"
curl "$(minikube service -n demo-flask flask-svc --url)/edi"
