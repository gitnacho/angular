# Angular Compatibility Compiler (ngcc)

This compiler will convert `node_modules` compiled with `ngc`, into `node_modules` which
appear to have been compiled with `ngtsc`.

This conversion will allow such "legacy" packages to be used by the Ivy rendering engine.

## Compilación

The project is built using Bazel:

```bash
yarn bazel build //packages/compiler-cli/ngcc
```

## Pruebas unitarias

Las pruebas unitarias se crean y ejecutan utilizando *Bazel*:

```bash
yarn bazel test //packages/compiler-cli/ngcc/test
```

## Integration Testing

There are tests that check the behavior of the overall executable:

```bash
yarn bazel test //packages/compiler-cli/ngcc/test:integration
```
