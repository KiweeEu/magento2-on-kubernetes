MINIKUBE = /usr/bin/env minikube
KUSTOMIZE = /usr/bin/env kustomize
KUBECTL = /usr/bin/env kubectl
HELM = /usr/bin/env helm

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

cluster-dependencies:
	$(HELM) repo add mittwald https://helm.mittwald.de
	$(HELM) repo add cert-manager https://charts.jetstack.io
	$(HELM) repo update
	$(HELM) upgrade --install cert-manager cert-manager/cert-manager \
	--set installCRDs=true \
	--set ingressShim.defaultIssuerKind=ClusterIssuer \
	--set ingressShim.defaultIssuerName=selfsigned
	$(HELM) upgrade --install ingress-nginx oci://ghcr.io/nginxinc/charts/nginx-ingress \
  --set controller.kind=daemonset \
  --set controller.enableSnippets=true \
  --set controller.service.enabled=true \
  --set controller.service.type=ClusterIP \
  --set controller.service.clusterIP=10.96.0.2 \
  --set controller.service.httpPort.port=80 \
  --set controller.service.httpsPort.port=443 \
  --set controller.ingressClass.create=true \
  --set controller.ingressClass.name=nginx \
  --set controller.ingressClass.setAsDefaultIngress=true
	$(HELM) upgrade --install secret-gsenerator mittwald/kubernetes-secret-generator

destroy:
	$(KUBECTL) delete -k deploy/step-3
	$(KUBECTL) delete pvc data-db-0
	$(KUBECTL) delete pvc data-elasticsearch-0

step-1: cluster-dependencies
	$(KUSTOMIZE) build deploy/walkthrough/step-1 | $(KUBECTL) apply -f -

step-2: cluster-dependencies
	$(KUSTOMIZE) build deploy/walkthrough/step-2 | $(KUBECTL) apply -f -

step-3: cluster-dependencies
	$(KUSTOMIZE) build deploy/walkthrough/step-3 | $(KUBECTL) apply -f -

.PHONY: minikube cluster-dependencies step-1 step-2 step-3 destroy
