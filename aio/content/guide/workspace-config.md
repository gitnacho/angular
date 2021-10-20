# Angular workspace configuration

A file named `angular.json` at the root level of an Angular [workspace](guide/glossary#workspace) provides workspace-wide and project-specific configuration defaults for build and development tools provided by the Angular CLI.
Path values given in the configuration are relative to the root workspace folder.

## Overall JSON structure

At the top-level of `angular.json`, a few properties configure the workspace and a `projects` section contains the remaining per-project configuration options. You can override CLI defaults set at the workspace level through defaults set at the project level. You can also override defaults set at the project level using the command line.

The following properties, at the top-level of the file, configure the workspace.

*   `version` ⏤ The configuration-file version.
*   `newProjectRoot` ⏤ Path where new projects are created. Absolute or relative to the workspace folder.
*   `defaultProject` ⏤ Default project name to use in commands, where not provided as an argument. When you use `ng new` to create a new application in a new workspace, that application is the default project for the workspace until you change it here.
*   `cli` : A set of options that customize the [Angular CLI](cli). See the [CLI configuration options](#cli-configuration-options) section.
*   `schematics` : A set of [schematics](guide/glossary#schematic) that customize the `ng generate` sub-command option defaults for this workspace. See the [Generation schematics](#schematics) section.
*   `projects` : Contains a subsection for each project (library or application) in the workspace, with the per-project configuration options.

The initial application that you create with `ng new app_name` is listed under "projects":

<code-example language="json">

"projects": {
  "app_name": {
    ...
  }
  ...
}

</code-example>

When you create a library project with `ng generate library`, the library project is also added to the `projects` section.

<div class="alert is-helpful">

**NOTA**: The `projects` section of the configuration file does not correspond exactly to the workspace file structure.

*   The initial application created by `ng new` is at the top level of the workspace file structure.
*   Additional applications and libraries go into a `projects` folder in the workspace.

For more information, see [Workspace and project file structure](guide/file-structure).

</div>

{@a cli-configuration-options}

## CLI configuration options

The following configuration properties are a set of options that customize the Angular CLI.

| Property            | Description                                                                                      | Value Type                                               |
| :------------------ | :----------------------------------------------------------------------------------------------- | :------------------------------------------------------- |
| `analytics`         | Share anonymous [usage data](cli/usage-analytics-gathering) with the Angular Team.               | `boolean` \| `ci`                                        |
| `analyticsSharing`  | A set of analytics sharing options.                                                              | [Analytics sharing options](#analytics-sharing-options)  |
| `cache`             | Control [persistent disk cache](cli/cache) used by [Angular CLI Builders](guide/cli-builder).    | [Opciones de caché](#opciones-de-cache) |
| `defaultCollection` | The default schematics collection to use.                                                        | `string`                                                 |
| `packageManager`    | The prefered package manager tool to use.                                                        | `npm` \| `cnpm` \| `pnpm` \| `yarn`                      |
| `warnings`          | Control CLI specific console warnings.                                                           | [Warnings options](#warnings-options)                    |

### Analytics sharing options

| Property   | Description                                                  | Value Type |
| :--------- | :----------------------------------------------------------- | :--------- |
| `tracking` | Analytics sharing info tracking ID.                          | `string`   |
| `uuid`     | Analytics sharing info UUID (Universally Unique Identifier). | `string`   |

### Opciones de caché

| Property      | Description                                           | Value Type               | Dafault Value    |
| :------------ | :---------------------------------------------------- | :----------------------- | :--------------- |
| `enabled`     | Configure whether disk caching is enabled.            | `boolean`                | `true`           |
| `environment` | Configure in which environment disk cache is enabled. | `local` \| `ci` \| `all` | `local`          |
| `path`        | The directory used to stored cache results.           | `string`                 | `.angular/cache` |

### Warnings options

| Property          | Description                                                                     | Value Type | Dafault Value |
| :---------------- | :------------------------------------------------------------------------------ | :--------- | :------------ |
| `versionMismatch` | Show a warning when the global Angular CLI version is newer than the local one. | `boolean`  | `true`        |

## Project configuration options

The following top-level configuration properties are available for each project, under `projects:<project_name>`.

<code-example language="json">

"my-app": {
  "root": "",
  "sourceRoot": "src",
  "projectType": "application",
  "prefix": "app",
  "schematics": {},
  "architect": {}
}

</code-example>

| PROPERTY        | DESCRIPTION                                                                                                                                             |
|:---             |:---                                                                                                                                                     |
| `root`          | The root folder for this project's files, relative to the workspace folder. Empty for the initial app, which resides at the top level of the workspace. |
| `sourceRoot`    | The root folder for this project's source files.                                                                                                        |
| `projectType`   | One of "application" or "library". An application can run independently in a browser, while a library cannot.                                           |
| `prefix`        | A string that Angular prepends to generated selectors. Can be customized to identify an application or feature area.                                    |
| `schematics`    | A set of schematics that customize the `ng generate` sub-command option defaults for this project. See the [Generation schematics](#schematics) section.|
| `architect`     | Configuration defaults for Architect builder targets for this project.                                                                                  |

{@a schematics}

## Esquemas de generación

Angular generation [schematics](guide/glossary#schematic) are instructions for modifying a project by adding files or modifying existing files.
Individual schematics for the default Angular CLI `ng generate` sub-commands are collected in the package `@schematics/angular`.
Specify the schematic name for a subcommand in the format `schematic-package:schematic-name`;
for example, the schematic for generating a component is `@schematics/angular:component`.

The JSON schemas for the default schematics used by the CLI to generate projects and parts of projects are collected in the package [`@schematics/angular`](https://github.com/angular/angular-cli/blob/master/packages/schematics/angular/application/schema.json).
The schema describes the options available to the CLI for each of the `ng generate` sub-commands, as shown in the `--help` output.

The fields given in the schema correspond to the allowed argument values and defaults for the CLI sub-command options.
You can update your workspace schema file to set a different default for a sub-command option.

{@a architect}

## Project tool configuration options

Architect is the tool that the CLI uses to perform complex tasks, such as compilation and test running.
Architect is a shell that runs a specified [builder](guide/glossary#builder) to perform a given task, according to a [target](guide/glossary#target) configuration.
You can define and configure new builders and targets to extend the CLI.
See [Angular CLI Builders](guide/cli-builder).

{@a default-build-targets}

### Default Architect builders and targets

Angular defines default builders for use with specific CLI commands, or with the general `ng run` command.
The JSON schemas that define the options and defaults for each of these default builders are collected in the [`@angular-devkit/build-angular`](https://github.com/angular/angular-cli/blob/master/packages/angular_devkit/build_angular/builders.json) package.
The schemas configure options for the following builders.

* [app-shell](https://github.com/angular/angular-cli/blob/master/packages/angular_devkit/build_angular/src/builders/app-shell/schema.json)
* [browser](https://github.com/angular/angular-cli/blob/master/packages/angular_devkit/build_angular/src/builders/browser/schema.json)
* [dev-server](https://github.com/angular/angular-cli/blob/master/packages/angular_devkit/build_angular/src/builders/dev-server/schema.json)
* [extract-i18n](https://github.com/angular/angular-cli/blob/master/packages/angular_devkit/build_angular/src/builders/extract-i18n/schema.json)
* [karma](https://github.com/angular/angular-cli/blob/master/packages/angular_devkit/build_angular/src/builders/karma/schema.json)
* [server](https://github.com/angular/angular-cli/blob/master/packages/angular_devkit/build_angular/src/builders/server/schema.json)

### Configuring builder targets

The `architect` section of `angular.json` contains a set of Architect targets.
Many of the targets correspond to the CLI commands that run them.
Some additional predefined targets can be run using the `ng run` command, and you can define your own targets.

Each target object specifies the `builder` for that target, which is the npm package for the tool that Architect runs.
In addition, each target has an `options` section that configures default options for the target, and a `configurations` section that names and specifies alternative configurations for the target.
See the example in [Build target](#build-target) below.

<code-example language="json">

"architect": {
  "build": {},
  "serve": {},
  "e2e" : {},
  "test": {},
  "lint": {},
  "extract-i18n": {},
  "server": {},
  "app-shell": {}
}

</code-example>

*   The `architect/build` section configures defaults for options of the `ng build` command.
    See the [Build target](#build-target) section for more information.
*   The `architect/serve` section overrides build defaults and supplies additional serve defaults for the `ng serve` command. In addition to the options available for the `ng build` command, it adds options related to serving the application.
*   The `architect/e2e` section overrides build-option defaults for building end-to-end testing applications using the `ng e2e` command.
*   The `architect/test` section overrides build-option defaults for test builds and supplies additional test-running defaults for the `ng test` command.
*   The `architect/lint` section configures defaults for options of the `ng lint` command, which performs code analysis on project source files.
*   The `architect/extract-i18n` section configures defaults for options of the `ng extract-i18n` command, which extracts marked message strings from source code and outputs translation files.
*   The `architect/server` section configures defaults for creating a Universal application with server-side rendering, using the `ng run <project>:server` command.
*   The `architect/app-shell` section configures defaults for creating an application shell for a progressive web application (PWA), using the `ng run <project>:app-shell` command.

In general, the options for which you can configure defaults correspond to the command options listed in the [CLI reference page](cli) for each command.
**NOTA**: All options in the configuration file must use [camelCase](guide/glossary#case-conventions), rather than dash-case.

{@a build-target}

## Build target

The `architect/build` section configures defaults for options of the `ng build` command. It has the following top-level properties.

| PROPERTY        | DESCRIPTION                                                                                                                                                                                                                                                                                                              |
|:---             |:---                                                                                                                                                                                                                                                                                                                      |
| `builder`       | The npm package for the build tool used to create this target. The default builder for an application (`ng build myApp`) is <code class="no-auto-link">@angular-devkit/build-angular:browser</code>, which uses the [webpack](https://webpack.js.org) package bundler. **NOTA**: A different builder is used for building a library (`ng build myLib`). |
| `options`       | This section contains default build target options, used when no named alternative configuration is specified. See the [Default build targets](#default-build-targets) section.                                                                                                                                                |
| `configurations`| This section defines and names alternative configurations for different intended destinations. It contains a section for each named configuration, which sets the default options for that intended environment. See the [Alternate build configurations](#build-configs) section.                                             |

{@a build-configs}

### Alternate build configurations

Angular CLI comes with two build configurations: `production` and `development`. By default, the `ng build` command uses the `production` configuration, which applies a number of build optimizations, including:

*   Bundling files
*   Minimizing excess whitespace
*   Removing comments and dead code
*   Rewriting code to use short, mangled names (minification)

You can define and name additional alternate configurations (such as `stage`, for instance) appropriate to your development process. Some examples of different build configurations are `stable`, `archive`, and `next` used by AIO itself, and the individual locale-specific configurations required for building localized versions of an application. For details, see [Internationalization (i18n)][AioGuideI18nCommonMerge].

You can select an alternate configuration by passing its name to the `--configuration` command line flag.

You can also pass in more than one configuration name as a comma-separated list. For example, to apply both `stage` and `fr` build configurations, use the command `ng build --configuration stage,fr`. In this case, the command parses the named configurations from left to right. If multiple configurations change the same setting, the last-set value is the final one. So in this example, if both `stage` and `fr` configurations set the output path the value in `fr` would get used.

{@a build-props}

### Additional build and test options

The configurable options for a default or targeted build generally correspond to the options available for the [`ng build`](cli/build), [`ng serve`](cli/serve), and [`ng test`](cli/test) commands. For details of those options and their possible values, see the [CLI Reference](cli).

Some additional options can only be set through the configuration file, either by direct editing or with the [`ng config`](cli/config) command.

| OPTIONS PROPERTIES         | DESCRIPTION                                                                                                                                                                                                                                                                                           |
|:---                        |:---                                                                                                                                                                                                                                                                                                   |
| `assets`                   | An object containing paths to static assets to add to the global context of the project. The default paths point to the project's icon file and its `assets` folder. See more in the [Assets configuration](#asset-config) section.                                                                         |
| `styles`                   | An array of style files to add to the global context of the project. Angular CLI supports CSS imports and all major CSS preprocessors: [sass/scss](https://sass-lang.com) and [less](http://lesscss.org). Ve más en la sección [Configuración de estilos y scripts](#configuracion-de-estilos-y-scripts).               |
| `stylePreprocessorOptions` | Objeto que contiene pares de opciones y valores para pasar a los preprocesadores de estilo. Ve más en la sección [Configuración de estilos y scripts](#configuracion-de-estilos-y-scripts).                                                                                                                                                   |
| `scripts`                  | An object containing JavaScript script files to add to the global context of the project. The scripts are loaded exactly as if you had added them in a `<script>` tag inside `index.html`. Ve más en la sección [Configuración de estilos y scripts](#configuracion-de-estilos-y-scripts).                                |
| `budgets`                  | Default size-budget type and thresholds for all or parts of your application. You can configure the builder to report a warning or an error when the output reaches or exceeds a threshold size. See [Configure size budgets](guide/build#configure-size-budgets). (Not available in `test` section.) |
| `fileReplacements`         | An object containing files and their compile-time replacements. See more in [Configure target-specific file replacements](guide/build#configure-target-specific-file-replacements).                                                                                                                   |

{@a complex-config}

## Complex configuration values

The options `assets`, `styles`, and `scripts` can have either simple path string values, or object values with specific fields.
The `sourceMap` and `optimization` options can be set to a simple Boolean value with a command flag, but can also be given a complex value using the configuration file.
The following sections provide more details of how these complex values are used in each case.

{@a asset-config}

### Assets configuration

Each `build` target configuration can include an `assets` array that lists files or folders you want to copy as-is when building your project.
By default, the `src/assets/` folder and `src/favicon.ico` are copied over.

<code-example language="json">

"assets": [
  "src/assets",
  "src/favicon.ico"
]

</code-example>

To exclude an asset, you can remove it from the assets configuration.

You can further configure assets to be copied by specifying assets as objects, rather than as simple paths relative to the workspace root.
A asset specification object can have the following fields.

*   `glob` ⏤ A [node-glob](https://github.com/isaacs/node-glob/blob/master/README.md) using `input` as base directory.
*   `input` ⏤ Una ruta relativa a la raíz del espacio de trabajo.
*   `output` ⏤ A path relative to `outDir` (default is `dist/`*project-name*). Because of the security implications, the CLI never writes files outside of the project output path.
*   `ignore` ⏤ A list of globs to exclude.
*   `followSymlinks` ⏤ Permite que los patrones globales sigan enlaces simbólicos a directorios. Esto permite realizar búsquedas en los subdirectorios del enlace simbólico. El valor predeterminado es `false`.

Por ejemplo, las rutas de activos predeterminadas se pueden representar con más detalle utilizando los siguientes objetos.

<code-example language="json">

"assets": [
  {
    "glob": "**/*",
    "input": "src/assets/",
    "output": "/assets/"
  },
  {
    "glob": "favicon.ico",
    "input": "src/",
    "output": "/"
  }
]

</code-example>

You can use this extended configuration to copy assets from outside your project.
For example, the following configuration copies assets from a node package:

<code-example language="json">

"assets": [
  {
    "glob": "**/*",
    "input": "./node_modules/some-package/images",
    "output": "/some-package/"
  }
]

</code-example>

The contents of `node_modules/some-package/images/` will be available in `dist/some-package/`.

The following example uses the `ignore` field to exclude certain files in the assets folder from being copied into the build:

<code-example language="json">

"assets": [
  {
    "glob": "**/*",
    "input": "src/assets/",
    "ignore": ["**/*.svg"],
    "output": "/assets/"
  }
]

</code-example>

{@a configuracion-de-estilos-y-scripts}

### Configuración de estilos y scripts

Una entrada de arreglo para las opciones de `styles` y `scripts` puede ser una cadena de ruta simple o un objeto que apunta a un archivo de punto de entrada adicional.
El constructor asociado cargará ese archivo y sus dependencias como un paquete separado durante la construcción.
Con un objeto de configuración, tienes la opción de nombrar el paquete para el punto de entrada, usando un campo `bundleName`.

El paquete se inyecta de forma predeterminada, pero puedes establecer `inject` en `false` para excluir el paquete de la inyección.
Por ejemplo, los siguientes valores de objeto crean y nombran un paquete que contiene estilos y scripts, y lo excluye de la inyección:

<code-example language="json">

"styles": [
  {
    "input": "src/external-module/styles.scss",
    "inject": false,
    "bundleName": "external-module"
  }
],
"scripts": [
  {
    "input": "src/external-module/main.js",
    "inject": false,
    "bundleName": "external-module"
  }
]

</code-example>

Puedes mezclar referencias de archivos simples y complejos para estilos y scripts.

<code-example language="json">

"styles": [
  "src/styles.css",
  "src/more-styles.css",
  { "input": "src/lazy-style.scss", "inject": false },
  { "input": "src/pre-rename-style.scss", "bundleName": "renamed-style" },
]

</code-example>

{@a preprocesador-de-estilo}

#### Opciones del preprocesador de estilo

En *Sass* puedes hacer uso de la funcionalidad `includePaths` tanto para los estilos de componentes como para los estilos globales, lo que te permite agregar rutas de base adicionales que se verificarán para las importaciones.

Para agregar rutas, usa la opción `stylePreprocessorOptions`:

<code-example language="json">

"stylePreprocessorOptions": {
  "includePaths": [
    "src/style-paths"
  ]
}

</code-example>

Los archivos en ese directorio, como `src/style-path/_variables.scss`, se pueden importar desde cualquier lugar de tu proyecto sin la necesidad de una ruta relativa:

<code-example language="typescript">

// src/app/app.component.scss
// Una ruta relativa funciona
@import '../style-paths/variables';
// Pero ahora esto también funciona
@import 'variables';

</code-example>

**NOTA**: También necesitarás agregar cualquier estilo o scripts al constructor `test` si los necesitas para las pruebas unitarias.
Consulta también [Uso de bibliotecas `runtime-global` dentro de tu aplicación](guide/using-libraries#using-runtime-global-libraries-inside-your-app).

### Configuración de optimización

La opción `optimization` del constructor del navegador puede ser un booleano o un objeto para una configuración más precisa. Esta opción permite varias optimizaciones del resultado de la compilación, que incluyen:

*   Minificación de scripts y estilos
*   Sacudidas de árbol
*   Eliminación de código muerto
*   Inserción de *CSS* crítico
*   Tipos de letra insertados

Hay varias opciones que se pueden utilizar para ajustar la optimización de una aplicación.

| Opción | Descripción | Tipo de valor | Valor predeterminado |
|:---       |:---                                                                             |:---                                                                      |:---           |
| `scripts` | Habilita la optimización de la salida de los scripts.                                     | `boolean` | `true` |
| `styles` | Permite la optimización de la salida de estilos.                                      | `boolean` \| [Opciones de optimización de estilos](#styles-optimization-options) | `true` |
| `fonts` | Habilita la optimización de los tipos de letra. <br /> **NOTA**: Esto requiere acceso a Internet. | `boolean` \| [Opciones de optimización de tipos de letra](#fonts-optimization-options) | `true` |

#### Opciones de optimización de estilos

| Option           | Description                                                                                                              | Value Type | Dafault Value |
|:---              |:---                                                                                                                      |:---        |:---           |
| `minify`         | Minify CSS definitions by removing extraneous whitespace and comments, merging identifiers and minimizing values.        | `boolean`  | `true`        |
| `inlineCritical` | Extract and inline critical CSS definitions to improve [First Contentful Paint](https://web.dev/first-contentful-paint). | `boolean`  | `true`        |

#### Opciones de optimización de tipos de letra

| Opción | Descripción | Tipo de valor | Valor predeterminado |
|:---      |:---                                                                                                                                                                                                                                  |:---        |:---           |
| `inline` | Reduce [render blocking requests](https://web.dev/render-blocking-resources) by inlining external Google Fonts and Adobe Fonts CSS definitions in the application's HTML index file. <br /> **NOTA**: Esto requiere acceso a Internet. | `boolean`  | `true`        |

You can supply a value such as the following to apply optimization to one or the other:

<code-example language="json">

"optimization": {
  "scripts": true,
  "styles": {
    "minify": true,
    "inlineCritical": true
  },
  "fonts": true
}

</code-example>

<div class="alert is-helpful">

For [Universal](guide/glossary#universal), you can reduce the code rendered in the HTML page by setting styles optimization to `true`.

</div>

### Source map configuration

The `sourceMap` browser builder option can be either a Boolean or an Object for more fine-tune configuration to control the source maps of an application.

| Option    | Description                                        | Value Type | Dafault Value |
|:---       |:---                                                |:---        |:---           |
| `scripts` | Output source maps for all scripts.                | `boolean`  | `true`        |
| `styles`  | Output source maps for all styles.                 | `boolean`  | `true`        |
| `vendor`  | Resolve vendor packages source maps.               | `boolean`  | `false`       |
| `hidden`  | Output source maps used for error reporting tools. | `boolean`  | `false`       |

The example below shows how to toggle one or more values to configure the source map outputs:

<code-example language="json">

"sourceMap": {
  "scripts": true,
  "styles": false,
  "hidden": true,
  "vendor": true
}

</code-example>

<div class="alert is-helpful">

When using hidden source maps, source maps will not be referenced in the bundle.
These are useful if you only want source maps to map error stack traces in error reporting tools, but don't want to expose your source maps in the browser developer tools.

</div>

<!-- links -->

[AioGuideI18nCommonMerge]: guide/i18n-common-merge "Common Internationalization task #6: Merge translations into the application | Angular"

<!-- end links -->

@reviewed 2021-10-14
