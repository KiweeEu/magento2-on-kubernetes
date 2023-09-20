MINIKUBE = /usr/bin/env minikube
KUSTOMIZE = /usr/bin/env kustomize
KUBECTL = /usr/bin/env kubectl

ELASTIC-OPERATOR-PAkubeTH := vendor/ec-on-k8s

ELASTIC-CRDS-URL := https://download.elastic.co/downloads/eck/1.9.1/crds.yaml
ELASTIC-CRDS-FILE := crds.yaml
ELASTIC-CRDS-PATH := ./es-crds

ELASTIC-OPERATOR-URL := https://download.elastic.co/downloads/eck/1.9.1/operator.yaml
ELASTIC-OPERATOR-FILE := operator.yaml
ELASTIC-OPERATOR-PATH := ./es-operator


$(ELASTIC-OPERATOR-PATH):
	mkdir -p $(ELASTIC-OPERATOR-PATH)

$(ELASTIC-CRDS-PATH):
	mkdir -p $(ELASTIC-CRDS-PATH)

$(ELASTIC-OPERATOR-PATH)/$(ELASTIC-OPERATOR-FILE): $(ELASTIC-OPERATOR-PATH)
	curl -o $(ELASTIC-OPERATOR-PATH)/$(ELASTIC-OPERATOR-FILE) $(ELASTIC-OPERATOR-URL)

$(ELASTIC-CRDS-PATH)/$(ELASTIC-CRDS-FILE): $(ELASTIC-CRDS-PATH)
	curl -o $(ELASTIC-CRDS-PATH)/$(ELASTIC-CRDS-FILE) $(ELASTIC-CRDS-URL)

elastic-operator: $(ELASTIC-OPERATOR-PATH)/$(ELASTIC-OPERATOR-FILE)
	$(KUBECTL) apply -f $(ELASTIC-OPERATOR-PATH)/$(ELASTIC-OPERATOR-FILE)

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

step-2: elastic-crds elastic-operator
	$(KUSTOMIZE) build deploy/step-2 | $(KUBECTL) apply -f -

step-3: elastic-crds elastic-operator
	$(KUSTOMIZE) build deploy/step-3 | $(KUBECTL) apply -f -

step-4: elastic-crds elastic-operator
	$(KUSTOMIZE) build deploy/step-4 | $(KUBECTL) apply -f -

.PHONY: minikube step-1 step-2 step-3 step-4
