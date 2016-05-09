tests:not tests:ensure test-runner:run 1 2 3
tests:assert-stdout 'no testcases found'

_args=()
test-runner:handle-args() {
    _args="${@}"
}

tests:put tests/local-setup.sh </dev/null
tests:put tests/testcases/noop.test.sh </dev/null

if test-runner:run 1 2 3 2>&1 > >(_tests_indent 'test-runner'); then
    tests:fail
else
    tests:assert-equals "${#_args[@]}" "3"
    tests:assert-equals "${_args[@]}" "1 2 3"
fi

