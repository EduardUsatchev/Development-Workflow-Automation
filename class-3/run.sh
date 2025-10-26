#!/bin/bash
set -euo pipefail

ROOT="k8s-volumes-demo"
mkdir -p "$ROOT"

# 00) Namespace
cat > "$ROOT/00-namespace.yaml" <<'YAML'
apiVersion: v1
kind: Namespace
metadata:
  name: vol-demo
YAML

# 10) emptyDir Pod example
cat > "$ROOT/10-emptydir-pod.yaml" <<'YAML'
apiVersion: v1
kind: Pod
metadata:
  name: ed-nginx
  namespace: vol-demo
  labels:
    app: ed-nginx
spec:
  volumes:
    - name: www
      emptyDir: {}          # use medium: Memory for tmpfs
  initContainers:
    - name: init-site
      image: busybox:1.36
      command: ["/bin/sh","-c"]
      args:
        - |
          echo "Hello from emptyDir at $(date)" > /workdir/index.html
      volumeMounts:
        - name: www
          mountPath: /workdir
  containers:
    - name: nginx
      image: nginx:1.27-alpine
      ports:
        - containerPort: 80
      volumeMounts:
        - name: www
          mountPath: /usr/share/nginx/html
YAML

# 20) PersistentVolume (hostPath) – great for minikube/kind
cat > "$ROOT/20-pv-hostpath.yaml" <<'YAML'
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-hostpath-demo
spec:
  capacity:
    storage: 1Gi
  accessModes: [ReadWriteOnce]
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /data/vol-demo
YAML

# 21) PersistentVolumeClaim
cat > "$ROOT/21-pvc.yaml" <<'YAML'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-demo
  namespace: vol-demo
spec:
  accessModes: [ReadWriteOnce]
  storageClassName: manual
  resources:
    requests:
      storage: 1Gi
YAML

# 30) Deployment using the PVC + ClusterIP Service
cat > "$ROOT/30-deployment-pvc.yaml" <<'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pvc-nginx
  namespace: vol-demo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pvc-nginx
  template:
    metadata:
      labels:
        app: pvc-nginx
    spec:
      volumes:
        - name: site
          persistentVolumeClaim:
            claimName: pvc-demo
      initContainers:
        - name: seed
          image: busybox:1.36
          command: ["/bin/sh","-c"]
          args:
            - |
              mkdir -p /mnt/site;
              echo "Hello from PVC at $(date)" > /mnt/site/index.html;
          volumeMounts:
            - name: site
              mountPath: /mnt/site
      containers:
        - name: nginx
          image: nginx:1.27-alpine
          ports:
            - containerPort: 80
          volumeMounts:
            - name: site
              mountPath: /usr/share/nginx/html
---
apiVersion: v1
kind: Service
metadata:
  name: pvc-nginx
  namespace: vol-demo
spec:
  type: ClusterIP
  selector:
    app: pvc-nginx
  ports:
    - name: http
      port: 80
      targetPort: 80
YAML

# Optional README with quick commands
cat > "$ROOT/README.md" <<'MD'
# k8s-volumes-demo (emptyDir + PV/PVC)

## Apply
```bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 10-emptydir-pod.yaml
kubectl apply -f 20-pv-hostpath.yaml
kubectl apply -f 21-pvc.yaml
kubectl apply -f 30-deployment-pvc.yaml
