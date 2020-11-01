#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

main() {
    kubectl delete ns istio-system
}

main