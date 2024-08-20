# basic-cli

A Roc [platform](https://github.com/roc-lang/roc/wiki/Roc-concepts-explained#platform) to work with files, commands, HTTP, TCP, command line arguments,...

:eyes: **examples**:
  - [0.12.x](https://github.com/roc-lang/basic-cli/tree/0.12.0/examples)
  - [0.11.x](https://github.com/roc-lang/basic-cli/tree/0.11.0/examples)
  - [0.10.x](https://github.com/roc-lang/basic-cli/tree/0.10.0/examples)
  - [latest main branch](https://github.com/roc-lang/basic-cli/tree/main/examples)

:book: **documentation**:
  - [0.12.x](https://www.roc-lang.org/packages/basic-cli/0.12.0)
  - [0.11.x](https://www.roc-lang.org/packages/basic-cli/0.11.0)
  - [0.10.x](https://www.roc-lang.org/packages/basic-cli/0.10.0)
  - [latest main branch](https://www.roc-lang.org/packages/basic-cli)

## Running locally

If you clone this repo instead of using the release URL you'll need to build the platform once:
```sh
roc build.roc
```
Then you can run like usual:
```sh
$ roc --prebuilt-platform examples/hello-world.roc
Hello, World!
```
