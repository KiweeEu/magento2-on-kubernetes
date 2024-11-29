# ![](https://repository-images.githubusercontent.com/244943894/d275c4fd-3345-49ff-87cc-6d064b39f0f0 "Magento® on Kubernetes")

Here you will find everything you need to **deploy Magento to a Kubernetes cluster**.

See our article on [how to run Magento on Kubernetes][mok-article] for a complete walkthrough of this setup.

We also offer [commercial support for running Magento on Kubernetes][mok-landing].

## Prerequisites

* Minikube or a Kubernetes cluster with NGINX Ingress controller and storage
  provisioning
* `kubectl` configured with the proper context
* Standalone version of [kustomize](https://kustomize.io/) v3.9.0 or newer
* `make`

## Compatibility

This project is developed and tested using [kind](https://kind.sigs.k8s.io/) with the [latest supported patch versions of Kubernetes](https://kubernetes.io/releases/).

## Deployment

Manifests in this repository can be deployed using `make`.

Starting a Minikube cluster with desired capabilities and addons, downloading
external dependencies, and deploying manifests with `kustomize` are all
automated in the `Makefile`.

```
# Start a Minikube cluster
make minikube

# Deploy a minimal Magento 2 configuration
make step-1

# Deploy step-1 with Redis for cache and session storage and
# HorizontalPodAutoscalers controlling NGINX and PHP-FPM deployments
make step-2

# Deploy step-2 with Varnish
make step-3
```

## Contributing

Contributions (issues, pull-requests) are welcome!

Please refer to [CONTRIBUTING](CONTRIBUTING.md) to get started.

[mok-landing]: https://kiwee.eu/services/cloud-native-solutions-for-ecommerce/magento-2-on-kubernetes-in-the-cloud/
[mok-article]: https://kiwee.eu/magento-2-on-kubernetes/
