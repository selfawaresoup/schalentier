#!/usr/bin/env bash

function context {
  echo "Failing example"
}

function test_path_variable {
  # test relies on $PATH to be set to a typical user path
  # but because of the clean child process runner,
  # it can't read the user's env variables
  assert_string_contains $PATH "~"
}
