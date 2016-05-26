tests:make-tmp-dir -p tests/testcases

tests:put tests/setup.sh <<TEARDOWN
defined_in_setup="in setup"
TEARDOWN

tests:put tests/teardown.sh <<TEARDOWN
printf "in teardown\n"
TEARDOWN
