tests:not tests:ensure test-runner:run 1 2 3
tests:assert-stdout 'no testcases found'

_args=()
test-runner:handle-args() {
    _args=("${@}")
}

tests:put tests/setup.sh </dev/null
tests:put tests/testcases/noop.test.sh </dev/null

test-runner:run 1 2 3 2>&1 > >(_tests_indent 'test-runner')
tests:assert-equals "${#_args[@]}" "4"
tests:assert-equals "${_args[*]}" "./run_tests.sh 1 2 3"
