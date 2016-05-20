tests:put tests/testcases/first-test.test.sh <<EOF
tests:ensure true
EOF

tests:put tests/testcases/second-test.test.sh <<EOF
tests:ensure true
EOF

tests:ensure test-runner:run -O second
tests:assert-stderr 'second'
tests:not tests:assert-stderr 'first'

tests:not tests:assert-stderr '2 tests'
