# Configuración de imagen ⏤ Variables de entorno


A continuación se muestra una lista de variables de entorno que se pueden configurar al crear la imagen del `docker` (como
se describe [aquí](vm-setup--create-docker-image.md)). Una lista actualizada de las variables
de entorno configurables y sus valores predeterminados se pueden encontrar en
[*Dockerfile*](../dockerbuild/Dockerfile).

**Nota**:
Cada variable tiene una contraparte con el prefijo `TEST_`, que se utiliza con fines de prueba. En la mayoría de los casos
no es necesario especificar valores para esos.

- `AIO_ARTIFACT_PATH`:
  La ruta utilizada para identificar el artefacto de compilación *AIO* en los servidores *CircleCI*. Esto debería ser igual a
  la ruta dada en el archivo `.circleci/config.yml` para la clave
  `aio_preview->steps->store_artifacts->destination`.

- `AIO_BUILDS_DIR`:
  El directorio (dentro del contenedor) donde se guardan los artefactos de compilación alojados.

- `AIO_DOMAIN_NAME`:
  El nombre de dominio del servidor.

- `AIO_GITHUB_ORGANIZATION`:
  La organización de *GitHub* en cuyos equipos se confía para aceptar artefactos de compilación.
  Consulta también `AIO_GITHUB_TEAM_SLUGS`.

- `AIO_GITHUB_REPO`:
  El repositorio de *Github* para el que se alojarán las *SE*.

- `AIO_GITHUB_TEAM_SLUGS`:
  Una lista de equipos separados por comas, cuyos autores pueden obtener una vista previa de las *SE*.
  Consulta también `AIO_GITHUB_ORGANIZATION`.

- `AIO_NGINX_HOSTNAME`:
  El nombre del alojamiento interno para acceder al servidor `nginx` Esto se usa principalmente para realizar un
  chequeo de salud periódico.

- `AIO_NGINX_PORT_HTTP`:
  El número de puerto en el que `nginx` escucha las conexiones *HTTP*. Esto se debe asignar al
  puerto correspondiente en el alojamiento de la *VM* (como se describe [aquí](vm-setup--start-docker-container.md)).

- `AIO_NGINX_PORT_HTTPS`:
  El número de puerto en el que `nginx` escucha las conexiones *HTTPS*. Esto se debe asignar al
  puerto correspondiente en el alojamiento de la *VM* (como se describe [aquí](vm-setup--start-docker-container.md)).

- `AIO_SIGNIFICANT_FILES_PATTERN`:
  La expresión regular que determina si un archivo modificado indica que una nueva vista previa
  se debe desplegar. Por ejemplo, si hay un archivo modificado en el directorio `/packages` entonces
  Es posible que algunos de los documentos de la *API* hayan cambiado, por lo que debemos crear una nueva vista previa.

- `AIO_TRUSTED_PR_LABEL`:
  La *SE* cuya presencia indica que la *SE* ha sido verificada manualmente y se le permite seguir
  construyendo artefactos servidos públicamente. Esto es útil para habilitar vistas previas para cualquier *SE* (no solo aquellos
  de autores de confianza).

- `AIO_PREVIEW_SERVER_HOSTNAME`:
  El nombre del *host* interno para acceder al servidor de vista previa de *Node.js*. Esto lo utiliza `nginx` para
  delegar solicitudes de `web-hook` y también para realizar una verificación de estado periódica.

- `AIO_ARTIFACT_MAX_SIZE`:
  El tamaño máximo permitido para el archivo `gzip` que contiene los artefactos de compilación.
  Los archivos más grandes que esto serán rechazados.

- `AIO_PREVIEW_SERVER_PORT`:
  El número de puerto en el que el servidor de vista previa de *Node.js* escucha las conexiones *HTTP*. Esto lo usa
  `nginx` para delegar solicitudes de `web-hook` y también para realizar una verificación de estado periódica.
