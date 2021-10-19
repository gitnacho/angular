# Desplegar una aplicación

Desplegar tu aplicación es el proceso de compilar o construir tu código y alojar *JavaScript*, *CSS* y *HTML* en un servidor web.

Esta sección se basa en los pasos anteriores de la [Introducción](start "Pruébala: Una aplicación básica") y te muestra cómo desplegar tu aplicación.

## Requisitos previos

Una práctica recomendada es ejecutar tu proyecto localmente antes de desplegarlo. Para ejecutar tu proyecto localmente, necesitas lo siguiente instalado en tu computadora:

* [*Node.js*](https://nodejs.org/en/).
* La [*CLI* de *Angular*](https://cli.angular.io/).
    Desde la terminal, instala *Angular CLI* globalmente con:

    ```sh
    npm install -g @angular/cli
    ```

    Con la *CLI* de *Angular*, puedes usar el comando `ng` para crear nuevos espacios de trabajo, nuevos proyectos, servir tu aplicación durante el desarrollo o producir compilaciones para compartir o distribuir.

## Ejecutar tu aplicación localmente

1. Descarga el código fuente de tu proyecto *StackBlitz* haciendo clic en el icono `Download project` en el menú de la izquierda, a través de `Project`, para descargar tus archivos.

1. Crea un nuevo espacio de trabajo de *Angular CLI* usando el comando [`ng new`](cli/new "referencia del comando new de la CLI"), donde `my-project-name` es como te gustaría llamar a tu proyecto:

    ```sh
    ng new my-project-name
    ```
    
    Este comando muestra una serie de mensajes de configuración. Para este tutorial, acepta la configuración predeterminada para cada solicitud.

1. En su nueva aplicación generada por la *CLI*, reemplaza el directorio `/src` con el directorio `/src` de tu descarga de `StackBlitz`.

1. Utiliza el siguiente comando de la *CLI* para ejecutar tu aplicación localmente:

    ```sh
    ng serve
    ```

1. Para ver tu aplicación en el navegador, ve a *http://localhost:4200/*.
    Si el puerto predeterminado 4200 no está disponible, puedes especificar otro puerto con el indicador de puerto como en el siguiente ejemplo:

     ```sh
    ng serve --port 4201
    ```

    Mientras sirves tu aplicación, puedes editar tu código y ver que los cambios se actualizan automáticamente en el navegador.
    Para detener el comando `ng serve`, presiona `Ctrl` + `c`.

{@a building}
## Construir y hospedar tu aplicación

 1. Para construir tu aplicación para producción, usa el comando `build`. De forma predeterminada, este comando usa la configuración de compilación `production`.

    ```sh
    ng build
    ```

    Este comando crea un directorio `dist` en el directorio raíz de la aplicación con todos los archivos que un servicio de alojamiento necesita para atender tu aplicación.

    <div class="alert is-helpful">

    Si el comando `ng build` anterior arroja un error sobre paquetes faltantes, agrega las dependencias faltantes en el archivo `package.json` de tu proyecto local para que coincida con el del proyecto *StackBlitz* descargado.

    </div>

1. Copia el contenido del directorio `dist/my-project-name` a tu servidor web.
    Debido a que estos archivos son estáticos, puedes alojarlos en cualquier servidor web capaz de servir archivos; como `Node.js`, *Java*, *.NET* o cualquier *backend* como [*Firebase*](https://firebase.google.com/docs/hosting), [*Google Cloud*](https://cloud.google.com/solutions/web-hosting) o [*App Engine*](https://cloud.google.com/appengine/docs/standard/python/getting-started/hosting-a-static-website).
    Para obtener más información, consulta [Creación y servicio](guide/build "Crear y servir aplicaciones Angular") y [Despliegue](guide/deployment "Guía de despliegue").

## ¿Qué sigue?

En este tutorial, has sentado las bases para explorar el mundo *Angular* en áreas como el desarrollo móvil, el desarrollo de *UX*/*IU* y la representación del lado del servidor.
Puedes profundizar más estudiando más de las características de *Angular*, interactuando con la comunidad vibrante y explorando el ecosistema robusto.

### Aprender más *Angular*

Para obtener un tutorial más detallado que lo guía a través de la creación de una aplicación localmente y la exploración de muchas de las funciones más populares de *Angular*, consulta [*Tour of Heroes*](tutorial).

Para explorar los conceptos fundamentales de *Angular*, consulta las guías en la sección *Comprender *Angular**, como [Descripción general de componentes *Angular*](guide/component-overview) o [Sintaxis de plantillas](guide/template-syntax).

### Únete a la comunidad


[Tuitea que has completado este tutorial](https://twitter.com/intent/tweet?url=https://angular.io/start&text=I%20just%20finished%20the%20Angular%20Getting%20Started%20Tutorial "Angular en Twitter"), dinos lo que piensas o envía [sugerencias para ediciones futuras](https://github.com/angular/angular/issues/new/choose "Formulario de nueva edición del repositorio de Angular en GitHub").

Mantente actualizado siguiendo el [Blog de *Angular*](https://blog.angular.io/ "Blog de *Angular*").

### Explora el ecosistema *Angular*

Para respaldar tu desarrollo de *UX*/*IU*, consulta [*Angular Material*](https://material.angular.io/ "Sitio web de Angular Material").

La comunidad *Angular* también tiene una extensa [red de herramientas y bibliotecas de terceros](resources "Lista de recursos Angular").

@reviewed 2021-09-15
