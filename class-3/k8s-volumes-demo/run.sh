kubectl apply -f 00-namespace.yaml
kubectl apply -f 10-emptydir-pod.yaml
kubectl apply -f 20-pv-hostpath.yaml
kubectl apply -f 21-pvc.yaml
kubectl apply -f 30-deployment-pvc.yaml
kubectl -n vol-demo wait --for=condition=Ready pod/ed-nginx
kubectl -n vol-demo port-forward pod/ed-nginx 8080:80 &
curl -s http://127.0.0.1:8080
kubectl -n vol-demo exec -it ed-nginx -- sh -lc 'ls -lah /usr/share/nginx/html && echo "---" && cat /usr/share/nginx/html/index.html'
kubectl -n vol-demo exec -it ed-nginx -- sh -lc 'echo "Edited in-place: $(date)" >> /usr/share/nginx/html/index.html'
kubectl -n vol-demo port-forward pod/ed-nginx 8080:80 >/dev/null 2>&1 & PF=$!
curl -s http://127.0.0.1:8080 | sed -e "s/<[^>]*>//g"
kill $PF

kill %1
kubectl -n vol-demo rollout status deploy/pvc-nginx
kubectl -n vol-demo port-forward svc/pvc-nginx 8081:80 &
curl -s http://127.0.0.1:8081
POD=$(kubectl -n vol-demo get pod -l app=pvc-nginx -o jsonpath='{.items[0].metadata.name}')
kubectl -n vol-demo exec -it "$POD" -- sh -lc 'ls -lah /usr/share/nginx/html && echo "---" && cat /usr/share/nginx/html/index.html'
kubectl -n vol-demo exec -it "$POD" -- sh -lc 'echo "PVC updated at $(date)" >> /usr/share/nginx/html/index.html'
kubectl -n vol-demo port-forward svc/pvc-nginx 8081:80 >/dev/null 2>&1 & PF=$!
curl -s http://127.0.0.1:8081 | sed -e "s/<[^>]*>//g"
kill $PF

# verify persistence across pod restart:
kubectl -n vol-demo delete pod -l app=pvc-nginx
kubectl -n vol-demo rollout status deploy/pvc-nginx
curl -s http://127.0.0.1:8081

kubectl -n vol-demo delete pod -l app=pvc-nginx
kubectl -n vol-demo rollout status deploy/pvc-nginx
kubectl -n vol-demo port-forward svc/pvc-nginx 8081:80 >/dev/null 2>&1 & PF=$!
curl -s http://127.0.0.1:8081 | tail -n 1
kill $PF


kill %1
minikube ssh -- 'sudo ls -lah /data/vol-demo && echo "---" && sudo tail -n +1 /data/vol-demo/index.html'

kubectl delete -f 30-deployment-pvc.yaml
kubectl delete -f 21-pvc.yaml
kubectl delete -f 20-pv-hostpath.yaml
kubectl delete -f 10-emptydir-pod.yaml
kubectl delete -f 00-namespace.yaml
