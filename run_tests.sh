#!/bin/bash

_base_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $_base_dir/test-runner.bash

test-runner:run "${@}"
