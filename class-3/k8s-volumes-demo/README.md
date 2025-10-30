# k8s-volumes-demo (emptyDir + PV/PVC)

## Apply
```bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 10-emptydir-pod.yaml
kubectl apply -f 20-pv-hostpath.yaml
kubectl apply -f 21-pvc.yaml
kubectl apply -f 30-deployment-pvc.yaml
