# Opciones del compilador *Angular*

Cuando usas [compilación *AOT*](guide/aot-compiler), puedes controlar cómo se compila tu aplicación especificando `template` opciones del compilador en el [archivo de configuración de *TypeScript*](guide/typescript-configuration).

El objeto de opciones de plantilla, `angularCompilerOptions`, es hermano del objeto `compilerOptions` que proporciona opciones estándar al compilador *TypeScript*.

<code-example language="json" header="tsconfig.json" path="angular-compiler-options/tsconfig.json" region="angular-compiler-options"></code-example>

{@a tsconfig-extends}

## Herencia de configuración con `extends`

Al igual que el compilador de *TypeScript*, el compilador de *Angular AOT* también es compatible con `extends` en la sección `angularCompilerOptions` del archivo de configuración de *TypeScript*.
La propiedad `extends` está en el nivel superior, paralelo a `compilerOptions` y `angularCompilerOptions`.

Una configuración de *TypeScript* puede heredar la configuración de otro archivo usando la propiedad `extends`.
Las opciones de configuración del archivo base se cargan primero y luego se reemplazan por las del archivo de configuración heredado.

Por ejemplo:

<code-example language="json" header="tsconfig.app.json" path="angular-compiler-options/tsconfig.app.json" region="angular-compiler-options-app"></code-example>

Para obtener más información, consulta el [Manual de *TypeScript*](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html).

## Opciones de plantilla

Las siguientes opciones están disponibles para configurar el compilador de plantillas AOT.

### `allowEmptyCodegenFiles`

Cuando es `true`, genera todos los archivos posibles incluso si están vacíos. El valor predeterminado es `false`. Utilizado por las reglas de compilación de *Bazel* para simplificar la forma en que las reglas de *Bazel* rastrean las dependencias de archivos. No uses esta opción fuera de las reglas de *Bazel*.

### `annotationsAs`

Modifica cómo se emiten las anotaciones específicas de *Angular* para mejorar la sacudida de árboles. Las anotaciones no *Angular* no se ven afectadas. Uno de los "campos `static`" (el predeterminado) o "decoradores".

