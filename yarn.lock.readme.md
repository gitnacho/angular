Todas nuestras dependencias `npm` están bloqueadas a través del archivo `yarn.lock` por las siguientes razones:

- nuestro proyecto tiene muchas dependencias que se actualizan en momentos impredecibles, por lo que es importante que
  las actualizamos explícitamente de vez en cuando en lugar de implícitamente cuando cualquiera de nosotros ejecuta `yarn install`
- las dependencias bloqueadas nos permiten reutilizar la caché de `yarn` en *CircleCI*, lo cual acelera significativamente nuestras compilaciones
  (por 5 minutos o más)
- las dependencias bloqueadas nos permiten detectar cuándo el directorio `node_modules` está desactualizado después de un cambio de rama
  lo que nos permite construir el proyecto con las dependencias correctas cada vez

Antes de cambiar una dependencia, haz lo siguiente:

- asegúrate de estar sincronizado con `upstream/master`: `git fetch upstream && git rebase upstream/master`
- asegúrate de que tu directorio `node_modules` no esté obsoleto ejecutando `yarn install`


Para agregar una nueva dependencia, haz lo siguiente: `yarn add <packagename> --dev`

Para actualizar una dependencia existente, haz lo siguiente: run `yarn upgrade <packagename>@<version|latest> --dev`
o `yarn upgrade <packagename> --dev` para actualizar a la última versión que coincida con la restricción de la versión
en `package.json`

Para eliminar una dependencia existente, haz lo siguiente: run `yarn remove <packagename>`


Una vez que hayas cambiado la dependencia, confirma los cambios en `package.json` y `yarn.lock`, y listo.