# Descripción general

Muchas de las páginas de documentación contienen fragmentos de código de ejemplo.
Estos fragmentos se extraen de aplicaciones de ejemplo que realmente funcionan, y se almacenan en subdirectorios del directorio [`aio/content/examples/`](.).
Cada ejemplo se puede construir y ejecutar de forma independiente.
Cada ejemplo también proporciona pruebas (principalmente `e2e` y ocasionalmente pruebas unitarias), que se ejecutan como parte de nuestros trabajos `CircleCI` de `test_docs_examples*`, para comprobar que los ejemplos continúan funcionando como se esperaba, a medida que se realizan cambios en las bibliotecas principales de *Angular*.

Para compilar, ejecutar y probar estos ejemplos de forma independiente, debes instalar las dependencias en su subdirectorio.
También hay una serie de archivos repetitivos comunes que se necesitan para configurar el proyecto de cada ejemplo.
Estos archivos repetitivos comunes se mantienen de forma centralizada para reducir la cantidad de esfuerzo si uno de ellos necesita cambios.

> **Nota para usuarios de Windows**
>
> La configuración de los ejemplos implica la creación de algunos [enlaces simbólicos](https://en.wikipedia.org/wiki/Symbolic_link) (consulta [este artículo](#symlinked-node_modules) para obtener más detalles).
> En *Windows*, esto requiere tener el [modo de desarrollador habilitado](https://blogs.windows.com/windowsdeveloper/2016/12/02/symlinks-windows-10) (compatible con *Windows 10* o más reciente) o ejecutar los comandos de configuración como administrador.


## Descripción general redundante

Como se mencionó anteriormente, muchas de las páginas de documentación contienen fragmentos extraídos de aplicaciones de ejemplo reales.
Para lograrlo, todas esas aplicaciones deben contener un texto repetitivo básico, como un directorio `node_modules/`, un archivo `package.json` con scripts y dependencias, etc.

También hay diferentes tipos de proyectos, cada uno con su propia plantilla.
Por ejemplo, hay proyectos basados ​​en *Angular CLI*, proyectos que usan *AngularJS*, elementos personalizados, i18n, renderización del lado del servidor, etc.
(Consulta la [sección de configuración de ejemplo](#configuracion-de-ejemplo) a continuación para obtener más información sobre cómo especificar el tipo de proyecto).

Para evitar tener que mantener el texto estándar en cada ejemplo, usamos el script [`example-boilerplate-js`](./example-boilerplate.js) para proporcionar un conjunto de archivos que funciona con todos los ejemplos de un tipo específico.


### Archivos repetitivos

Dentro de [`shared/boilerplate/`](./shared/boilerplate) hay un subdirectorio con archivos repetitivos para cada uno de los diferentes tipos de proyectos.

Actualmente, se admiten los siguientes tipos de proyectos:

- `cli` ⏤ Por ejemplo, aplicaciones basadas en *Angular CLI*. Este es el tipo predeterminado y se usa en la mayoría de los ejemplos.
- `cli-ajs`: Para ejemplos basados ​​en *CLI* que también usan *AngularJS* (pero no a través de `@angular/upgrade`).
- `elements` ⏤ For CLI-based examples that also use `@angular/elements`.
- `getting-started` ⏤ For the "Getting started" tutorial. Essentially the same as `cli` but with custom CSS styles.
- `i18n` ⏤ For CLI-based examples that also use internationalization.
- `schematics` ⏤ For CLI-based examples that include a library with schematics.
- `service-worker` ⏤ For CLI-based examples that also use `@angular/service-worker`.
- `systemjs` ⏤ For non-CLI legacy examples using SystemJS. This is deprecated and only used in few examples.
- `testing` ⏤ For CLI-based examples that are related to unit testing.
- `universal` ⏤ For CLI-based examples that also use `@nguniversal/express-engine` for SSR.

There are also the following special folders:
- `common` ⏤ Contains files used in many examples.
  (Consulta la [siguiente sección](#configuracion-de-ejemplo) para obtener información sobre cómo excluir archivos comunes en ciertos ejemplos).


<a name="configuracion-de-ejemplo"></a>
### El `example-config.json`

Cada ejemplo se identifica mediante un archivo de configuración `example-config.json` en su directorio raíz.
Este archivo de configuración indica qué tipo de texto estándar necesita este ejemplo y cómo probarlo.
Por ejemplo:

```json
{
  "projectType": "cli"
}
```

Se espera que el archivo contenga un objeto *JSON* con cero o más de las siguientes propiedades:

- `projectType: string`: Uno de los tipos de proyectos admitidos (ve arriba).
  Predefinido: `"cli"`
- `useCommonBoilerplate: boolean`: Si se debe incluir texto estándar común del directorio [`common/`](./shared/boilerplate/common).
  Predefinido: `true`
- `"overrideBoilerplate": string[]`: Una lista de rutas a archivos repetitivos que son reemplazados por archivos personalizados en este ejemplo.
  Por lo general, esto se usa cuando se hace referencia a un archivo repetitivo en una guía y, por lo tanto, es necesario agregar regiones de documentación.
  Cuando agregues tales redefiniciones, asegúrate de que el archivo "no se ignore" agregando un patrón de negación apropiado al archivo `content/examples/.gitignore`.

**Propiedades SystemJS-only**:
- `build: string`: El script `npm` que se ejecutará para crear la aplicación de ejemplo.
  Predefinido: `"build"`
- `run: string`: El script `npm` que se ejecutará para servir la aplicación de ejemplo (para que la prueba `e2e` se pueda ejecutar en ella).
  Predeterminado `"serve:e2e"`

**Propiedades CLI-only**:
- `tests: object[]`: Un arreglo de objetos, cada uno de los cuales especifica un comando de prueba. Esto se puede utilizar para ejecutar varios comandos de prueba en serie (por ejemplo, para ejecutar pruebas unitarias y `e2e`).
  Los comandos se especifican como `{cmd: string, args: string[]}`y deben estar en un formato que se pueda pasar a `Node.js`'`child_process.spawn(cmd, args)`. Puedes utilizar un marcador de posición especial `{PORT}`, que será reemplazado por el puerto en el que se sirve la aplicación durante la prueba real.
  Predefinido:

  ```json
  [
    {
      "cmd": "yarn",
      "args": [
        "e2e",
        "--configuration=production",
        "--protractor-config=e2e/protractor-puppeteer.conf.js",
        "--no-webdriver-update",
        "--port={PORT}"
      ]
    }
  ]
  ```

Un archivo `example-config.json` vacío es equivalente a `{"projectType": "cli"}`.


<a name="symlinked-node_modules"></a>
### Un `node_modules/` para compartir

Con todos los archivos repetitivos en su lugar, la única pieza que falta son los paquetes instalados.
Para eso tenemos [`shared/package.json`](./shared/package.json), que contiene **todos** los paquetes necesarios para ejecutar cualquier tipo de ejemplo.

Al instalar estas dependencias, se crea un directorio [`shared/node_modules/`](./shared/node_modules).
Este directorio tendrá un **enlace simbólico** en cada ejemplo.
Por lo tanto, no es una copia como los otros archivos estándar.


### Pruebas de principio-a-fin

La infraestructura de principio-a-fin es ligeramente diferente entre la *CLI*- y ejemplos basados ​​en *SystemJS*.

Para ejemplos basados ​​en *CLI*, crea un archivo `app.e2e-spec.ts` dentro del directorio `e2e/`.
Esto será recogido por el comando de prueba predeterminado (ve la [sección de configuración de ejemplo](#configuracion-de-ejemplo) arriba).
If you are using a custom test command, make sure e2e specs are picked up (if applicable).

For SystemJS-based examples, create an `e2e-spec.ts` file inside the example root folder.
These apps will be tested with the following command (and an optional `outputFile` to receive log messages):

```sh
yarn protractor [--params.outputFile=path/to/logfile.txt]
```


### `example-boilerplate.js`

The [example-boilerplate.js](./example-boilerplate.js) script manages the dependencies for all examples.

- `example-boilerplate.js add` ⏤ create the `node_modules/` symlinks and copy the necessary boilerplate files into example folders.
- `example-boilerplate.js remove` ⏤ remove all the boilerplate files from examples.
  It uses `git clean -xdf` to do the job.
  It will remove all files that are not tracked by git, **including any new files that you are working on that haven't been staged yet.**
  So, be sure to commit your work before removing the boilerplate.
- `example-boilerplate.js list-overrides` ⏤ print out a list of all example files that override boilerplate files.
  This is useful when updating the boilerplate files to a new version of Angular.

### `run-example-e2e.mjs`

El script [`run-example-e2e.mjs`](./run-example-e2e.mjs) buscará y ejecutará las pruebas `e2e` para todos los ejemplos.
Aunque solo ejecuta pruebas `e2e` de forma predeterminada, se puede configurar para ejecutar cualquier comando de prueba (para ejemplos basados ​​en *CLI*) mediante la propiedad `tests` del archivo [`example-config.json`](#configuracion-de-ejemplo).
Se llama `*-e2e` por razones históricas, pero no se limita a ejecutar pruebas `e2e`.

Consulta [`aio/README.md`](../../README.md#tareas-del-desarrollador) para conocer las opciones disponibles de la línea de comandos.

La ejecución del script creará un archivo `aio/protractor-results.txt` con los resultados de las pruebas.

### `create-example.js`

The [create-example.js](./create-example.js) script creates a new example under the `aio/content/examples` directory.

You must provide a new name for the example.
By default the script will place basic scaffold files into the new example (from [shared/example-scaffold](./shared/example-scaffold)).
But you can also specify the path to a separate CLI project, from which the script will copy files that would not be considered "boilerplate".
See the [Boilerplate overview](#boilerplate-overview) for more information.

### Updating example dependencies

With every major Angular release, we update the examples to be on the latest version.
See [UPDATING.md](./UPDATING.md) for instructions.