*   De forma predeterminada, el compilador reemplaza a los decoradores con un campo estático en la clase, lo que permite a los agitadores de árboles avanzados como [`Closure compiler`](https://github.com/google/closure-compiler) eliminar las clases no utilizadas.
*   El valor de `decorators` deja a los decoradores en su lugar, lo que hace que la compilación sea más rápida. *TypeScript* emite llamadas al ayudante `__decorate`. Usa `--emitDecoratorMetadata` para la reflexión en tiempo de ejecución (pero ten en cuenta que el código resultante no se agitará correctamente.

### `annotateForClosureCompiler`

Cuando sea `true`, utiliza [`Tsickle`](https://github.com/angular/tsickle) para anotar el *JavaScript* emitido con los comentarios de [`JSDoc`](https://jsdoc.app/) que necesita el
[`Closure Compiler`](https://github.com/google/closure-compiler). El valor predeterminado es `false`.

### `compilationMode`

Especifica el modo de compilación que se utilizará. Están disponibles los siguientes modos:

*   `'full'` ⏤ genera código completamente compilado por *AOT* de acuerdo con la versión de *Angular* que se esté utilizando actualmente.
*   `'partial'` ⏤ genera código en una forma estable, pero intermedia, adecuada para una biblioteca publicada.

El valor predeterminado es `'full'`.

### `disableExpressionLowering`

Cuando es `true` (el valor predeterminado), transforma el código que se usa o se podría usar en una anotación, para permitir que se importe de los módulos de la fábrica de plantillas. Consulta [reescritura de metadatos](guide/aot-compiler#metadata-rewriting) para obtener más información.

Cuando es `false`, desactiva esta reescritura, lo que requiere que la reescritura se realice manualmente.

### `disableTypeScriptVersionCheck`

Cuando es `true`, el compilador no verifica la versión de *TypeScript* y no informa un error cuando se usa una versión no compatible de *TypeScript*. No se recomienda, ya que las versiones no compatibles de *TypeScript* pueden tener un comportamiento indefinido. El valor predeterminado es `false`.

### `enableI18nLegacyMessageIdFormat`

Indica al compilador de plantillas *Angular* que genere identificadores heredados para mensajes que están etiquetados en plantillas por el atributo `i18n`.
See [Mark text for translations][AioGuideI18nCommonPrepareMarkTextInComponentTemplate] for more information about marking messages for localization.

Establece esta opción en `false` a menos que tu proyecto se base en traducciones que se generaron previamente con *ID*s heredados. El valor predeterminado es `true`.

Las herramientas de extracción de mensajes anteriores a `Ivy` generaron una variedad de formatos heredados para los *ID*s de mensajes extraídos.
Estos formatos de mensaje tienen varios problemas, como el manejo de espacios en blanco y la dependencia de la información dentro del *HTML* original de una plantilla.

El nuevo formato de mensaje es más resistente a los cambios de espacios en blanco, es el mismo en todos los formatos de archivo de traducción y se puede generar directamente a partir de llamadas a `$localize`.
Esto permite que los mensajes `$localize` en el código de la aplicación usen el mismo *ID* que los mensajes `i18n` idénticos en las plantillas de componentes.

### `enableIvy`

Habilita la canalización de compilación y procesamiento de [`Ivy`](guide/ivy). El valor predeterminado es `true`, a partir de la versión 9. En la versión 9, puedes [optar por no participar en `Ivy`](guide/ivy#opting-out-of-angular-ivy) para continuar usando el compilador anterior, `View Engine`.

Para los proyectos de biblioteca generados con la *CLI*, la configuración de producción predeterminada es `false` en la versión 9.

### `enableResourceInlining`

Cuando es `true`, reemplaza la propiedad `templateUrl` y `styleUrls` en todos los decoradores de `@Component` con contenido en línea en las propiedades de `template` y `styles`.

Cuando está habilitado, la salida `.js` de `ngc` no incluye ninguna plantilla de carga diferida o `URL` de estilo.

Para los proyectos de biblioteca generados con la *CLI*, la configuración de desarrollo predeterminada es `true`.

{@a enablelegacytemplate}

### `enableLegacyTemplate`

Cuando es `true`, habilita el uso del elemento `<template>`, que fue desaprobado en *Angular 4.0*, a favor de `<ng-template>` (para evitar colisionar con el elemento *DOM* del mismo nombre). El valor predeterminado es `false`. Puede ser requerido por algunas bibliotecas *Angular* de terceros.

### `flatModuleId`

El *ID* de módulo que se utilizará para importar un módulo plano (cuando `flatModuleOutFile` es `true`). Las referencias generadas por el compilador de plantillas utilizan este nombre de módulo al importar símbolos del módulo plano. Se ignora si `flatModuleOutFile` es `false`.

### `flatModuleOutFile`

Cuando es `true`, genera un índice de módulo plano del nombre de archivo dado y los metadatos del módulo plano correspondiente. Úsalo para crear módulos planos empaquetados de manera similar a `@angular/core` y `@angular/common`. Cuando se utiliza esta opción, el `package.json` de la biblioteca debe hacer referencia al índice del módulo plano generado en lugar del archivo de índice de la biblioteca.

Produce solo un archivo `.metadata.json`, que contiene todos los metadatos necesarios para los símbolos exportados desde el índice de la biblioteca. En los archivos `.ngfactory.js` generados, el índice del módulo plano se utiliza para importar símbolos que incluyen tanto la *API* pública del índice de la biblioteca como los símbolos internos agrupados.

De manera predeterminada, se supone que el archivo `.ts` proporcionado en el campo `files` es el índice de la biblioteca.
Si se especifica más de un archivo `.ts`, se usa `libraryIndex` para seleccionar el archivo a usar.
Si se proporciona más de un archivo `.ts` sin un `libraryIndex`, se produce un error.

Se crea un índice de módulo plano `.d.ts` y `.js` con el nombre `flatModuleOutFile` dado en la misma ubicación que el archivo de índice de biblioteca `.d.ts`.

Por ejemplo, si una biblioteca usa el archivo `public_api.ts` como índice de biblioteca del módulo, el campo `tsconfig.json` `files` sería ["`public_api.ts`"].
La opción `flatModuleOutFile` entonces se podría establecer en (por ejemplo) `"index.js"`, que produce archivos `index.d.ts` e `index.metadata.json`.
El campo `module` del `package.json` de la biblioteca sería `" index.js"` y el campo `typings` sería `"index.d.ts"`.

### `fullTemplateTypeCheck`

Cuando es `true` (recomendado), habilita la fase [validación de expresión de enlace](guide/aot-compiler#validacion-de-expresion-de-enlace) del compilador de plantilla, que utiliza *TypeScript* para validar las expresiones de enlace. Para obtener más información, consulta [Comprobación del tipo de plantilla](guide/template-typecheck).

El valor predeterminado es `false`, pero cuando usas el comando `ng new --strict` de la *CLI*, se establece en `true` en la configuración del proyecto generado.

<div class="alert is-important">

La opción `fullTemplateTypeCheck` ha quedado obsoleta en *Angular 13* a favor de la familia de opciones del compilador `strictTemplates`.

</div>

### `generateCodeForLibraries`

Cuando es `true` (el valor predeterminado), genera archivos de fábrica (`.ngfactory.js` y `.ngstyle.js`) para archivos `.d.ts` con un archivo `.metadata.json` correspondiente.

Cuando es `false`, los archivos de fábrica se generan solo para los archivos `.ts`. Haz esto cuando utilices resúmenes de fábrica.

### `preserveWhitespaces`

Cuando es `false` (el valor predeterminado), elimina los nodos de texto en blanco de las plantillas compiladas, lo que da como resultado la emisión de módulos de fábrica de plantillas más pequeños. Establece el valor `true` para conservar los nodos de texto en blanco.

### `skipMetadataEmit`

Cuando es `true`, no produce archivos `.metadata.json`. El valor predeterminado es `false`.

Los archivos `.metadata.json` contienen información que necesita el compilador de plantillas de un archivo `.ts` que no está incluido en el archivo `.d.ts` producido por el compilador *TypeScript*.
Esta información incluye, por ejemplo, el contenido de las anotaciones (como la plantilla de un componente), que *TypeScript* emite al archivo `.js` pero no al archivo `.d.ts`.

Lo puedes establecer en `true` cuando utilices resúmenes de fábrica, porque los resúmenes de fábrica incluyen una copia de la información que se encuentra en el archivo `.metadata.json`.

Establécelo en `true` si estás utilizando la opción `--outFile` de *TypeScript*, porque los archivos de metadatos no son válidos para este estilo de salida de *TypeScript*. Sin embargo, no recomendamos usar `--outFile` con *Angular*. En su lugar, utiliza un paquete, como [`webpack`](https://webpack.js.org/).

### `skipTemplateCodegen`

Cuando es `true`, no emite archivos `.ngfactory.js` ni `.ngstyle.js`. Esto apaga la mayor parte del compilador de plantillas y deshabilita los informes de diagnóstico de plantillas.

Se puede usar para instruir al compilador de plantillas para que produzca archivos `.metadata.json` para su distribución con un paquete `npm` mientras se evita la producción de archivos `.ngfactory.js` y `.ngstyle.js` que no se pueden distribuir a ` npm`.

Para los proyectos de biblioteca generados con la *CLI*, la configuración de desarrollo predeterminada es `true`.

### `strictMetadataEmit`

Cuando es `true`, informa un error al archivo `.metadata.json` si `"skipMetadataEmit"` es `false`.
El valor predeterminado es `false`. Úsalo solo cuando `"skipMetadataEmit"` sea `false` y `"skipTemplateCodegen"` sea `true`.

Esta opción está destinada a validar los archivos `.metadata.json` emitidos para empaquetarlos con un paquete `npm`. La validación es estricta y puede emitir errores para los metadatos que nunca producirían un error cuando los usa el compilador de plantillas. Puedes optar por suprimir el error emitido por esta opción para un símbolo exportado al incluir `@dynamic` en el comentario que documenta el símbolo.

Es válido para archivos `.metadata.json` para contener errores.
El compilador de plantillas informa de estos errores si los metadatos se utilizan para determinar el contenido de una anotación.
El recopilador de metadatos no puede predecir los símbolos que están diseñados para su uso en una anotación, por lo que incluye de forma preventiva nodos de error en los metadatos para los símbolos exportados.
El compilador de plantillas puede utilizar los nodos de error para informar de un error si se utilizan estos símbolos.

Si el cliente de una biblioteca tiene la intención de usar un símbolo en una anotación, el compilador de plantillas normalmente no informa de esto hasta que el cliente usa el símbolo.
Esta opción permite la detección de estos errores durante la fase de compilación de la biblioteca y se utiliza, por ejemplo, para producir las propias bibliotecas *Angular*.

Para los proyectos de biblioteca generados con la *CLI*, la configuración de desarrollo predeterminada es `true`.

### `strictInjectionParameters`

Cuando es `true` (recomendado), informa un error para un parámetro proporcionado cuyo tipo de inyección no se puede determinar. Cuando es `false` (actualmente el valor predeterminado), los parámetros del constructor de las clases marcadas con "@Injectable" cuyo tipo no se puede resolver producen una advertencia.

Cuando usas el comando *CLI* `ng new --strict`, se establece en `true` en la configuración del proyecto generado.

### `strictTemplates`

Cuando es `true`, habilita la [verificación estricta del tipo de plantilla](guide/template-typecheck#modo-estricto). El modo estricto solo está disponible cuando se usa [`Ivy`](guide/ivy) (versión *Angular 9* y posteriores).

Los indicadores de rigurosidad adicionales te permiten habilitar y deshabilitar tipos específicos de verificación de tipo de plantilla estricta. Consulta [solución de problemas de errores de plantilla](guide/template-typecheck#troubleshooting-template-errors).

Cuando usas el comando *CLI* `ng new --strict`, se establece en `true` en la configuración del proyecto generado.

### `trace`

Cuando es `true`, imprime información adicional mientras se compilan las plantillas. El valor predeterminado es `false`.

{@a cli-options}

## Opciones de línea de comandos

Si bien la mayoría de las veces interactúa con el compilador *Angular* indirectamente mediante la *CLI* de *Angular*, al depurar ciertos problemas, puede resultarte útil invocar el compilador *Angular* directamente.
Puedes usar el comando `ngc` proporcionado por el paquete `npm`  `@angular/compiler-cli` para llamar al compilador desde la línea de comandos.

El comando `ngc` es solo un envoltorio del comando del compilador `tsc` de *TypeScript* y se configura principalmente a través de las opciones de configuración `tsconfig.json` documentadas en [las secciones anteriores](#angular-compiler-options).

Además del archivo de configuración, también puedes usar [opciones de línea de comandos `tsc`](https://www.typescriptlang.org/docs/handbook/compiler-options.html) para configurar `ngc`.

<!-- links -->

[AioGuideI18nCommonPrepareMarkTextInComponentTemplate]: guide/i18n-common-prepare#mark-text-in-component-template "Mark text in component template - Prepara plantillas para traducciones | *Angular*"

<!-- end links -->

@reviewed 2021-10-13
