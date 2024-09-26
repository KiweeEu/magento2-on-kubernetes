# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project follows [Magento 2 versions](https://devdocs.magento.com/release/policy/)
suffixed with Docker image version for given Magento 2 release.
E.g. 2.3.2-1 is the first version of the Magento 2.3.2 image.

## [2.4.6-p7-1] - 2024-09-26
### Fixed
- TLS is now supported locally with self-signed certificates managed by cert-manager

### Added
- Added PROXY protocol support

### Removed
- Removed ingressClass overrides

### Changed
- Updated Magento to v2.4.6-p7
- Dev dependency updates

## [2.4.6-p4-3] - 2024-03-04
### Fixed
- Fixed kiweeteam/magento2 image tags in all manifests

## [2.4.6-p4-2] - 2024-03-01
### Fixed
- Added initContainers to set volume permissions for Magento, MySQL, and Elasticsearch

## [2.4.6-p4-1] - 2024-02-21
### Changed
- Updated Magento to v2.4.6-p4
- Changed labels on Magento resources

### Fixed
- 502 errors on Minikube ([#197](https://github.com/KiweeEu/magento2-on-kubernetes/issues/197))
- step-1 failing due to missing secrets ([#196](https://github.com/KiweeEu/magento2-on-kubernetes/issues/196))

## [2.4.6-p3-3] - 2024-01-17
### Changed
- Updated supported Kubernetes versions (1.27, 1.28, 1.29)
- Changed labels on Magento Kubernetes objects

## [2.4.6-p3-2] - 2024-01-09
### Added
- Prometheus exporters for PHP and Nginx

### Changed
- Passwords (database, admin) are now randomly generated
- Updated dependencies
- Session storage is now configurable (Redis, Memcached, or database)

### Fixed
- Varnish returning incomplete response
- Failing CI pipeline

## [2.4.6-p3-1] - 2023-11-20
### Changed
- Updated Magento to 2.4.6-p3
- Updated PHP to 8.1.12
- Updated Elasticsearch to 7.17.15
- Updated Cypress to 13.5.1
- Pinned dependencies

### Removed
- Removed unused Dockerfie

## [2.4.6-p2-1] - 2023-10-24
### Added
- `make destroy` command
- Additional config and schema validation during Magento startup
- Custom fixture for data generator

### Changed
- Merged step-1 and step-2
- Replaced ECK-deployed Elasticsearch with a simple Statefulset
- Redirected Magento logs directly to `stdout`, without sidecar contianers
- Updated PHP to v8.2
- Updated Composer to v2.6
- Updated Percona to v8.0
- Updated Elasticsearch to v7.17
- Updated Varnish to v7.4

### Fixed
- Inconsistencies in domain names


## [2.4.5-p3-1] - 2023-06-28
### Changed
- Updated Magento 2.4.5-p3
- Updated supported K8s versions (v1.25, v1.26, v1.27)

## [2.4.4-p3-2] - 2023-06-07
### Changed
- Updated PHP to 8.1.19

## [2.4.4-p3-1] - 2023-06-02
### Changed
- Updated Magento to 2.4.4-p3
- Updated Magento initialization

## [2.3.7-p3-2] - 2023-06-02
### Added
- skaffold.yaml
- Simple E2E test

### Changed
- Updated supported K8s versions (v1.22.17, v1.23.17, v1.24.12)
- Replaced ECK with a StatefulSet for Elasticsearch
- Locked Composer version at v2.2
- Merged PHP and Nginx containers

## [2.3.7-p3-1] - 2022-05-12
### Changed
- Update ECK Operator to 1.9.1
- Magento now waits for Elasticsearch before initializing
- Magento now waits for Redis before initializing
- Cron jobs now start after Magento web service is ready
- Update Kubernetes to 1.21
- Update Magento to 2.3.7-p3
- Update Elasticsearch to 7.16

## [2.3.7-p2-1] - 2021-10-15
### Changed
- Update Magento to 2.3.7-p2
- Add --ignore-db-dir=lost+found option to Percona

## [2.3.7-p1-1] - 2021-10-01
### Changed
- Update Magento to 2.3.7-p1

## [2.3.7-1] - 2021-10-01
### Changed
- Update Magento to 2.3.7
- Remove Kubernetes Jobs after completion
- Set `imagePullPolicy` to `IfNotPresent` everywhere

## [2.3.6-p1-1] - 2021-03-04
### Added
- A main `kustomization.yaml` file
- Kubeval validation through Bitbucket pipelines
- Metadata in kustomization files
- Sources for Magento Docker image

### Changed
- Update ECK to 1.4.0
- Update Kubernetes to 1.18.15
- Update Magento version in K8s manifests
- Change `env` to `envs` in kustomization.yaml files
- Move all manifests to `deploy/`
- Use JSON for patchesJson6902 instead of YAML
- Always pull new images by default
- Use RWO accessMode on databse volumes
- Renamed 'aux.env' to 'additional.env'

## [2.3.2-1] - 2020-03-04
Initial public release.
