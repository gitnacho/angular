Esta es la aplicación *Angular Phonecat* ajustada para adaptarse a la estructura de nuestro proyecto
modelo.

Se aplican los siguientes cambios del `Phonecat` estándar:

* The TypeScript config file shown in the guide is `tsconfig.ajs.json` instead
  of the default, because we don't want to enable `noImplicitAny` for migration.
* La configuración de `karma` para las pruebas unitarias está en `karma.conf.ajs.js` porque el modelo estándar
  La configuración de *Karma* no es compatible con la forma en que se deben ejecutar las pruebas de *AngularJS*.
  El script del intérprete `run-unit-tests.sh` se puede utilizar para ejecutar las pruebas unitarias.
* En lugar de usar *Bower*, *AngularJS* y sus dependencias se obtienen de un *CDN*
  en `index.html` y `karma.conf.ajs.js`.
* E2E tests have been moved to the parent directory, where `gulp run-e2e-tests` can
  descubrir y ejecutar junto con todos los demás ejemplos.
* La mayor parte del *JSON* del teléfono y los datos de imagen eliminados con el fin de mantener
  bajo el peso del repositorio. Mantener lo suficiente para conservar la capacidad de prueba de la aplicación.

## Ejecutar la aplicación

Empieza como cualquier ejemplo

    npm run start

You'll find the app under the /app path: http://localhost:3002/app/index.html

## Ejecutar las pruebas unitarias

    ./run-unit-tests.sh

## Ejecutar pruebas *E2E*

Como para cualquier ejemplo (en la raíz del proyecto):

    gulp run-e2e-tests --filter=phonecat-1
