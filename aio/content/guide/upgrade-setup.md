# Setup for upgrading from AngularJS

<!--
Pregunta: ¿Podemos eliminar este archivo y, en su lugar, dirigir a los lectores a https://github.com/angular/quickstart/blob/master/README.md?
-->

<div class="alert is-critical">

**Audience:** Use this guide **only** in the context of  [Upgrading from AngularJS](guide/upgrade "Upgrading from AngularJS to Angular") or [Upgrading for Performance](guide/upgrade-performance "Upgrading for Performance").
Esas guías de actualización se refieren a esta guía de configuración para obtener información sobre el uso del [repositorio de inicio rápido en *GitHub* obsoleto](https://github.com/angular/quickstart "repositorio Angular de inicio rápido en GitHub obsoleto"), que se creó antes de la [*CLI* de *Angular* actual](cli "Descripción general de la CLI").

**Para todos los demás escenarios,** consulta las instrucciones actuales en [Configuración del entorno local y el espacio de trabajo](guide/setup-local "Configuración para el desarrollo local").


</div>

<!--
El ejemplo de <live-example name=quickstart>Inicio rápido de codificación en vivo</live-example> es un *playground Angular*.
También hay algunas diferencias con una aplicación local, para simplificar esa experiencia de codificación en vivo.
En particular, el ejemplo de inicio rápido de codificación en vivo muestra solo el archivo `AppComponent`; crea el equivalente de `app.module.ts` y `main.ts` internamente solo para el *playground*.
-->

This guide describes how to develop locally on your own machine.
Configurar un nuevo proyecto en tu máquina es rápido y fácil con [la semilla de inicio rápido en *github*](https://github.com/angular/quickstart "Instala el repositorio de inicio rápido de github").

**Requisito previo**: Asegúrate de tener [*Node.js®* y *npm* instalados](guide/setup-local#prerequisitos "Prerequisitos Angular").


{@a clonar}
## Clonar

Realiza los pasos de *clonar-para-lanzar* con estos comandos de la terminal.

<code-example language="sh">
  git clone https://github.com/angular/quickstart.git quickstart
  cd quickstart
  npm install
  npm start

</code-example>



<div class="alert is-important">



`npm start` falla en *Bash* para *Windows* en versiones anteriores a *Creator's Update* (abril de 2017).


</div>



{@a descargar}


## Descargar
<a href="https://github.com/angular/quickstart/archive/master.zip" title="Descarga el repositorio de semillas de inicio rápido">Descarga el repositorio de semillas de inicio rápido</a>
y descomprímelo en el directorio de tu proyecto. Luego, realiza los pasos restantes con estos comandos en la terminal.

<code-example language="sh">
  cd quickstart
  npm install
  npm start

</code-example>



<div class="alert is-important">



`npm start` falla en *Bash* para *Windows* en versiones anteriores a *Creator's Update* (abril de 2017).


</div>



{@a non-essential}



## Delete _non-essential_ files (optional)

Puedes eliminar rápidamente los archivos *no esenciales* relacionados con las pruebas y el mantenimiento del repositorio `QuickStart`
(***including all git-related artifacts*** such as the `.git` folder and `.gitignore`!).


<div class="alert is-important">



Do this only in the beginning to avoid accidentally deleting your own tests and git setup!


</div>



Open a terminal window in the project folder and enter the following commands for your environment:

### OS/X (bash)

<code-example language="sh">
  xargs rm -rf &lt; non-essential-files.osx.txt
  rm src/app/*.spec*.ts
  rm non-essential-files.osx.txt

</code-example>



### *Windows*

<code-example language="sh">
  for /f %i in (non-essential-files.txt) do del %i /F /S /Q
  rd .git /s /q
  rd e2e /s /q

</code-example>



{@a seed}



## ¿Qué hay en la semilla `QuickStart`?



La **semilla `QuickStart`** proporciona una aplicación de inicio rápido básica para *playground* y otros archivos necesarios para el desarrollo local.
En consecuencia, hay muchos archivos en el directorio del proyecto de tu máquina,
la mayoría de los cuales puedes [conocer más adelante](guide/file-structure).


<div class="alert is-helpful">

**Recuerda**: El ejemplo "QuickStart seed" se creó antes de *Angular CLI*, por lo que existen algunas diferencias entre lo que se describe aquí y una aplicación *Angular CLI*.

</div>

{@a app-files}


Focus on the following three TypeScript (`.ts`) files in the **`/src`** folder.


<div class='filetree'>

  <div class='file'>
    src
  </div>

  <div class='children'>

    <div class='file'>
      app
    </div>

    <div class='children'>

      <div class='file'>
        `app.component.ts`
      </div>

      <div class='file'>
        `app.module.ts`
      </div>

    </div>

    <div class='file'>
      main.ts
    </div>

  </div>

</div>



<code-tabs>

  <code-pane header="src/app/app.component.ts" path="setup/src/app/app.component.ts">

  </code-pane>

  <code-pane header="src/app/app.module.ts" path="setup/src/app/app.module.ts">

  </code-pane>

  <code-pane header="src/main.ts" path="setup/src/main.ts">

  </code-pane>

</code-tabs>



All guides and cookbooks have _at least these core files_.
Each file has a distinct purpose and evolves independently as the application grows.

Files outside `src/` concern building, deploying, and testing your application.
They include configuration files and external dependencies.

Files inside `src/` "belong" to your application.
Add new Typescript, HTML and CSS files inside the `src/` directory, most of them inside `src/app`,
unless told to do otherwise.

The following are all in `src/`


<style>
  td, th {vertical-align: top}
</style>



<table width="100%">

  <col width="20%">

  </col>

  <col width="80%">

  </col>

  <tr>

    <th>
      File
    </th>

    <th>
      Purpose
    </th>

  </tr>

  <tr>

    <td>
      <code>app/app.component.ts</code>
    </td>

    <td>


      Define el mismo `AppComponent` que el del *playground* `QuickStart`.
      Es el componente **raíz** de lo que se convertirá en un árbol de componentes anidados
      a medida que evoluciona la aplicación.
    </td>

  </tr>

  <tr>

    <td>
      <code>app/app.module.ts</code>
    </td>

    <td>


      Defines `AppModule`, the  [root module](guide/bootstrapping "AppModule: the root module") that tells Angular how to assemble the application.
      When initially created, it declares only the `AppComponent`.
      Over time, you add more components to declare.
    </td>

  </tr>

  <tr>

    <td>
      <code>main.ts</code>
    </td>

    <td>


      Compiles the application with the [JIT compiler](guide/glossary#jit) and
      [bootstraps](guide/bootstrapping)
      the application's main module (`AppModule`) to run in the browser.
      The JIT compiler is a reasonable choice during the development of most projects and
      it's the only viable choice for a sample running in a _live-coding_ environment such as Stackblitz.
      Alternative [compilation](guide/aot-compiler), [build](guide/build), and [deployment](guide/deployment) options are available.

    </td>

  </tr>

</table>


## Appendix: Develop locally with IE

If you develop Angular locally with `ng serve`, a `websocket` connection is set up automatically between browser and local development server, so when your code changes, the browser can automatically refresh.

In Windows, by default, one application can only have 6 websocket connections, <a href="https://msdn.microsoft.com/library/ee330736%28v=vs.85%29.aspx?f=255&MSPPError=-2147217396#websocket_maxconn" title="MSDN WebSocket settings">MSDN WebSocket Settings</a>.
So when IE is refreshed (manually or automatically by `ng serve`), sometimes the websocket does not close properly. When websocket connections exceed the limitations, a `SecurityError` will be thrown. This error will not affect the Angular application, you can restart IE to clear this error, or modify the windows registry to update the limitations.

## Appendix: Test using `fakeAsync()/waitForAsync()`

If you use the `fakeAsync()/waitForAsync()` helper functions to run unit tests (for details, read the [Testing guide](guide/testing-components-scenarios#fake-async)), you need to import `zone.js/testing` in your test setup file.

<div class="alert is-important">
If you create project with `Angular/CLI`, it is already imported in `src/test.ts`.
</div>

And in the earlier versions of `Angular`, the following files were imported or added in your html file:

```
import 'zone.js/plugins/long-stack-trace-zone';
import 'zone.js/plugins/proxy';
import 'zone.js/plugins/sync-test';
import 'zone.js/plugins/jasmine-patch';
import 'zone.js/plugins/async-test';
import 'zone.js/plugins/fake-async-test';
```

You can still load those files separately, but the order is important, you must import `proxy` before `sync-test`, `async-test`, `fake-async-test` and `jasmine-patch`. And you also need to import `sync-test` before `jasmine-patch`, so it is recommended to just import `zone-testing` instead of loading those separated files.
