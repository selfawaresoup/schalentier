# Schalentier

A testing framwork (almost) nobody asked for.

> **Schalentier, german**
> 
> `[ˈʃaːləntiːɐ̯]`
> 
> : shellfish

Schalentier enables shell scripts to be unit tested with convenient features like `setup` and `teardown` functions.

It also runs every test suite in a separete child process that can't read from or write to the user's environment variables and doesn't leave any function definitions or variables behind in the shell from which it was launched.

## Usage

Example passing tests that leave nothing behind in the user's shell:

```sh
./schalentier examples/good_tests.sh
```

A test that fails due to test isolation:

```sh
./schalentier examples/bad_tests.sh
```
