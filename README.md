Magento 2 on kubernetes
=======================

This is a companion repository for our
[Magento 2 on Kubernetes](https://kiwee.eu/magento-2-on-kubernetes/) blog post.

Here you will find all manifests discussed in the article as well as everything
else you need to deploy Magento 2 on Kubernetes yourself.

## Prerequisites

* Minikube or a Kubernetes cluster with NGINX Ingress controller and storage
  provisioning
* `kubectl` configured with the proper context
* Standalone version of [kustomize](https://kustomize.io/) v3.9.0 or newer
* `make`

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

# Deploy step-1 with Elasticsearch (using Elastic Cloud on Kubernetes)
make step-2

# Deploy step-2 with Redis for cache and session storage and
# HorizontalPodAutoscalers controlling NGINX and PHP-FPM deployments
make step-3

# Deploy step-3 with Varnish
make step-4
```
