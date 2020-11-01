#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}" || realpath "${BASH_SOURCE[0]}")")

main() {
    args=()

    if [[ -n "${INPUT_VERSION:-}" ]]; then
        args+=(--version "${INPUT_VERSION}")
    fi

    if [[ -n "${INPUT_PROFILE:-}" ]]; then
        args+=(--profile "${INPUT_PROFILE}")
    fi

    if [[ -n "${INPUT_WAIT:-}" ]]; then
        args+=(--wait "${INPUT_WAIT}")
    fi

    chmod +x "$SCRIPT_DIR/install.sh"
    
    "$SCRIPT_DIR/install.sh" "${args[@]}"
}

main