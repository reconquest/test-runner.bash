Test Runner for [tests.sh](https://github.com/reconquest/tests.sh).

# Usage

## Using [import.bash](https://github.com/reconquest/import.bash)

Put following into `run_tests.sh`:

```bash
import github.com/reconquest/test-runner.bash

test-runner:run "${@}"
```

By default, it expects local setup script to be found in
`tests/local-setup.sh`. That path can be changed by
`test-runner:set-local-setup()`.

Run all testcases:

```
./run_tests.sh  # or
./run_tests.sh -A
```

Run last failed testcase:

```
./run_tests.sh -O
```

Run testcase by mask:

```
./run_tests.sh -O <part-of-filename>
```

## Advanced usage

### Parsing custom command line args

```bash
import github.com/reconquest/test-runner.bash

test-runner:handle-custom-opt() {
    local opt_name=$1
    local opt_value=$2

    # code goes here
}

test-runner:set-custom-opts -o --opt --with-value: -w: --value-not-required::

test-runner:run "${@}"
```

### Parsing custom command line args

```bash
import github.com/reconquest/test-runner.bash

test-runner:handle-args() {
    local args="${@}"

    # code goes here
}

test-runner:run "${@}"
```
