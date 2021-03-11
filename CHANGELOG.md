# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project follows [Magento 2 versions](https://devdocs.magento.com/release/policy/)
suffixed with Docker image version for given Magento 2 release.
E.g. 2.3.2-1 is the first version of the Magento 2.3.2 image.

## Unreleased

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
