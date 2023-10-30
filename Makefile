MINIKUBE = /usr/bin/env minikube
KUSTOMIZE = /usr/bin/env kustomize
KUBECTL = /usr/bin/env kubectl

minikube:
	$(MINIKUBE) start \
	--kubernetes-version=v1.24.0 \
	--vm-driver=kvm2 \
	--cpus=4 \
	--memory=16g \
	--bootstrapper=kubeadm \
	--extra-config=kubelet.authentication-token-webhook=true \
	--extra-config=kubelet.authorization-mode=Webhook \
	--extra-config=scheduler.bind-address=0.0.0.0 \
	--extra-config=controller-manager.bind-address=0.0.0.0
	minikube addons enable ingress
	minikube addons enable default-storageclass
	minikube addons enable storage-provisioner
	minikube addons enable metrics-server

destroy:
	$(KUBECTL) delete -k deploy/step-3
	$(KUBECTL) delete pvc data-db-0
	$(KUBECTL) delete pvc data-elasticsearch-0

step-1:
	$(KUSTOMIZE) build deploy/step-1 | $(KUBECTL) apply -f -

step-2:
	$(KUSTOMIZE) build deploy/step-2 | $(KUBECTL) apply -f -

step-3:
	$(KUSTOMIZE) build deploy/step-3 | $(KUBECTL) apply -f -

.PHONY: minikube step-1 step-2 step-3 destroy
