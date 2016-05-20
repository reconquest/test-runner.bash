_base_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source $_base_dir/vendor/github.com/reconquest/import.bash/import.bash

import github.com/reconquest/opts


_test_runner_local_setup=tests/setup.sh
_test_runner_testcases_dir=tests/testcases
_test_runner_custom_opts=()


test-runner:handle-custom-opt() {
    :
}


test-runner:handle-args() {
    :
}


test-runner:set-custom-opts() {
    _test_runner_custom_opts=${@}
}


test-runner:set-testcases-dir() {
    _test_runner_testcases_dir=$1
}


test-runner:set-local-setup() {
    _test_runner_local_setup=$1
}


test-runner:run() {
    local -A opts
    local -a args

    opts:parse opts args -v -A -O ${_test_runner_custom_opts[@]:-} -- "${@}"

    for custom_opt in ${_test_runner_custom_opts[@]:-}; do
        if [ "${opts[$custom_opt]:-}" ]; then
            test-runner:handle-custom-opt "$custom_opt" "${opts[$custom_opt]}"
        fi
    done

    local run_flags=()
    if [ "${opts[-O]:-}" ]; then
        if [ ${#args[@]} -gt 1 ]; then
            run_flags=(-O "${args[1]}")

            unset args[1]
        else
            run_flags=(-O)
        fi
    else
        run_flags=(-A)
    fi

    test-runner:handle-args "${args[@]:-}"

    if [ "${opts[-v]:-}" ]; then
        tests:set-verbose "${opts[-v]}"
    fi

    (
        import github.com/reconquest/tests.sh

        tests:main \
            -d "$_test_runner_testcases_dir" \
            -s "$_test_runner_local_setup" \
            "${run_flags[@]}"
    )
}
