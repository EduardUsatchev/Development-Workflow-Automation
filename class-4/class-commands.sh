 1841  minikube delete
 1842  minikube start
 1843  \thelm upgrade --install flask-dev ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-dev.yaml \\n\t  -n demo-flask-dev --create-namespace
 1844  kgp
 1845  kubectl get pods
 1846  kubectl get ns
 1847  kubectl get pods -n demo-flask-dev
 1848  kubectl logs flask-demo-dbb6b5db7-bgzs5
 1849  kubectl logs flask-demo-dbb6b5db7-bgzs5 -n demo-flask-dev
 1850  minikube image build -t flask-demo:1 .\n\n# Apply manifests\nkubectl apply -f k8s/namespace.yaml\nkubectl apply -f k8s/deployment.yaml\nkubectl apply -f k8s/service-nodeport.yaml
 1851  \thelm upgrade --install flask-dev ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-dev.yaml \\n\t  -n demo-flask-dev --create-namespace
 1852  kubectl get pods -n demo-flask-dev
 1853  kubectl logs flask-demo-dbb6b5db7-bgzs5 -n demo-flask-dev
 1854  minikube service -n demo-flask-dev flask-demo --url
 1855  \thelm upgrade --install flask-prod ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-prod.yaml \\n\t  -n demo-flask-prod --create-namespace
 1856  kubectl -n demo-flask-prod port-forward svc/flask-demo 8080:80 >/dev/null 2>&1 & echo $$! > .pf.pid; \\n\tsleep 1; \\n\techo "http://127.0.0.1:8080"\; \\n\tcurl -s http://127.0.0.1:8080/moshe\; echo; \\n\tcurl -s http://127.0.0.1:8080/edi\; echo; \\n\tkill -9 $$(cat .pf.pid); rm -f .pf.pid
 1857  minikube service -n demo-flask-prod flask-demo --url
 1858  \thelm uninstall flask-dev -n demo-flask-dev || true\n\thelm uninstall flask-prod -n demo-flask-prod || true\n\tkubectl delete ns demo-flask-dev demo-flask-prod --ignore-not-found
 1859  cd ..
 1860  zip -r flask-helm-demo.zip flask-helm-demo
 1861  cd /Users/e0u00jg/Desktop/private/DevOpsExperts/intel/Development-Workflow-Automation/class-3/flask-helm-demo
 1862  minikube image build -t flask-demo:1 .
 1863  helm --help
 1864  minikube delete
 1865  mibikube status
 1866  minikube status
 1867  minikube start
 1868  minikube status
 1869  kubectl get pods
 1870  kubectl get ns
 1871  helm upgrade --install flask-dev ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-dev.yaml \\n\t  -n demo-flask-dev --create-namespace
 1872  kubectl get namespace
 1873  kubectl get pods -n demo-flask-dev
 1874  minikube image build -t flask-demo:1 .
 1875  kubectl get pods -n demo-flask-dev
 1876  kubectl get svc -n demo-flask-dev
 1877  kubectl get deploy -n demo-flask-dev
 1878  minikube service -n demo-flask-dev flask-demo --url
 1879  helm upgrade --install flask-dev ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-dev.yaml \\n\t  -n demo-flask-dev --create-namespace
 1880  kubectl get pods -n demo-flask-dev
 1881  helm upgrade --install flask-dev ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-dev.yaml \\n\t  -n demo-flask-dev --create-namespace
 1882  kubectl get svc -n demo-flask-dev
 1883  helm upgrade --install flask-dev ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-dev.yaml \\n\t  -n demo-flask-dev --create-namespace
 1884  kubectl get svc -n demo-flask-dev
 1885  \thelm upgrade --install flask-prod ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-prod.yaml \\n\t  -n demo-flask-prod --create-namespace
 1886  kubectl get ns
 1887  minikube image build -t flask-demo:2 .
 1888  helm upgrade --install flask-dev ./helm/flask-demo \\n\t  -f ./helm/flask-demo/values-dev.yaml \\n\t  -n demo-flask-dev --create-namespace
 1889  minikube service -n demo-flask-dev flask-demo --url
 1890  kubectl get ns
 1891  kubectl get pods -n demo-flask-dev
 1892  kubectl logs flask-demo-5d4c9dcf66-ch482 -n demo-flask-dev
 1893  kubectl logs flask-demo-5d4c9dcf66-ch482 -n demo-flask-dev -f