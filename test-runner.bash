if ! declare -f import:source &>/dev/null; then
    _base_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
    source $_base_dir/vendor/github.com/reconquest/import.bash/import.bash
fi

import:source "github.com/reconquest/opts.bash"


_test_runner_local_setup=tests/setup.sh
_test_runner_local_teardown=tests/teardown.sh
_test_runner_testcases_dir=tests/testcases
_test_runner_custom_opts=()


test-runner:handle-custom-opt() {
    :
}


test-runner:handle-args() {
    :
}

test-runner:progress() {
    cat >/dev/null
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


test-runner:set-local-teardown() {
    _test_runner_local_teardown=$1
}

test-runner:run() {
    local -A opts
    local -a args

    opts:parse opts args \
        -h --help -v -A -O ${_test_runner_custom_opts[@]:-} -- "${@}"

    for custom_opt in ${_test_runner_custom_opts[@]:-}; do
        local custom_opt_name="${custom_opt//:}"

        if [ "${opts[$custom_opt_name]:-}" ]; then
            test-runner:handle-custom-opt "$custom_opt_name" \
                "${opts[$custom_opt_name]}"
        fi
    done

    local run_flags=()

    if [ "${opts[-h]:-}" -o "${opts[--help]:-}" ]; then
        run_flags=(-v)
    elif [ "${opts[-O]:-}" ]; then
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
    (
        import:source github.com/reconquest/tests.sh

        tests:progress() {
            test-runner:progress "${@}"
        }


        if [ "${opts[-v]:-}" ]; then
            tests:set-verbose "${opts[-v]}"
        fi

        tests:main \
            -a \
            -d "$_test_runner_testcases_dir" \
            -s "$_test_runner_local_setup" \
            -t "$_test_runner_local_teardown" \
            "${run_flags[@]}"
    )
}
