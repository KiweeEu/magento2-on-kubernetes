MINIKUBE = /usr/bin/env minikube
KUSTOMIZE = /usr/bin/env kustomize
KUBECTL = /usr/bin/env kubectl

ELASTIC-CRDS-URL := https://download.elastic.co/downloads/eck/1.9.1/crds.yaml
ELASTIC-CRDS-FILE := crds.yaml
ELASTIC-CRDS-PATH := ./es-crds


$(ELASTIC-CRDS-PATH):
	mkdir -p $(ELASTIC-CRDS-PATH)

$(ELASTIC-CRDS-PATH)/$(ELASTIC-CRDS-FILE): $(ELASTIC-CRDS-PATH)
	curl -o $(ELASTIC-CRDS-PATH)/$(ELASTIC-CRDS-FILE) $(ELASTIC-CRDS-URL)

elastic-crds: $(ELASTIC-CRDS-PATH)/$(ELASTIC-CRDS-FILE)
	$(KUBECTL) create -f $(ELASTIC-CRDS-PATH)/$(ELASTIC-CRDS-FILE)


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

step-1:
	$(KUSTOMIZE) build deploy/step-1 | $(KUBECTL) apply -f -

step-2: elastic-crds
	$(KUSTOMIZE) build deploy/step-2 | $(KUBECTL) apply -f -

step-3: elastic-crds
	$(KUSTOMIZE) build deploy/step-3 | $(KUBECTL) apply -f -

step-4: elastic-crds
	$(KUSTOMIZE) build deploy/step-4 | $(KUBECTL) apply -f -

.PHONY: minikube step-1 step-2 step-3 step-4
