# Workspace and project file structure

You develop applications in the context of an Angular [workspace](guide/glossary#workspace). A workspace contains the files for one or more [projects](guide/glossary#project). A project is the set of files that comprise a standalone application or a shareable library.

The Angular CLI `ng new` command creates a workspace.

<code-example language="bash">
ng new &lt;my-project&gt;
</code-example>

When you run this command, the CLI installs the necessary Angular npm packages and other dependencies in a new workspace, with a root-level application named *my-project*.
The workspace root folder contains various support and configuration files, and a README file with generated descriptive text that you can customize.

By default, `ng new` creates an initial skeleton application at the root level of the workspace, along with its end-to-end tests.
The skeleton is for a simple Welcome application that is ready to run and easy to modify.
The root-level application has the same name as the workspace, and the source files reside in the `src/` subfolder of the workspace.

This default behavior is suitable for a typical "multi-repo" development style where each application resides in its own workspace.
Beginners and intermediate users are encouraged to use `ng new` to create a separate workspace for each application.

Angular also supports workspaces with [multiple projects](#multiple-projects).
This type of development environment is suitable for advanced users who are developing [shareable libraries](guide/glossary#library),
and for enterprises that use a "monorepo" development style, with a single repository and global configuration for all Angular projects.

To set up a monorepo workspace, you should skip the creating the root application.
See [Setting up for a multi-project workspace](#multiple-projects) below.

## Workspace configuration files

All projects within a workspace share a [CLI configuration context](guide/workspace-config).
The top level of the workspace contains workspace-wide configuration files, configuration files for the root-level application, and subfolders for the root-level application source and test files.

| WORKSPACE CONFIG FILES    | PURPOSE |
| :--------------------- | :------------------------------------------|
| `.editorconfig`        | Configuration for code editors. See [EditorConfig](https://editorconfig.org/). |
| `.gitignore`           | Specifies intentionally untracked files that [Git](https://git-scm.com/) should ignore. |
| `README.md`            | Introductory documentation for the root application. |
| `angular.json`         | CLI configuration defaults for all projects in the workspace, including configuration options for build, serve, and test tools that the CLI uses, such as [TSLint](https://palantir.github.io/tslint/), [Karma](https://karma-runner.github.io/), and [Protractor](https://www.protractortest.org/). For details, see [Angular Workspace Configuration](guide/workspace-config). |
| `package.json` | Configura [dependencias de paquetes `npm`](guide/npm-packages) que est??n disponibles para todos los proyectos en el espacio de trabajo. Consulta la [documentaci??n de `npm`](https://docs.npmjs.com/files/package.json) para conocer el formato y el contenido espec??ficos de este archivo. |
| `package-lock.json`     | Provides version information for all packages installed into `node_modules` by the npm client. See [npm documentation](https://docs.npmjs.com/files/package-lock.json) for details. If you use the yarn client, this file will be [yarn.lock](https://yarnpkg.com/lang/en/docs/yarn-lock/) instead. |
| `src/`                  | Source files for the root-level application project. |
| `node_modules/` | Proporciona [paquetes `npm`](guide/npm-packages) a todo el espacio de trabajo. Las dependencias de `node_modules` en todo el espacio de trabajo son visibles para todos los proyectos. |
| `tsconfig.json`         | The base [TypeScript](https://www.typescriptlang.org/) configuration for projects in the workspace. All other configuration files inherit from this base file. Para obtener m??s informaci??n, consulta la secci??n [Herencia de configuraci??n con `extends`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html#herencia-de-configuracion-con-extends) de la documentaci??n de *TypeScript*.
| `tslint.json`           | Default [TSLint](https://palantir.github.io/tslint/) configuration for projects in the workspace. |


## Application project files

By default, the CLI command `ng new my-app` creates a workspace folder named "my-app" and generates a new application skeleton in a `src/` folder at the top level of the workspace.
A newly generated application contains source files for a root module, with a root component and template.

When the workspace file structure is in place, you can use the `ng generate` command on the command line to add functionality and data to the application.
This initial root-level application is the *default app* for CLI commands (unless you change the default after creating [additional apps](#multiple-projects)).

<div class="alert is-helpful">

   Besides using the CLI on the command line, you can also manipulate files directly in the application's source folder and configuration files.

</div>

For a single-application workspace, the `src/` subfolder of the workspace contains the source files (application logic, data, and assets) for the root application.
For a multi-project workspace, additional projects in the `projects/` folder contain a `project-name/src/` subfolder with the same structure.

### Application source files

Files at the top level of `src/` support testing and running your application. Subfolders contain the application source and application-specific configuration.

| APP SUPPORT FILES    | PURPOSE |
| :--------------------- | :------------------------------------------|
| `app/`                 | Contains the component files in which your application logic and data are defined. See details [below](#app-src). |
| `assets/`              | Contains image and other asset files to be copied as-is when you build your application. |
| `environments/`        | Contains build configuration options for particular target environments. By default there is an unnamed standard development environment and a production ("prod") environment. You can define additional target environment configurations. |
| `favicon.ico`          | An icon to use for this application in the bookmark bar. |
| `index.html`           | The main HTML page that is served when someone visits your site. The CLI automatically adds all JavaScript and CSS files when building your app, so you typically don't need to add any `<script>` or` <link>` tags here manually. |
| `main.ts`              | The main entry point for your application. Compiles the application with the [JIT compiler](guide/glossary#jit) and bootstraps the application's root module (AppModule) to run in the browser. You can also use the [AOT compiler](guide/aot-compiler) without changing any code by appending the `--aot` flag to the CLI `build` and `serve` commands. |
| `polyfills.ts`         | Provides polyfill scripts for browser support. |
| `styles.sass` | Muestra una lista de archivos *CSS* que proporcionan estilos para un proyecto. La extensi??n refleja el preprocesador de estilo que has configurado para el proyecto. |
| `test.ts` | El principal punto de entrada para tus pruebas unitarias, con alguna configuraci??n espec??fica de *Angular*. Por lo general, no es necesario editar este archivo. |

<div class="alert is-helpful">

Los nuevos proyectos *Angular*, de manera predeterminada, usan el modo estricto. Si no lo deseas, puedes optar por no participar al crear el proyecto. Para obtener m??s informaci??n, consulta [Modo estricto](/guide/strict-mode).

</div>

{@a app-src}

Dentro del directorio `src /`, el directorio `app/` contiene la l??gica y los datos de tu proyecto.
Los componentes *Angular*, las plantillas y los estilos van aqu??.

| `src/app/` ARCHIVOS | PROP??SITO |
| :-------------------------- | :------------------------------------------|
| `app/app.component.ts` | Define la l??gica del componente ra??z de la aplicaci??n, denominado `AppComponent`. La vista asociada con este componente ra??z se convierte en la ra??z de la [jerarqu??a de vistas](guide/glossary#jerarquia-de-vistas) a medida que agregas componentes y servicios a tu aplicaci??n. |
| `app/app.component.html`    | Defines the HTML template associated with the root `AppComponent`. |
| `app/app.component.css`     | Defines the base CSS stylesheet for the root `AppComponent`. |
| `app/app.component.spec.ts` | Defines a unit test for the root `AppComponent`. |
| `app/app.module.ts`         | Defines the root module, named `AppModule`, that tells Angular how to assemble the application. Initially declares only the `AppComponent`. As you add more components to the app, they must be declared here. |

### Application configuration files

The application-specific configuration files for the root application reside at the workspace root level.
For a multi-project workspace, project-specific configuration files are in the project root, under `projects/project-name/`.

Project-specific [TypeScript](https://www.typescriptlang.org/) configuration files inherit from the workspace-wide `tsconfig.json`, and project-specific [TSLint](https://palantir.github.io/tslint/) configuration files inherit from the workspace-wide `tslint.json`.

| APPLICATION-SPECIFIC CONFIG FILES    | PURPOSE |
| :--------------------- | :------------------------------------------|
| `.browserslistrc`       | Configures sharing of target browsers and Node.js versions among various front-end tools. See [Browserslist on GitHub](https://github.com/browserslist/browserslist) for more information.  |
| `karma.conf.js`      | Application-specific [Karma](https://karma-runner.github.io/2.0/config/configuration-file.html) configuration. |
| `tsconfig.app.json`    | Application-specific [TypeScript](https://www.typescriptlang.org/) configuration, including TypeScript and Angular template compiler options. See [TypeScript Configuration](guide/typescript-configuration) and [Angular Compiler Options](guide/angular-compiler-options). |
| `tsconfig.spec.json`   | [TypeScript](https://www.typescriptlang.org/) configuration for the application tests. See [TypeScript Configuration](guide/typescript-configuration). |
| `tslint.json`          | Application-specific [TSLint](https://palantir.github.io/tslint/) configuration. |


{@a multiple-projects}

## Multiple projects

A multi-project workspace is suitable for an enterprise that uses a single repository and global configuration for all Angular projects (the "monorepo" model). A multi-project workspace also supports library development.

### Setting up for a multi-project workspace

If you intend to have multiple projects in a workspace, you can skip the initial application generation when you create the workspace, and give the workspace a unique name.
The following command creates a workspace with all of the workspace-wide configuration files, but no root-level application.

<code-example language="bash">
ng new my-workspace --create-application false
</code-example>

You can then generate applications and libraries with names that are unique within the workspace.

<code-example language="bash">
cd my-workspace
ng generate application my-first-app
</code-example>

### Multiple project file structure

The first explicitly generated application goes into the `projects/` folder along with all other projects in the workspace.
Newly generated libraries are also added under `projects/`.
When you create projects this way, the file structure of the workspace is entirely consistent with the structure of the [workspace configuration file](guide/workspace-config), `angular.json`.

<code-example language="none">
my-workspace/
  ...             (workspace-wide config files)
  projects/       (generated applications and libraries)
    my-first-app/ --(an explicitly generated application)
      ...         --(application-specific config)
      src/        --(source and support files for application)
    my-lib/       --(a generated library)
      ...         --(library-specific config)
      src/        --source and support files for library)
</code-example>

## Library project files

When you generate a library using the CLI (with a command such as `ng generate library my-lib`), the generated files go into the `projects/` folder of the workspace. For more information about creating your own libraries, see  [Creating Libraries](guide/creating-libraries).

Libraries unlike applications have their own `package.json` configuration file.

Under the `projects/` folder, the `my-lib` folder contains your library code.

| LIBRARY SOURCE FILES | PURPOSE                                                                      |
| :------------------- | :----------------------------------------------------------------------------|
| `src/lib`           |  Contains your library project's logic and data. Like an application project, a library project can contain components, services, modules, directives, and pipes.                                                            |
| `src/test.ts`       | The main entry point for your unit tests, with some library-specific configuration. Por lo general, no es necesario editar este archivo.                                                                                            |
| `src/public-api.ts`  | Specifies all files that are exported from your library.                                                                                                                                                                     |
| `karma.conf.js`      | Library-specific [Karma](https://karma-runner.github.io/2.0/config/configuration-file.html) configuration.                                                                                                                   |
| `ng-package.json`    | Configuration file used by [ng-packagr](https://github.com/ng-packagr/ng-packagr) for building your library.                                                                                                                 |
| `package.json` | Configura [dependencias de paquetes `npm`](guide/npm-packages) que son necesarios para esta biblioteca.                                                                                                                                |
| `tsconfig.lib.json`  | Library-specific [TypeScript](https://www.typescriptlang.org/) configuration, including TypeScript and Angular template compiler options. See [TypeScript Configuration](guide/typescript-configuration).            |
| `tsconfig.lib.prod.json`  | Library-specific [TypeScript](https://www.typescriptlang.org/) configuration that is used when building the library in production mode.              |
| `tsconfig.spec.json` | [TypeScript](https://www.typescriptlang.org/) configuration for the library tests. See [TypeScript Configuration](guide/typescript-configuration).                                                                     |
| `tslint.json`        | Library-specific [TSLint](https://palantir.github.io/tslint/) configuration. |
