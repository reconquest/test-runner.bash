tests:put tests/testcases/setup.test.sh <<EOF
printf "\$defined_in_setup\n"
EOF

tests:ensure test-runner:run -O setup
tests:assert-stderr 'in setup'
