tests:put tests/testcases/first-test.test.sh <<EOF
tests:ensure true
EOF

tests:put tests/testcases/second-test.test.sh <<EOF
tests:ensure true
EOF

tests:ensure test-runner:run -O first
tests:not tests:assert-stdout 'second'
tests:not tests:assert-stdout '2 tests'
