# Desarrollo remoto de *VSCode* ⏤ Desarrollando dentro de un contenedor

Este directorio contiene archivos de configuración que se pueden usar para optar por trabajar en este repositorio en un [contenedor *Docker*](https://www.docker.com/resources/what-container) a través de [*VSCode*](https://code.Visualstudio.com/) de la función de desarrollo remoto (ve más abajo).

Información sobre desarrollo remoto y desarrollo dentro de un contenedor con *VSCode*:
- [*VSCode*: Desarrollo remoto](https://code.visualstudio.com/docs/remote/remote-overview)
- [*VSCode*: Desarrollo dentro de un contenedor](https://code.visualstudio.com/docs/remote/containers)
- [*VSCode*: Preguntas frecuentes sobre desarrollo remoto](https://code.visualstudio.com/docs/remote/faq)


## Uso

_Prerequisito: [Instala *Docker*](https://docs.docker.com/install) en tu entorno local._

Para comenzar, lee y sigue las instrucciones en [Desarrollo dentro de un contenedor](https://code.visualstudio.com/docs/remote/containers). El directorio [`.devcontainer/`](.) Contiene archivos `devcontainer.json` y `Dockerfile` preconfigurados, que puedes usar para configurar el desarrollo remoto con un contenedor de *Docker*.

En pocas palabras, necesitas:
- Instalar la extensión [Contenedor ⏤ Remoto](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
- Copia [`recommended-Dockerfile`](./recommended-Dockerfile) en `Dockerfile` (y, opcionalmente, modifícalo para adaptarlo a tus necesidades).
- Copia [`recommended-devcontainer.json`](./recommended-devcontainer.json) en `devcontainer.json` (y, opcionalmente, modifícalo para adaptarlo a tus necesidades).
- Abre *VSCode* y abre la [Paleta de comandos](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette).
- Tipo `Remote-Containers: Abre Directorio en Contenedor` y elige tu clon local de [`angular`/`angular`](https://github.com/angular/angular).

Los archivos `.devcontainer/devcontainer.json` y `.devcontainer/Dockerfile` son ignorados por `git`, por lo que puedes tener tus propias versiones locales. Es posible que ocasionalmente actualicemos los archivos de plantilla ([`recommended-devcontainer.json`](./recommended-devcontainer.json), [`recommended-Dockerfile`](./recommended-Dockerfile)), en cuyo caso deberás actualizar manualmente tus copias (si lo deseas).


## Actualización de `recommended-devcontainer.json` y `recommended-Dockerfile`

Puedes actualizar y confirmar los archivos de configuración recomendados (que la gente usa como base para sus configuraciones locales), si encuentras que algo está roto, desactualizado o se puede mejorar.

Por favor, ten en cuenta que los cambios que realices potencialmente serán utilizados por muchas personas en diferentes entornos. Intenta mantener estos archivos de configuración compatibles entre plataformas y libres de preferencias personales.
