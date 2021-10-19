# Descripción general ⏤ Códigos de estado *HTTP*


Esta es una lista de todos los posibles códigos de estado *HTTP* devueltos por los servidores `nginx` y de vista previa,
junto con una breve explicación de lo que significan:


## `http://*.ngbuilds.io/*`

- **307 (redireccionamiento temporal)**:
  Todas las solicitudes que no son *HTTPS*. 308 (redireccionamiento permanente) sería más apropiado, pero no es compatible
  por todos los agentes (por ejemplo, *cURL*).


## `https://pr<pr>-<sha>.ngbuilds.io/*`

- **200 (OK)**:
  Se encontró el archivo o la *URL* se reescribió a `/index.html` (es decir, todas las rutas que no tienen `.` en el
  segmento final).

- **403 (Prohibido)**:
  Intentando acceder a un subdirectorio.

- **404 No encontrado)**:
  File not found.


## `https://ngbuilds.io/can-have-public-preview/<pr>`

- **200 (OK)**:
  Whether the PR can have a public preview (based on its author, label, changed files).
  _Response type:_ JSON
  _Response format:_
  ```ts
  {
    canHavePublicPreview: boolean,
    razon: string | null,
  }
  ```

- **405 (Method Not Allowed)**:
  Request method other than GET.


## `https://ngbuilds.io/circle-build`

- **201 (Created)**:
  Build deployed successfully and is publicly available.

- **202 (Accepted)**:
  Build not automatically verifiable. Stored for later deployment (after re-verification).

- **204 (No Content)**:
  Build was not successful, so no further action is being taken.

- **400 (Bad Request)**:
  Invalid payload.

- **403 (Prohibido)**:
  Unable to talk to 3rd-party APIs.

- **405 (Method Not Allowed)**:
  Request method other than POST.

- **409 (Conflict)**:
  Request to overwrite existing (public or non-public) directory (e.g. deploy existing build or
  change PR visibility when the destination directory does already exist).


## `https://ngbuilds.io/health-check`

- **200 (OK)**:
  The server is healthy (i.e. up and running and processing requests).


## `https://ngbuilds.io/pr-updated`

- **200 (OK)**:
  Request processed successfully. Processing may or may not have resulted in further actions.

- **400 (Bad Request)**:
  No payload or no `number` field in payload.

- **405 (Method Not Allowed)**:
  Request method other than POST.

- **409 (Conflict)**:
  Request to overwrite existing (public or non-public) directory (i.e. directories for both
  visibilities exist).
  (Normally, this should not happen.)


## `https://*.ngbuilds.io/*`

- **404 No encontrado)**:
  Request not matched by the above rules.

- **500 (Internal Server Error)**:
  Error while processing a request matched by the above rules.
