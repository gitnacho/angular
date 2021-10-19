# Descripción general ⏤ General


## Objetivo
Siempre que se ejecuta un trabajo solicitud de extracción en la infraestructura de *CI* (por ejemplo, `CircleCI`), queremos construir `angular.io`
y alojar los artefactos de compilación en un servidor de acceso público para que los colaboradores (desarrolladores,
diseñadores, autores, etc.) pueden obtener una vista previa de los cambios sin tener que pagar y compilar la aplicación
localmente.


## Código fuente
Para facilitar la administración del servidor y el control de versiones de la configuración, estamos usando
[`docker`](https://www.docker.com) para ejecutar un contenedor en una *VM*. El `Dockerfile` y todos los demás archivos
necesarios para crear el contenedor de la ventana acoplable se almacenan (y versionan) junto con el archivo `angular.io`
código fuente del proyecto (actualmente parte del repositorio `angular/angular`) en el directorio `aio-builds-setup/`
.


## Configuración
La *VM* está alojada en [*Google Compute Engine*](https://cloud.google.com/compute/). El sistema operativo del *host* es
`debian:jessie`. Para obtener más información sobre cómo configurar la *VM host*, consulta la sección "Configuración de la VM"
en [*TOC*](_TOC.md).


## Modelo de seguridad
Dado que estamos gestionando un servidor público, es importante tomar las medidas adecuadas para
prevenir el abuso. Para obtener más detalles sobre los desafíos y el enfoque elegido, echa un vistazo al
[modelo de seguridad](overview--security-model.md)


## La vista de 10000 pies
Esta sección ofrece un breve resumen de las diversas operaciones realizadas en *CI* y por la ventana contenedora
acoplable:


### En *CI* (`CircleCI`)
- El script *CI* crea el proyecto `angular.io`.
- El script se *CI* hace un `gzip` y almacena los artefactos de compilación en la infraestructura de *CI*.
- Cuando se completa la compilación, `CircleCI` activa un `webhook` en el servidor de vista previa.

Puedes encontrar más información sobre cómo configurar las cosas en *CI* [aquí](misc--integrate-with-ci.md).


### Alojamiento de artefactos de compilación
- `nginx` recibe el disparador del `webhook` y lo pasa al servidor de vista previa.
- El servidor de vista previa ejecuta varias comprobaciones preliminares para determinar si la solicitud es válida y
  si la *SE* correspondiente puede tener una vista previa (pública o no pública) (se pueden encontrar más detalles
  [aquí](overview--security-model.md)).
- El servidor de vista previa solicita a `CircleCI` la *URL* de los artefactos de compilación *AIO*.
- El servidor de vista previa realiza una solicitud a esta *URL* para recibir el artefacto ⏤ fallando si el tamaño
  excede el tamaño máximo de archivo especificado ⏤ y lo almacena en una ubicación temporal.
- El servidor de vista previa ejecuta más comprobaciones para determinar si la vista previa debe ser de acceso público.
  o almacenada para verificación posterior (se pueden encontrar más detalles [aquí](overview--security-model.md)).
- El servidor de vista previa cambia la "visibilidad" del *SE* asociado, si es necesario. Por ejemplo, si
  Las compilaciones para la misma *SE* se habían implementado previamente como no públicas y la compilación actual se ha
  verificado automáticamente, todas las compilaciones anteriores también se hacen públicas.
  Si la *SE* pasa de "non-public" a "public", el servidor de vista previa publica un comentario en la
  *SE* correspondiente en *GitHub* mencionando los *SHA* y los enlaces donde se pueden encontrar las vistas previas.
- El servidor de vista previa verifica que no está intentando sobrescribir una compilación existente.
- El servidor de vista previa despliega los artefactos en un subdirectorio con el nombre del número *SE* y los
  primeros caracteres del *SHA*: `<SE>/<SHA>/`
  (Las *SE* no accesibles al público se almacenarán en una ubicación diferente, pero nuevamente se derivarán de la *SE*
  número y *SHA*.)
- Si la *SE* es de acceso público, el servidor de vista previa publica un comentario sobre la *SE* correspondiente en
  *GitHub* menciona el *SHA* y el enlace donde se puede encontrar la vista previa.

Puedes encontrar más información sobre los posibles códigos de estado *HTTP* y su significado
[aquí](overview--http-status-codes.md).


### Actualizar la visibilidad de las solicitudes de extracción
- `nginx` recibe una notificación de que se ha actualizado una *SE* y la pasa al
  servidor de vista previa. Esta podría, por ejemplo, ser enviada por un `webhook` de *GitHub* cada vez que las etiquetas de una *SE*
  cambie.
  P. ej.: `ngbuilds.io/pr-updated` (payload: `{"number":<PR>,"action":"labeled"}`)
- La solicitud contiene el número de *SE* (como `number`) y, opcionalmente, la acción que desencadenó la
  solicitud (como `action`) en la carga útil.
- El servidor de vista previa verifica la carga útil y determina si la `action` (si se especifica) podría
  haber llevado a cambios en la visibilidad de las solicitudes de extracción. Únicamente solicitudes que omiten el campo `action` por completo o
  especifican una acción que puede afectar la visibilidad se procesan más.
  (Actualmente, las únicas acciones que se consideran capaces de afectar la visibilidad son `labeled` y
  `unlabeled`.)
- El servidor de vista previa vuelve a verificar y, si es necesario, actualiza la visibilidad de la *SE*.

Puedes encontrar más información sobre los posibles códigos de estado *HTTP* y su significado
[aquí](overview--http-status-codes.md).


### Sirviendo artefactos de construcción
- `nginx` recibe una solicitud de un recurso de vista previa alojado en un subdominio correspondiente a la *SE* y *SHA*.
  P. ej.: `pr<PR>-<SHA>.ngbuilds.io/path/to/resource`
- `nginx` asigna el subdominio al subdirectorio correcto y sirve el recurso.
  P. ej.: `/<PR>/<SHA>/ruta/al/recurso`

Puedes encontrar más información sobre los posibles códigos de estado *HTTP* y su significado
[aquí](overview--http-status-codes.md).


### Eliminar artefactos obsoletos
Para evitar inundar el disco con artefactos de compilación innecesarios, hay un `cronjob` que ejecuta una
tarea de limpieza una vez al día. La tarea recupera todas las *SE* abiertas de *GitHub* y elimina todos los directorios
que no corresponden a una *SE* abierta.


### Chequeo de salud
El servicio *Docker* ejecuta una comprobación de estado periódica que verifica las condiciones de ejecución del
contenedor. Esto incluye verificar el estado de servicios específicos del sistema, la capacidad de respuesta de
`nginx`, el servidor de vista previa y la conectividad a Internet.
