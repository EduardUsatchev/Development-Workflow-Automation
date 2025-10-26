IMG=flask-demo:1
NS=demo-flask

.PHONY: build apply url test clean

build:
	minikube image build -t $(IMG) .

apply:
	kubectl apply -f k8s/namespace.yaml
	kubectl apply -f k8s/deployment.yaml
	kubectl apply -f k8s/service-nodeport.yaml
	kubectl -n $(NS) rollout status deploy/flask-deploy

url:
	@minikube service -n $(NS) flask-svc --url

test:
	@URL=$$(minikube service -n $(NS) flask-svc --url); \
	echo $$URL; \
	curl -s $$URL/moshe; echo; \
	curl -s $$URL/edi; echo

clean:
	kubectl delete ns $(NS) --ignore-not-found
