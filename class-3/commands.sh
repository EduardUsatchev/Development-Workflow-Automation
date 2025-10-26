brew install minikube kubectl
kubectl get po
minukube start
minikube version
minikube start
kubectl get pods
kubectl get pods -o wide
docker ps
kubectl get nodes
kubectl describe node minikube
kubectl run nginx --image=nginx:1.15.12-alpine
kubectl describe pod nginx
kubectl get pod -o wide
kubectl create deployment hello-node --image=nginx:1.15.12-alpine
#hello-node1          589b6f6bb9-         prmgv
#deploymaent name     Replicate set id     pod id in replica set
kubectl scale deployment/hello-node --replicas=8
kubectl get replicaset
kubectl describe replicaset hello-node-589b6f6bb9
kubectl describe deployment hello-node
kubectl set image deployment/hello-node nginx=nginx:stable-alpine3.20
kubectl get pods -l app=hello-node
kubectl config set-context --current --namespace=default


# Deployment + service
https://kubernetes.io/
http://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/
kubectl create deployment hello-node --image=nginx:1.15.12-alpine
kubectl expose deploy/hello-node --type CLusterIP --port 80
kubectl get svc
kubectl get pods -l app=hello-node
kubectl describe svc hello-node
kubectl expose deploy/hello-node --type NodePort --port 80
kubectl get svc hello-node -o yaml
kubectl patch svc hello-node -p '{"spec": {"type": "ClusterIP"}}'
kubectl edit svc hello-node
kubectl get svc
kubectl get pods
curl https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/pod-with-service.yaml
https://www.pulumi.com/

https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/

kubectl expose deploy/hello-node --type LoadBalancer --port 80
kubectl delete pod nginx
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/pod-with-service.yaml

#CronJob
https://crontab.guru/
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/guestbook/cronjob.yaml
curl https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/guestbook/cronjob.yaml
kubectl get pods
https://www.fluentd.org/
curl https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/guestbook/cronjob.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/guestbook/cronjob.yaml
kubectl get cronjob
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/guestbook/cronjob.yaml -n or
kubectl create ns or
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/guestbook/cronjob.yaml -n or
kubectl get pod -n or
kubectl get cronjobs.batch
kubectl get cronjobs.batch -n or
kubectl get pods -n or
history | tail -n30 | awk '{$1=""; print substr($0,2)}' | grep -v '^history'

#Storage
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pv.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pvc.yaml
curl https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pvc.yaml
kubectl describe persistentvolumeclaim/task-pv-claim
https://kubernetes.io/docs/concepts/storage/volumes/
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pod-with-pvc.yaml
kubectl exec -it task-pv-pod -- bash
cd usr/share/nginx/html/
echo 1 > index.html
exit
#Re-Run AT HOME
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pod-with-retain-deployment.yaml

kubectl debug node/docker-desktop -it --image=busybox -- sh
kubectl delete -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pod-with-pvc.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pod-with-pvc.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pod-empty-dir.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/config-map.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/game-config.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pod-with-config-map.yaml
kubectl exec -it pod-env-var -- bash
cat /app/game.properties
exit
kubectl describe configmap game-config
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/secret.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/pod-with-secret.yaml
https://github.com/bitnami-labs/sealed-secrets
https://www.akeyless.io/
https://www.hashicorp.com/en/products/vault
https://external-secrets.io/latest/
https://fluxcd.io/flux/guides/mozilla-sops/
kubectl delete -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/statefulset.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/statefulset.yaml
kubectl apply -f https://raw.githubusercontent.com/EduardUsatchev/k8s-demo/refs/heads/master/volumes/daemonset.yaml


#HELM
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-nginx bitnami/nginx \
  --set service.type=NodePort
# test
new pycharm project called DevOps2402
right click on the project and "Open In" , "Terminal"
in the terminal:
kubectl get pods
helm list
helm create mychart
cd mychart
helm template mychart ./
helm upgrade -i myrelease ./
# change replicaCount to 3
helm upgrade -i myrelease ./
helm list
helm uninstall myrelease
# in a new file called `values-prod.yaml` write
replicaCount: 5


helm upgrade -i myrelease -f values-prod.yaml ./
helm package ./mychart
helm registry login registry-1.docker.io -u avielb
# to create a token:
https://app.docker.com/settings/personal-access-tokens
helm push mychart-0.1.0.tgz oci://registry-1.docker.io/avielb


in Chart.yaml, edit from:
version: 0.1.0
to
version: 0.2.0

helm upgrade -i adamapp oci://registry-1.docker.io/adamlor/mychart --set replicaCount=1
tar xvzf mychart-0.1.0.tgz
helm fetch --untar  oci://registry-1.docker.io/adamlor/mychart
helm history adamapp
helm rollback adamapp
helm rollback adamapp 2
helm get values adamapp --all
helm get manifest adamapp
helm plugin install https://github.com/databus23/helm-diff

https://artifacthub.io/


helm uninstall adamapp my-release
helm lint mychart

helm diff revision myrelease 1 4
helm install my-release oci://registry-1.docker.io/bitnamicharts/redis

Chart.yaml
###########################################
apiVersion: v2
appVersion: 1.16.0
description: A Helm chart for Kubernetes
name: mychart
type: application
version: 0.2.0
dependencies:
  - name: redis
    version: 20.11.4
    repository: oci://registry-1.docker.io/bitnamicharts
###########################################

helm dep build

#Useful
helm search hub redis             # Search Artifact Hub for charts
helm search repo mychart          # Search local repos for a chart
helm show all mychart              # Show chart details (values, templates, README)
helm show values mychart           # Show only values.yaml from a chart
helm show chart mychart            # Show only Chart.yaml
helm dep update                    # Update dependencies in charts/ dir
helm dep list                      # List dependencies of a chart
helm install myrelease ./mychart --dry-run --debug   # Simulate install
helm template mychart ./ --debug                     # Render manifests
helm get notes myrelease                             # Show NOTES.txt output
helm upgrade myrelease ./mychart --set image.tag=1.21.0   # Override single value
helm upgrade myrelease ./mychart -f custom-values.yaml    # Override multiple
helm get values myrelease                                 # Show overridden values
helm get values myrelease --all                           # Show all values (incl. defaults)
helm history myrelease                 # Show release history
helm rollback myrelease 2              # Roll back to revision 2
helm status myrelease                   # Show status & resources
helm diff revision myrelease 3 5
helm uninstall myrelease           # Remove release
helm uninstall myrelease --keep-history  # Remove but keep history
helm repo remove bitnami            # Remove repo
helm repo list                      # List repos






