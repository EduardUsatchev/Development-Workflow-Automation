# Flask + Helm with dev/prod on Minikube

## Build & deploy
```bash
# 1) Start minikube if needed
minikube start

# 2) Build the image *into* minikube
make build

# 3) Deploy dev (NodePort)
make dev-up
make dev-url
make dev-test

# 4) Deploy prod (ClusterIP; uses port-forward in test)
make prod-up
make prod-test
