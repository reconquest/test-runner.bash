tests:clone -r vendor .
tests:clone -r test-runner.bash .

tests:make-tmp-dir -p tests/testcases
tests:ensure touch tests/local-setup.sh
