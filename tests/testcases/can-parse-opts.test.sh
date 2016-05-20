arg1=false
test-runner:handle-opts() {
    case "$1" in
        --arg1)
            arg1=true
            ;;

        --arg2)
            tests:assert-equals "$2" 3
            ;;
        *)
            tests:fail
            ;;
    esac
}

tests:put tests/setup.sh </dev/null
tests:put tests/testcases/noop.test.sh </dev/null

test-runner:set-custom-opts --arg1 --arg2:

exit() {
    tests:debug "EXIT $1"
}

if test-runner:run --arg1 --arg2 3 2>&1 > >(_tests_indent 'test-runner'); then
    tests:assert-equals "$arg1" "true"
else
    tests:fail
fi

