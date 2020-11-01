# *Istio* Action

[![](https://github.com/bilelkhalsi/istio-action/workflows/Test/badge.svg?branch=master)](https://github.com/bilelkhalsi/istio-action/actions)

A GitHub Action to install [Istio](https://istio.io/) on Kubernetes cluster.

## Usage

### Pre-requisites

* Create a workflow YAML file in your `.github/workflows` directory. An [example workflow](#example-workflow) is available below.
For more information, reference the GitHub Help Documentation for [Creating a workflow file](https://help.github.com/en/articles/configuring-a-workflow#creating-a-workflow-file).
* Use another Github Action as `helm/kind-action` to create a Kubernetes cluster.

### Inputs

- `version`: The Istio version to use (default: `1.7.4`)
- `profile`: The Istio profile (`demo`, `default` or `minimal`)
- `wait`: The duration to wait for the Istio CRD's to become ready (default: `60s`)


### Example Workflow

Create a workflow (eg: `.github/workflows/install-istio.yml`):

```yaml
name: Install Istio on KinD K8s cluster

on: pull_request

jobs:
  install-cluster:
    runs-on: ubuntu-latest
    steps:
      - name: Create k8s Kind Cluster
        uses: helm/kind-action@v1.0.0
      - name: Install Istio
        uses: helm/kind-action@v1.0.0      
```

This uses [@bilelkhalsi/istio-action](https://www.github.com/bilelkhalsi/istio-action) GitHub Action to spin up a [kind](https://kind.sigs.k8s.io/) Kubernetes cluster with [Istion](https://istio.io/) installed on every Pull Request.

### Reference Documentation
For further reference, please consider the following sections:
* [KinD Github Action](https://github.com/helm/kind-action)
* [Istio Documentation](https://istio.io/latest/docs/)
