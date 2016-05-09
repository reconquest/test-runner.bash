tests:put tests/testcases/first-test.test.sh <<EOF
tests:ensure true
EOF

tests:put tests/testcases/second-test.test.sh <<EOF
tests:ensure true
EOF

tests:ensure test-runner:run
tests:assert-stdout '2 tests'
