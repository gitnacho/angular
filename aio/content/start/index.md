# Empezar con *Angular*

¡Bienvenido a *Angular*!

Este tutorial te presenta los conceptos básicos de *Angular* y te guía a través de la creación de un sitio de comercio electrónico con un catálogo, un carrito de compras y un formulario de pago.

Para ayudarte a comenzar de inmediato, este tutorial utiliza una aplicación lista para desplegar que puedes examinar y modificar de forma interactiva en [*StackBlitz*](https://stackblitz.com/), sin tener que [configurar un entorno de trabajo local](guide/setup-local "Guía de configuración").
*StackBlitz* es un entorno de desarrollo basado en navegador donde puedes crear, guardar y compartir proyectos utilizando una variedad de tecnologías.

## Requisitos previos

Para aprovechar al máximo este tutorial, ya debes tener un conocimiento básico de lo siguiente:

* [*HTML*](https://developer.mozilla.org/es/docs/Learn/HTML "Aprende *HTML*: Guías y tutoriales")
* [*JavaScript*](https://developer.mozilla.org/es/docs/Web/JavaScript "JavaScript")
* [*TypeScript*](https://www.typescriptlang.org/ "El lenguaje TypeScript")


{@a componentes}
## Haz un recorrido por la aplicación de ejemplo

Construye aplicaciones *Angular* con componentes.
Los componentes definen áreas de responsabilidad en la interfaz de usuario que te permiten reutilizar conjuntos de funciones de la interfaz de usuario.

Un componente consta de tres cosas:

* **Una clase `Component`** que maneja datos y funcionalidad.
* **Una plantilla *HTML*** que determina la interfaz de usuario.
* **Componentes específicos de estilos** que definen el aspecto y sensación.

Esta guía demuestra la creación de una aplicación con los siguientes componentes.

* `<app-root>`&mdash;el primer componente a cargar y el contenedor para los otros componentes.
* `<app-top-bar>`&mdash;el nombre de la tienda y el botón de pago.
* `<app-product-list>`&mdash;la lista de productos.
* `<app-product-alerts>`&mdash;un componente que contiene las alertas de la aplicación.

<div class="lightbox">
  <img src="generated/images/guide/start/app-components.png" alt="Tienda online con tres componentes">
</div>

Para obtener más información sobre los componentes, consulta la [Introducción a los componentes](guide/architecture-components "Introducción a los componentes y a las plantillas").


{@a nuevo-proyecto}

## Crea el proyecto de ejemplo

Para crear el proyecto de ejemplo, genera el proyecto `<live-example name="Getting-started-v0" noDownload>` de ejemplo listo para usar en `StackBlitz</live-example>`.
Para guardar tu trabajo:

1. Inicia sesión en *StackBlitz*.
1. Bifurca el proyecto que generaste.
1. Guarda periódicamente.

En *StackBlitz*, el panel de vista previa a la derecha muestra el estado inicial de la aplicación de ejemplo.
La vista previa presenta dos áreas:

* una barra superior con el nombre de la tienda, *My Store* y un botón de pago
* un encabezado para una lista de productos, *`Products`*

<div class="lightbox">
  <img src="generated/images/guide/start/new-app-all.gif" alt="Inicio  de la aplicación de tienda en línea">
</div>

La sección del proyecto a la izquierda muestra los archivos fuente que componen la aplicación, incluida la infraestructura y los archivos de configuración.

Cuando generas las aplicaciones de ejemplo de *StackBlitz* que acompañan a los tutoriales, *StackBlitz* crea los archivos de inicio y los datos simulados por ti.
Los archivos que usas a lo largo del tutorial se encuentran en el directorio `src`.

Para obtener más información sobre cómo utilizar *StackBlitz*, consulta la [documentación de *StackBlitz*](https://developer.stackblitz.com/docs/platform/).

{@a product-list}
## Crea la lista de productos

En esta sección, actualizarás la aplicación para mostrar una lista de productos.
Utilizarás datos de productos predefinidos del archivo `products.ts` y métodos del archivo `product-list.component.ts`.
Esta sección te guía a través de la edición del *HTML*, también conocido como `template`, es decir, la plantilla.

1. En el directorio `product-list`, abre el archivo de plantilla `product-list.component.html`.

1. Agrega una directiva estructural `*ngFor` en un `<div>`, de la siguiente manera.

  <code-example header="src/app/product-list/product-list.component.html" path="getting-started/src/app/product-list/product-list.component.2.html" region="ngfor">
  </code-example>

  Con `*ngFor`, el `<div> `se repite para cada producto de la lista.

  Las directivas estructurales dan forma o remodelan la estructura del *DOM*, agregando, quitando y manipulando elementos.
  Para obtener más información sobre las directivas estructurales, consulta [Directivas estructurales](guide/structural-directives).

1. Dentro del `<div>`, agrega un `<h3>` y `{{ product.name }}`.
  La declaración `{{ product.name }}` es un ejemplo de la sintaxis de interpolación de *Angular*.
  La interpolación `{{ }}` te permite representar el valor de la propiedad como texto.

  <code-example path="getting-started/src/app/product-list/product-list.component.2.html" header="src/app/product-list/product-list.component.html" region="interpolation">
</code-example>

  El panel de vista previa se actualiza para mostrar el nombre de cada producto en la lista.

  <div class="lightbox">
    <img src="generated/images/guide/start/template-syntax-product-names.png" alt="Nombres de productos agregados a la lista">
  </div>

1. Para que el nombre de cada producto sea un enlace a los detalles del producto, agrega el elemento `<a>` alrededor de `{{ product.name }}`.

1. Establece el título para que sea el nombre del producto utilizando la sintaxis de enlace de propiedad `[ ]`, de la siguiente manera:

    <code-example path="getting-started/src/app/product-list/product-list.component.2.html" header="src/app/product-list/product-list.component.html">
    </code-example>

    En el panel de vista previa, coloca el cursor sobre el nombre de un producto para ver el valor de la propiedad del nombre enlazado, que es el nombre del producto más la palabra *"`details`"*.
    El enlace de propiedad `[ ]` te permite usar el valor de la propiedad en una expresión de plantilla.

    <div class="lightbox">
      <img src="generated/images/guide/start/template-syntax-product-anchor.png" alt="El texto del ancla del nombre del producto es la propiedad `name` del `product`">
    </div>

1. Agrega las descripciones de los productos. En un elemento `<p>`, usa una directiva `*ngIf` para que *Angular* solo cree el elemento `<p>` si el producto actual tiene una descripción.

    <code-example path="getting-started/src/app/product-list/product-list.component.3.html" header="src/app/product-list/product-list.component.html">
    </code-example>

    La aplicación ahora muestra el nombre y la descripción de cada producto en la lista.
    Ten en cuenta que el producto final no tiene un párrafo de descripción.
    *Angular* no crea el elemento `<p>` porque la propiedad `description` del producto está vacía.

    <div class="lightbox">
      <img src="generated/images/guide/start/template-syntax-product-description.png" alt="Se agregaron las descripciones de los productos a la lista">
    </div>

1. Agrega un botón para que los usuarios puedan compartir un producto.
  Vincula el evento `click` del botón al método `share()` en `product-list.component.ts`. El enlace de eventos usa un conjunto de paréntesis, `( )`, alrededor del evento, como en el evento `(clic)` en el elemento `<button>`.

    <code-example path="getting-started/src/app/product-list/product-list.component.4.html" header="src/app/product-list/product-list.component.html">
    </code-example>

    Cada producto ahora tiene un botón **`Share`**.

    <div class="lightbox">
      <img src="generated/images/guide/start/template-syntax-product-share-button.png" alt="Se agregó el botón Share para cada producto">
    </div>

    Hacer clic en el botón **`Share`** activa una alerta que dice: "¡El producto ha sido compartido!".

    <div class="lightbox">
      <img src="generated/images/guide/start/template-syntax-product-share-alert.png" alt="Cuadro de alerta que indica que el producto se ha compartido">
    </div>

Al editar la plantilla, has explorado algunas de las características más populares de las plantillas *Angular*.
Para obtener más información, consulta [Introducción a componentes y plantillas](guide/architecture-components#sintaxis-de-plantillas "Sintaxis de plantillas").

{@a pasar-datos-a}

## Pasar datos a un componente secundario

Actualmente, la lista de productos muestra el nombre y la descripción de cada producto.
El `ProductListComponent` también define una propiedad `products` que contiene datos importados para cada producto del arreglo `products` en `products.ts`.

El siguiente paso es crear una nueva función de alerta que utilice datos de productos del `ProductListComponent`.
La alerta verifica el precio del producto y, si el precio es superior a $700, muestra un botón **`Notify Me`** que permite a los usuarios registrarse para recibir notificaciones cuando el producto sale a la venta.

Esta sección te guía a través de la creación de un componente secundario, `ProductAlertsComponent` que puede recibir datos de su componente contenedor, `ProductListComponent`.

1. Haz clic derecho en el directorio `app` y usa el `Generador Angular` para generar un nuevo componente llamado `product-alerts`.

  <div class="lightbox">
    <img src="generated/images/guide/start/generate-component.png" alt="Comando StackBlitz para generar componentes">
  </div>

    El generador crea archivos de inicio para las tres partes del componente:
    * `product-alerts.component.ts`
    * `product-alerts.component.html`
    * `product-alerts.component.css`

1. Abre `product-alerts.component.ts`.
  El decorador `@Component()` indica que la siguiente clase es un componente.
  `@Component()` también proporciona metadatos sobre el componente, incluido su selector, plantilla y estilos.

  <code-example header="src/app/product-alerts/product-alerts.component.ts" path="getting-started/src/app/product-alerts/product-alerts.component.1.ts" region="as-generated"></code-example>

  Las características clave de `@Component()` son las siguientes:

    * El `selector`, `app-product-alerts`, identifica el componente.
      Por convención, los selectores de componentes *Angular* comienzan con el prefijo `app-`, seguido del nombre del componente.
    * Los nombres de archivos de plantilla y estilos hacen referencia al *HTML* y *CSS* del componente.
    * La definición de `@Component()` también exporta la clase, `ProductAlertsComponent`, que maneja la funcionalidad del componente.

1. Para configurar `ProductAlertsComponent` para recibir datos del producto, primero importa `Input` desde `@angular/core`.

  <code-example path="getting-started/src/app/product-alerts/product-alerts.component.1.ts" region="imports" header="src/app/product-alerts/product-alerts.component.ts"></code-example>

1. En la definición de la clase `ProductAlertsComponent`, define una propiedad llamada `product` con un decorador `@Input()`.
  El decorador `@Input()` indica que el valor de la propiedad pasa del contenedor del componente, `ProductListComponent` en este caso.

  <code-example path="getting-started/src/app/product-alerts/product-alerts.component.1.ts" region="input-decorator" header="src/app/product-alerts/product-alerts.component.ts"></code-example>

1. Abre `product-alerts.component.html` y reemplaza el párrafo del marcador de posición con un botón **`Notify Me`** que aparece si el precio del producto es superior a $700.

  <code-example header="src/app/product-alerts/product-alerts.component.html" path="getting-started/src/app/product-alerts/product-alerts.component.1.html"></code-example>

1. Para que `ProductAlertsComponent` esté disponible para otros componentes de la aplicación, agrégalo a las declaraciones de `AppModule` en `app.module.ts`.

  <code-example header="src/app/app.module.ts" path="getting-started/src/app/app.module.ts" region="declare-product-alerts"></code-example>

1. Finalmente, para mostrar `ProductAlertsComponent` como un elemento secundario de `ProductListComponent`, agrega el selector, `<app-product-alerts>` a `product-list.component.html`.
  Pasa el producto actual como entrada al componente mediante el enlace de propiedad.

  <code-example header="src/app/product-list/product-list.component.html" path="getting-started/src/app/product-list/product-list.component.5.html" region="app-product-alerts"></code-example>

El componente de alerta de nuevo producto toma un producto como entrada de la lista de productos.
Con esa entrada, muestra u oculta el botón **`Notify Me`**, basándose en el precio del producto.
El precio del *Phone XL* es de más de $700, por lo que el botón **`Notify Me`** aparece en ese producto.

<div class="lightbox">
  <img src="generated/images/guide/start/product-alert-button.png" alt="Botón de alerta de producto agregado a productos de más de $700">
</div>

{@a output}

## Pasar datos al contenedor de un componente

Para hacer que trabaje el botón **`Notify Me`**, el componente secundario debe notificar y pasar los datos al contenedor del componente.
El `ProductAlertsComponent` necesita emitir un evento cuando el usuario hace clic en **`Notify Me`** y el `ProductListComponent` debe responder al evento.

  <div class="alert is-helpful">

  En los nuevos componentes, el `Generador Angular` incluye un `constructor()` vacío, la interfaz `OnInit` y el método `ngOnInit()`.
  Dado que estos pasos no los usan, los siguientes ejemplos de código los omiten por brevedad.

  </div>

1. En `product-alerts.component.ts`, importa `Output` y `EventEmitter` desde `@angular/core`.

  <code-example header="src/app/product-alerts/product-alerts.component.ts" path="getting-started/src/app/product-alerts/product-alerts.component.ts" region="imports"></code-example>

1. En la clase del componente, define una propiedad llamada `notify` con un decorador `@Output()` y una instancia de `EventEmitter()`.
  Configurar `ProductAlertsComponent` con un `@Output()` permite que `ProductAlertsComponent` emita un evento cuando cambia el valor de la propiedad `notify`.

  <code-example path="getting-started/src/app/product-alerts/product-alerts.component.ts" header="src/app/product-alerts/product-alerts.component.ts" region="input-output"></code-example>

1. En `product-alerts.component.html`, actualiza el botón **`Notify Me`** con un enlace de evento para llamar al método `notify.emit()`.

    <code-example header="src/app/product-alerts/product-alerts.component.html" path="getting-started/src/app/product-alerts/product-alerts.component.html"></code-example>

1. Define el comportamiento que ocurre cuando el usuario hace clic en el botón.
  El contenedor ⏤en este caso⏤ `ProductListComponent`&mdash; no el `ProductAlertsComponent`&mdash; actúa cuando el secundario que genera el evento.
  En `product-list.component.ts`, define un método `onNotify()`, similar al método `share()`.

  <code-example header="src/app/product-list/product-list.component.ts" path="getting-started/src/app/product-list/product-list.component.ts" region="on-notify"></code-example>

1. Actualiza el `ProductListComponent` para recibir datos del `ProductAlertsComponent`.

  En `product-list.component.html`, vincula `<app-product-alerts>` al método `onNotify()` del componente de la lista de productos.
  `<app-product-alerts>` es el que muestra el botón **`Notify Me`**

    <code-example header="src/app/product-list/product-list.component.html" path="getting-started/src/app/product-list/product-list.component.6.html" region="on-notify"></code-example>

1. Haz clic en el botón **`Notify Me`** para activar una alerta que dice: "Se te notificará cuando el producto salga a la venta".

  <div class="lightbox">
    <img src="generated/images/guide/start/product-alert-notification.png" alt="Cuadro de diálogo de confirmación de notificación de alerta de producto">
  </div>

Para obtener más información sobre la comunicación entre componentes, consulta [Interacción de componentes](guide/component-interaction "Interacción de componentes").

{@a que-sigue}

## ¿Qué sigue?

En esta sección, has creado una aplicación que itera a través de datos y presenta componentes que se comunican entre sí.

Para continuar explorando *Angular* y desarrollar esta aplicación:

* Continúa con [Navegar en la aplicación](start/start-routing "Para comenzar: A navegar en la aplicación") para crear una página de detalles del producto.
* Ve a [Desplegar](start/start-deployment "Para comenzar: A desplegar") para pasar al desarrollo local o desplegar tu aplicación en *Firebase* o en tu propio servidor.
