#!/usr/bin/env bash

NL=$'\n' # newline character for convenience

# basic equality assertion
# returns 0 if both arguments are equal
# arguments:
#  - actual value
#  - expected value
function assert_equal () {
  local EXPECTED=$1
  local ACTUAL=$2

  [[ $ACTUAL = $EXPECTED ]] && return 0 # assertion success

  printf "Assertion failed \nEXPECTED value \n\n%3s \n\ndid not equal ACTUAL value\n\n%s \n\n" $EXPECTED $ACTUAL
  return 1
}

# basic inequality assertion
# returns 0 if both arguments are NOT equal
# arguments:
#  - actual value
#  - expected value
function assert_not_equal () {
  local EXPECTED=$1
  local ACTUAL=$2

  [[ $ACTUAL != $EXPECTED ]] && return 0 # assertion success

  printf "Assertion failed \nEXPECTED value \n\n%3s \n\ndid equal ACTUAL value\n\n%3s \n\n" $EXPECTED $ACTUAL
  return 1
}

# assertion of substrings
# return 0 if $1 is contained in $2
assert_string_contains() {
  local EXPECTED=$1
  local ACTUAL=$2

  [[ ${ACTUAL} == *"${EXPECTED}"* ]] && return 0
  
  printf "Assertion failed \nEXPECTED value \n\n%s \n\ndid not contain ACTUAL value\n\n%s \n\n" $EXPECTED $ACTUAL
  return 1
}

# the actual runner
# executes functions from the test file in the following order if found:
#   - context
#   - setup
#   - for each fundtion named "test_":
#     - before_each
#     - test_...
#     - after_each
#   - teardown
# will terminate on failure and return the exit code of the failed funciton
# returns 0 if everything runs successuflly
function execute_tests () {
  local FUNCTIONS=$(declare -F | cut -f3 -d" " | grep "^test_")

  if [[ $(type -t context) == function ]]; then
    CONTEXT=$(context)
    CONTEXT+=" - "
  else
    CONTEXT=""
  fi

  [[ $(type -t setup) == function ]] && setup

  for F in $FUNCTIONS; do
    echo -n "${CONTEXT}${F} ... "
    $F && echo "OK"
  done

  [[ $(type -t teardown) == function ]] && teardown
}

# loads the test file $1
# injects the runner code
# executes the test script in a clean child process (no env, no user config)
# return the exit code of the test script
function run_test_file () {
  local RUNNER=""
  for F in 'assert_equal' 'assert_not_equal' 'assert_string_contains' 'execute_tests'; do
    RUNNER+="function "
    RUNNER+=$(declare -f $F)
    RUNNER+=${NL}
  done
  RUNNER="$RUNNER source $1 $NL"
  RUNNER="$RUNNER execute_tests"
  # echo "$RUNNER $NL $NL" # printing the runner script fro debugging only
  env -i bash --noprofile --norc <<< "$RUNNER"
}

TEST_FILE=$1

run_test_file $TEST_FILE
