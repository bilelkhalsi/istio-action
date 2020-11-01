#!/usr/bin/env bash


set -o errexit
set -o nounset
set -o pipefail

DEFAULT_ISTIO_VERSION=1.7.4
DEFAULT_ISTIO_PROFILE=default

show_help() {
cat << EOF
Usage: $(basename "$0") <options>
    -h, --help                              Display help
    -v, --version                           The Istio version to use (default: 1.7.4)"
    -p, --profile                           The Istio profile to use (default: 'default')"
    -w, --wait                              The duration to wait for the Istio RCD's to become ready (default: 60s)"
EOF
}

main() {
    local version="$DEFAULT_ISTIO_VERSION"
    local profile="$DEFAULT_ISTIO_PROFILE"
    local wait=60s

    parse_command_line "$@"

    download_istio
    install_istio
    inject_istio

}

parse_command_line() {
    while :; do
        case "${1:-}" in
            -h|--help)
                show_help
                exit
                ;;
            -v|--version)
                if [[ -n "${2:-}" ]]; then
                    version="$2"
                    shift
                else
                    echo "ERROR: '-v|--version' cannot be empty." >&2
                    show_help
                    exit 1
                fi
                ;;
            -p|--profile)
                if [[ -n "${2:-}" ]]; then
                    profile="$2"
                    shift
                else
                    echo "ERROR: '-p|--profile' must be 'demo', 'default' or 'minimal'." >&2
                    show_help
                    exit 1
                fi
                ;;
            -w|--wait)
                if [[ -n "${2:-}" ]]; then
                    wait="$2"
                    shift
                else
                    echo "ERROR: '-w|--wait' cannot be empty." >&2
                    show_help
                    exit 1
                fi
                ;;
            *)
                break
                ;;
        esac

        shift
    done
}

donwload_istio() {
    echo 'Installing istio...'
    curl -L https://istio.io/downloadIstio | ISTIO_VERSION=$version TARGET_ARCH=x86_64 sh -
    cd "istio-$version"
    chmod +x bin/istioctl
    sudo mv bin/istioctl /usr/local/bin/istioctl
}

install_istio() {
    echo 'Installing Istio...'
    istioctl install --set profile=$profile -y
    kubectl -n istio-system wait pods --selector=app=istio-ingressgateway --for=condition=Ready --timeout=$wait
}

inject_istio() {
    echo 'Inject Istio in default namespace...'
    kubectl label namespace default istio-injection=enabled
}

main "$@"