tests:put tests/testcases/teardown.test.sh <<EOF
# empty
EOF

tests:ensure test-runner:run -O teardown
tests:assert-stderr 'in teardown'
