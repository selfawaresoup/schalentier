#!/usr/bin/env bash

function context {
  echo "Just some tests"
}

function setup {
  # This test defines a global variable and a function
  # both will not exist in the shell that's running the test suite
  AAA="AAA"

  function BBB () {
    echo "BBB"
  }
}

function test_global_variable {
  assert_equal $AAA "AAA"
}

function test_helper_function {
  assert_equal $(BBB) "BBB"
}

function test_shell_level {
  assert_not_equal $SHLVL 0 # asserts the the test runner shell is NOT a top level shell
}

function teardown {
  ANOTHER_VARIABLE="Just leaving some trash behind in global scope"
}
