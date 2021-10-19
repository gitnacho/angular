# Misceláneo ⏤ Depurar el contenedor `docker`


TODO (gkalpak): Agrega documentos. Mencionar:
- `aio-health-check`
- `aio-verify-setup`
- Prueba `nginx` accesible en:
  - `http://$TEST_AIO_NGINX_HOSTNAME:$TEST_AIO_NGINX_PORT_HTTP`
  - `https://$TEST_AIO_NGINX_HOSTNAME:$TEST_AIO_NGINX_PORT_HTTPS`
- Prueba el servidor de vista previa accesible en:
  - `http://$TEST_AIO_PREVIEW_SERVER_HOSTNAME:$TEST_AIO_PREVIEW_SERVER_PORT`
- El *DNS* local (a través de `dnsmasq`) asigna los nombres de `host` anteriores a 127.0.0.1


## Desarrollar los archivos *TypeScript* del servidor de vista previa

Si estás ejecutando `Docker` en *OS*/*X*, te puedes beneficiar de vincular el archivo *TypeScript* integrado
(es decir, `script-js/dist`) a los archivos *JavaScript* dentro del contenedor `Docker`.

Primero comienza a ver y compilar los archivos de *TypeScript* (en el *host*):

```bash
yarn build-watch
```

Ahora compila, inicia y adjunta al contenedor `Docker`. Consulta la sección "Configuración de la máquina virtual".
en [*TOC*](_TOC.md). Luego, vincula los directorios de *JavaScript* (en el contenedor):

```bash
aio-dev-mode
```

Ahora, cada vez que realices cambios en *TypeScript*, se creará automáticamente
en el *host* y los cambios están disponibles automáticamente en el contenedor.
Luego puedes ejecutar las pruebas unitarias (en el contenedor):

```bash
aio-verify-setup
```

A veces, los errores en el registro de la prueba unitaria no son suficientes para indicarte qué salió mal.
En ese caso, también puedes consultar el registro del servidor de vista previa.
Un script auxiliar que ejecuta las pruebas unitarias (es decir, `aio-verify-setup`) y muestra el
último registro relevante del servidor `test-preview-server` es:

```bash
aio-verify-setup-and-log
```
