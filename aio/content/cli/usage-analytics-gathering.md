# Gathering and Viewing Usage Analytics

Users can opt in to share their Angular CLI usage data with [Google Analytics](https://support.google.com/analytics/answer/1008015?hl=en), using the [`ng analytics` CLI command](analytics).
The data is also shared with the Angular team, and used to improve the CLI.

The gathering of CLI analytics data is disabled by default, and must be enabled at the project level by individual users.
It cannot be enabled at the project level for all users.

Data gathered in this way can be viewed on the Google Analytics site, but is not automatically visible on your own organization's Analytics site.
As an administrator for an Angular development group, you can configure your instance of Angular CLI to be able to see analytics data for your own team's usage of the Angular CLI.
This configuration option is separate from and in addition to other usage analytics that your users may be sharing with Google.

## Enable access to CLI usage data

Para configurar el acceso al uso de datos de la *CLI* de tus propios usuarios, usa el comando `ng config` para agregar una clave a tu [archivo de configuración del espacio de trabajo `angular.json` global](guide/workspace-config).
La clave se encuentra debajo de `cli.analyticsSharing` en el nivel superior del archivo, fuera de las secciones de `projects`.
El valor de la clave es el *ID* de seguimiento de tu organización, asignado por *Google Analytics*.
Este *ID* es una cadena que se parece a `UA-123456-12`.

Puedes optar por utilizar una cadena descriptiva como valor clave o que se te asigne una clave aleatoria cuando ejecutes el comando *CLI*.
Por ejemplo, el siguiente comando agrega una clave de configuración llamada "tracking".

<code-example language="sh">
ng config --global cli.analyticsSharing.tracking UA-123456-12
</code-example>

Para desactivar esta característica, ejecuta el siguiente comando:

<code-example language="sh">
ng config --global cli.analyticsSharing undefined
</code-example>

## Seguimiento por usuario

Puedes agregar un *ID* de usuario personalizado a la configuración global para identificar el uso exclusivo de comandos y banderas.
Si ese usuario habilita *CLI analytics* para su propio proyecto, tu análisis muestra el seguimiento y etiqueta de su uso individual.

<code-example language="sh">
ng config --global cli.analyticsSharing.uuid ALGUN_NOMBRE_DE_USUARIO
</code-example>

Para generar un nuevo *ID* de usuario aleatorio, ejecuta el siguiente comando:

<code-example language="sh">
ng config --global cli.analyticsSharing.uuid ""
</code-example>
