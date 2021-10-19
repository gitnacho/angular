# Vendedor *yarn*
Utilizamos la configuración `yarn-path` de *Yarn* en un archivo `.yarnrc` compartido para hacer cumplir
que todos usen la misma versión de *Yarn*.  *Yarn* comprueba el archivo `.yarnrc` para
determinar si `yarn` debe delegar el comando a una versión `vendored` en la
ruta proporcionada.

## Como actualizar
Para actualizar a la última versión de *Yarn* como nuestra versión `vendored`:
- Ejecuta este comando
```sh
yarn policies set-version latest
```
- Elimina la versión anterior
