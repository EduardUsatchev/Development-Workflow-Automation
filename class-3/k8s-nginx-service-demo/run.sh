kubectl apply -f 00-no-service/deployment.yaml

# list pods and their IPs
kubectl -n demo-svc get pods -o wide

# start a temporary curl client inside the cluster
kubectl -n demo-svc run curl --image=curlimages/curl:8.10.1 -it --rm -- /bin/sh
# inside the pod, curl each Pod IP directly:
# (replace with the IPs you saw)
curl http://10.244.0.23/
curl http://10.244.1.7/
curl http://10.244.2.15/
exit

kubectl apply -f 01-clusterip/deployment.yaml
kubectl apply -f 01-clusterip/service-clusterip.yaml

# see service and its stable ClusterIP
kubectl -n demo-svc get svc nginx-svc

# get endpoints selected by the service (should be the 3 pods)
kubectl -n demo-svc get endpoints nginx-svc -o wide

# run a curl pod to test in-cluster DNS + load-balancing
kubectl -n demo-svc run curl --image=curlimages/curl:8.10.1 -it --rm -- /bin/sh
# inside:
for i in $(seq 1 6); do
  curl -s http://nginx-svc.demo-svc.svc.cluster.local/ | sed 's/<[^>]*>//g'
done
exit


kubectl apply -f 02-nodeport/service-nodeport.yaml

kubectl -n demo-svc get svc nginx-nodeport

# From your machine (if you can reach cluster nodes):
# Replace <ANY_NODE_IP> with a worker/node IP you can reach.
curl http://<ANY_NODE_IP>:30080/
minikube service -n demo-svc nginx-nodeport --url




