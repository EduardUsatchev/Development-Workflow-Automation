IMG=flask-demo:1

.PHONY: build dev-up dev-url dev-test prod-up prod-test down

build:
	# Build image into minikube so the cluster can pull it
	minikube image build -t flask-demo:1 .

dev-up:
	helm upgrade --install flask-dev ./helm/flask-demo \
	  -f ./helm/flask-demo/values-dev.yaml \
	  -n demo-flask-dev --create-namespace

dev-url:
	@minikube service -n demo-flask-dev flask-demo --url

dev-test:
	@URL=$$(minikube service -n demo-flask-dev flask-demo --url); \
	echo $$URL; \
	curl -s $$URL/moshe; echo; \
	curl -s $$URL/edi; echo

prod-up:
	helm upgrade --install flask-prod ./helm/flask-demo \
	  -f ./helm/flask-demo/values-prod.yaml \
	  -n demo-flask-prod --create-namespace

prod-test:
	@kubectl -n demo-flask-prod port-forward svc/flask-demo 8080:80 >/dev/null 2>&1 & echo $$! > .pf.pid; \
	sleep 1; \
	echo "http://127.0.0.1:8080"; \
	curl -s http://127.0.0.1:8080/moshe; echo; \
	curl -s http://127.0.0.1:8080/edi; echo; \
	kill -9 $$(cat .pf.pid); rm -f .pf.pid

down:
	helm uninstall flask-dev -n demo-flask-dev || true
	helm uninstall flask-prod -n demo-flask-prod || true
	kubectl delete ns demo-flask-dev demo-flask-prod --ignore-not-found
