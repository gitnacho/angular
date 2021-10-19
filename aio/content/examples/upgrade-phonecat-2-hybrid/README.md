Esta es la aplicación *Angular Phonecat* ajustada para adaptarse a la estructura de nuestro proyecto
modelo.

Se aplican los siguientes cambios del `Phonecat` estándar:

* La configuración de `karma` para las pruebas unitarias está en `karma.conf.ajs.js` porque el modelo estándar
  La configuración de *Karma* no es compatible con la forma en que se deben ejecutar las pruebas de *AngularJS*.
  El script del intérprete `run-unit-tests.sh` se puede utilizar para ejecutar las pruebas unitarias.
* También para el *shim* de *Karma*, hay un archivo `karma-test-shim.1.js` que no
  se utiliza, pero se muestra en el apéndice de la prueba.
* En lugar de usar *Bower*, *AngularJS* y sus dependencias se obtienen de un *CDN*
  en `index.html` y `karma.conf.ajs.js`.
* Las pruebas *E2E* se han movido al directorio principal, donde `run-e2e-tests` los puedes
  descubrir y ejecutar junto con todos los demás ejemplos.
* La mayor parte del *JSON* del teléfono y los datos de imagen eliminados con el fin de mantener
  bajo el peso del repositorio. Mantener lo suficiente para conservar la capacidad de prueba de la aplicación.

## Ejecutar la aplicación

Empieza como cualquier ejemplo

    npm run start

## Ejecutar las pruebas unitarias

    ./run-unit-tests.sh

## Ejecutar pruebas *E2E*

Como para cualquier ejemplo (en la raíz del proyecto):

    gulp run-e2e-tests --filter=phonecat-2
