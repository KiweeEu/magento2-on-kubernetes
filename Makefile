minikube:
	minikube start \
	--kubernetes-version=v1.17.0 \
	--vm-driver=kvm2 \
	--cpus=4 \
	--memory=16g \
	--bootstrapper=kubeadm \
	--extra-config=kubelet.authentication-token-webhook=true \
	--extra-config=kubelet.authorization-mode=Webhook \
	--extra-config=scheduler.address=0.0.0.0 \
	--extra-config=controller-manager.address=0.0.0.0
	minikube addons enable ingress
	minikube addons enable default-storageclass
	minikube addons enable storage-provisioner
	minikube addons enable metrics-server

step-1:
	kustomize build step-1 | kubectl apply -f -

.PHONY: minikube step-1
