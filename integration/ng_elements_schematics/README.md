# Angular Elements Schematics Tests

This directory is an integration test for `@angular/elements` schematics. To ensure
that the elements schematics do work and leave the application in a working state.

To use the tests:
- Usa `yarn install` para instalar todas las dependencias en este directorio y en el directorio raíz del repositorio *Angular*
    .
- Build an Angular distribution with `yarn build-dist`. This needs to be done after changes to
    Angular, but not after changes to integration tests. This is an expensive build.
- In this directory, run the integration tests with `yarn test`.