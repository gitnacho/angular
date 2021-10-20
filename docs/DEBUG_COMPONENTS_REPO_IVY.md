# Debugging the `components-repo-unit-tests` job

Currently all changes to Ivy are validated against the test suite of the
`angular/components` repository. In order to debug the `components-repo-unit-tests` CI
job, the following steps can be used:

1\) Build the Ivy package output by running `node ./scripts/build/build-packages-dist.js` in
the `angular/angular` repo.

2\) Clone the `angular/components` repository if not done yet ([quick link to repo](https://github.com/angular/components)).

3\) Set up the package output in the `angular/components` repository by running the following
command in the `angular/angular` repo:

```bash
node ./scripts/ci/update-framework-deps-to-dist-packages.js {COMPONENTS_REPO}/package.json ./dist/packages-dist
```

4\) Switch into the `angular/components` repository and run the tests by using the
following command:

```bash
yarn test --deleted_packages=//src/dev-app
```

### Ejecución de pruebas para puntos de entrada individuales

El script `yarn test` del repositorio `components` ejecuta todas las pruebas del proyecto.
A veces, esto no se desea porque implica la construcción y prueba de todos los paquetes
y puntos de entrada. Es posible ejecutar pruebas para un punto de entrada individual mediante
selección explícita un objetivo de prueba dado.

A continuación, se muestra un ejemplo de comandos que ejecutan objetivos de prueba individuales. Ten en cuenta que es
**importante** especificar el indicador `--config=ivy` para ejecutar pruebas con `Ivy`.

```bash
yarn bazel test --config=ivy src/material/slider:unit_tests
yarn bazel test --config=ivy src/cdk/a11y:unit_tests
yarn bazel test --config=ivy src/material/toolbar:unit_tests
```
