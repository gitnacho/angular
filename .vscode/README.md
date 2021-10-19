# Configuración de *VSCode*

Este directorio contiene [Configuración del espacio de trabajo](https://code.visualstudio.com/docs/getstarted/settings), [Tareas](https://code.visualstudio.com/docs/editor/tasks), [Configuraciones de lanzamiento](https://code.visualstudio.com/Docs/editor/debugging#_launch-configurations) y [Recomendaciones de extensión](https://code.visualstudio.com/docs/editor/extension-gallery#_workspace-recommended-extensions) que el equipo de *Angular* recomienda usar cuando se trabaja en este repositorio.

## Uso

Para utilizar las configuraciones recomendadas, sigue los pasos a continuación:

- instala las extensiones recomendadas en `.vscode/extensions.json`
- copia (o vincula) `.vscode/recommended-settings.json` a `.vscode/settings.json`
- copia (o enlaza) `.vscode/recommended-launch.json` a `.vscode/launch.json`
- copia (o vincula) `.vscode/recommended-tasks.json` a `.vscode/tasks.json`
- reinicia el editor

Si ya tienes personalizada la configuración de tu espacio de trabajo, debes fusionar manualmente el contenido del archivo.

Este no es un proceso automático, por lo que deberás repetirlo cuando se actualice la configuración.

Para ver las extensiones recomendadas, selecciona "Extensiones: Muestra extensiones recomendadas" en la [Paleta de comandos](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette).

## Edición de archivos `.vscode/recommended-*. Json`

Si deseas agregar elementos de configuración adicionales, ten en cuenta que cualquier modificación que realices aquí será utilizada por muchos usuarios.

Intenta mantener estos ajustes/configuraciones para cosas que ayuden a facilitar el proceso de desarrollo y evita alterar el flujo de trabajo del usuario siempre que sea posible.
