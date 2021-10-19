Esta es la aplicación *Angular Phonecat* ajustada para adaptarse a la estructura de nuestro proyecto
modelo.

Se aplican los siguientes cambios del `Phonecat` estándar:

* Las pruebas *E2E* se han movido al directorio principal, donde `run-e2e-tests` los puedes
  descubrir y ejecutar junto con todos los demás ejemplos.
* La mayor parte del *JSON* del teléfono y los datos de imagen eliminados con el fin de mantener
  bajo el peso del repositorio. Mantener lo suficiente para conservar la capacidad de prueba de la aplicación.

## Ejecutar la aplicación

Empieza como cualquier ejemplo

    npm run start

## Ejecutar pruebas *E2E*

Como para cualquier ejemplo (en la raíz del proyecto):

    gulp run-e2e-tests --filter=phonecat-3
