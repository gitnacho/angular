# How to run the benchmarks locally

## Run in the browser

```bash
yarn bazel run modules/benchmarks/src/tree/{name}:devserver

# e.g. "ng2" tree benchmark:
yarn bazel run modules/benchmarks/src/tree/ng2:devserver
```

## Run e2e tests

```
# Run e2e tests of individual applications:
yarn bazel test modules/benchmarks/src/tree/ng2/...

# Run all e2e tests:
yarn bazel test modules/benchmarks/...
```

## Use of *_aot.ts files

Los archivos `*_aot.ts` se utilizan como puntos de entrada dentro de *Google* para ejecutar el punto de referencia
`tests`. Estos todavía se construyen como parte de la regla correspondiente `ng_module`.

## Specifying benchmark options

There are options that can be specified in order to control how a given benchmark target
runs. The following options can be set through [test environment variables](https://docs.bazel.build/versions/master/command-line-reference.html#flag--test_env):

* `PERF_SAMPLE_SIZE` ⏤ Benchpress performs measurements until `scriptTime` predictively no longer
  decreases. It does this by using a simple linear regression with the amount of samples specified.
  Defaults to `20` samples.
* `PERF_FORCE_GC` ⏤ If set to `true`, `@angular/benchpress` will run run the garbage collector
  before and after performing measurements. Benchpress will measure and report the garbage
  collection time.
* `PERF_DRYRUN` ⏤ If set to `true`, no results are printed and stored in a `json` file. Also
  benchpress only performs a single measurement (unlike with the simple linear regression).
  
Here is an example command that sets the `PERF_DRYRUN` option:

```bash
yarn bazel test modules/benchmarks/src/tree/baseline:perf --test_env=PERF_DRYRUN=true
```