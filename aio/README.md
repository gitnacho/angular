# Proyecto de documentación *Angular* (https://angular.io)

Todo en este directorio es parte del proyecto de documentación. Esto incluye

* el sitio web para mostrar la documentación
* la configuración de `dgeni` para convertir los archivos fuente en archivos renderizados que se pueden ver en el sitio web.
* las herramientas para establecer ejemplos para el desarrollo; y generar archivos `zip` y de ejemplo en vivo a partir de los ejemplos.

<a name="tareas-del-desarrollador"></a>
## Tareas del desarrollador

Usamos [`Yarn`](https://yarnpkg.com) para administrar las dependencias y ejecutar tareas de compilación.
Debes ejecutar todas estas tareas desde el directorio `angular/aio`.
Estas son las tareas más importantes que necesitas utilizar:

* `yarn` ⏤ instala todas las dependencias.
* `yarn setup` ⏤ instala todas las dependencias, `boilerplate`, `stackblitz`, `zips` y ejecuta `dgeni` en los documentos.
* `yarn setup-local` ⏤ Igual que `setup`, pero compila los paquetes *Angular* a partir del código fuente y usa estas versiones construidas localmente (en lugar de las obtenidas de `npm`) para los ejemplos repetitivos de `aio` y `docs`.

* `yarn build` ⏤ crea una compilación de producción de la aplicación (después de instalar dependencias, plantilla, etc.).
* `yarn build-local` ⏤ igual que `build`, pero usa `setup-local` en lugar de `setup`.
* `yarn start` ⏤ ejecuta un servidor web de desarrollo que observa los archivos; luego crea el visor de documentos y vuelve a cargar la página, según sea necesario.
* `yarn serve-and-sync` ⏤ ejecuta `docs-watch` y `start` en la misma consola.
* `yarn lint` ⏤ comprueba que el código del visor de documentos sigue nuestras reglas de estilo.
* `yarn test` ⏤ observa todos los archivos fuente, para el visor de documentos, y ejecuta todas las pruebas unitarias cuando haya algún cambio.
* `yarn test --watch=false` ⏤ ejecuta todas las pruebas unitarias una vez.
* `yarn e2e` ⏤ ejecuta todas las pruebas `e2e` para el visor de documentos.

* `yarn docs` ⏤ genera todos los documentos a partir de los archivos fuente.
* `yarn docs-watch` ⏤ mira la fuente *Angular* y los archivos *docs* y ejecute un *doc-gen* en cortocircuito para los documentos que cambiaron.
* `yarn docs-lint` ⏤ comprueba que el código `doc gen` sigue nuestras reglas de estilo.
* `yarn docs-test` ⏤ ejecuta las pruebas unitarias para el código de generación de documentos.

* `yarn boilerplate:add` ⏤ genera todo el código repetitivo para los ejemplos, para que se puedan ejecutar localmente.
* `yarn boilerplate:remove` ⏤ elimina todo el código repetitivo que se agregó a través de `yarn boilerplate:add`.
* `yarn create-example` ⏤ crea un nuevo directorio de ejemplo que contiene los archivos fuente iniciales.

* `yarn generate-stackblitz` ⏤ genera los archivos *stackblitz* que utilizan las etiquetas `live-example` en los documentos.
* `yarn generate-zips` ⏤ genera los archivos `zip` a partir de los ejemplos. `Zip` disponible a través de las etiquetas `live-example` en los documentos.

* `yarn example-e2e` ⏤ ejecuta todas las pruebas `e2e` para obtener ejemplos. Opciones disponibles:
  - `--setup` ⏤ genera un texto estándar, fuerza la actualización del controlador web y otras configuraciones, luego ejecuta las pruebas.
  - `--local` ⏤ ejecuta pruebas `e2e` con la versión local de *Angular* contenida en el directorio `dist`.
               *Requiere `--setup` para que surta efecto*.
  - `--filter=foo` ⏤ limita las pruebas `e2e` a aquellas que contengan la palabra "foo".

> **Nota para usuarios de Windows**
>
> La configuración de los ejemplos implica la creación de algunos [enlaces simbólicos](https://en.wikipedia.org/wiki/Symbolic_link) (consulta [aquí](./tools/examples/README.md#symlinked-node_modules) para obtener más detalles) . En *Windows*, esto requiere tener el [modo de desarrollador habilitado](https://blogs.windows.com/windowsdeveloper/2016/12/02/symlinks-windows-10) (compatible con *Windows 10* o más reciente) o ejecuta los comandos de configuración como administrador.
>
> Los comandos afectados son:
> - `yarn setup` / `yarn setup-*`
> - `yarn build` / `yarn build-*`
> - `yarn boilerplate:add`
> - `yarn example-e2e --setup`

## Usar `ServiceWorker` localmente

Ejecutar `yarn start` (incluso cuando se dirige explícitamente al modo de producción) no configura el
`ServiceWorker`. Si deseas probar el `ServiceWorker` localmente, puedes usar `yarn build` y luego
servir los archivos en `dist/` con `yarn http-server dist -p 4200`.


## Guía de autoría

Hay dos tipos de contenido en la documentación:

* **Documentos de la API**: descripción de módulos, clases, interfaces, decoradores, etc., que componen la plataforma *Angular*.
Los documentos de la *API* se generan directamente a partir del código fuente.
El código fuente está contenido en archivos *TypeScript*, ubicados en el directorio `angular/packages`.
Cada elemento de la *API* puede tener un comentario anterior, el cual tiene etiquetas al estilo *JSDoc* y contenido.
El contenido está escrito en `markdown`.

* **Otro contenido**: guías, tutoriales y otro material de marketing.
El resto del contenido se escribe usando `markdown` en archivos de texto, ubicados en el directorio `angular/aio/content`.
Específicamente, hay subdirectorios que contienen tipos particulares de contenido: guías, tutoriales y marketing.

* **Código de ejemplo**: El código de los ejemplos debe ser comprobables para garantizar su exactitud.
Además, nuestros ejemplos tienen una apariencia específica y permiten al usuario copiar el código fuente. Los ejemplos
muy grandes, se representan en una interfaz con pestañas (por ejemplo, plantilla, *HTML* y *TypeScript* en
pestañas). Además, algún código de ejemplo es en vivo, el cual proporcionan enlaces a donde se pueden editar, ejecutar y/o descargar. Para obtener detalles sobre cómo trabajar con código de ejemplo, lee los [Fragmentos de código](https://angular.io/guide/docs-style-guide#fragmentos-de-codigo), [Marcado de código fuente](https://angular.io/guide/docs-style-guide#marcado-de-codigo-fuente) y las páginas de [ejemplos en vivo](https://angular.io/guide/docs-style-guide#ejemplos-en-vivo) de la [Guía de estilo para autores](https://angular.io/guide/docs-style-guide).

Usamos la herramienta [`dgeni`](https://github.com/angular/dgeni) para convertir estos archivos en documentos que se pueden ver en el visor de documentos.

La [Guía de estilo para autores](https://angular.io/guide/docs-style-guide) prescribe pautas para
escribir páginas de guía, explica cómo usar las clases y componentes de documentación, y cómo marcar el código fuente de ejemplo para producir fragmentos de código.

### Generar los documentos completos

La tarea principal para generar los documentos es `yarn docs`. Esto procesará todos los archivos fuente (*API* y otros),
extrayendo la documentación y generando archivos *JSON* que pueden ser consumidos por el visor de documentos.

### Generación parcial de documentos para editores

La generación de documentos completa puede tardar hasta un minuto. Eso es demasiado lento para la creación y edición de documentos eficientes.

Puedes realizar pequeños cambios en un editor inteligente que muestre `markdown` formateado:
> En VS Code, *Cmd-K, V* abre la vista previa de `markdown` en el panel lateral; *Cmd-B* alterna la barra lateral izquierda

También deseas que esos cambios se muestren correctamente en el visor de documentos.
con un tiempo de ciclo rápido de edición/visualización.

Para este propósito, usa la tarea `yarn docs-watch`, que busca cambios en los archivos fuente y solo
vuelve a procesar los archivos necesarios para generar los documentos relacionados con el archivo que ha cambiado.
Dado que esta tarea toma atajos, es mucho más rápida (a menudo menos de 1 segundo) pero no producirá
contenido fiel. Por ejemplo, es posible que los enlaces a otros documentos y código de ejemplo no se muestren correctamente. Este es
particularmente notado en los enlaces a otros documentos y en los ejemplos incrustados, que no siempre se pueden representar
perfectamente.

La configuración general es la siguiente:

* Abre una terminal, asegúrate de que las dependencias estén instaladas; ejecuta una generación de documentos inicial; luego inicia el visor de documentos:

```bash
yarn setup
yarn start
```

* Abre una segunda terminal y comienza a vigilar los documentos

```bash
yarn docs-watch
```

> Alternativamente, prueba el comando consolidado `serve-and-sync` que crea, observa y sirve en la misma ventana de terminal
```bash
yarn serve-and-sync
```

* Abre un navegador en https://localhost:4200/ y navega hasta el documento en el que deseas trabajar.
Puedes abrir automáticamente el navegador usando `yarn start -o` en la primera terminal.

* Realiza cambios en los archivos de ejemplo o documentos asociados a la página. Cada vez que se guarda un archivo, el documento
se regenerará, la aplicación se reconstruirá y la página se volverá a cargar.

* Si recibes un error de compilación quejándose de ejemplos o cualquier otro comportamiento extraño, asegúrate de consultar
la [Guía de estilo para autores](https://angular.io/guide/docs-style-guide).
