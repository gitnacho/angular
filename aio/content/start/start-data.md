# Manejo de datos

Esta guía se basa en el segundo paso del tutorial [Introducción a una aplicación *Angular* básica](start), [Adición de navegación](start/start-routing "Adición de navegación").
En esta etapa de desarrollo, la aplicación de la tienda tiene un catálogo de productos con dos vistas: una lista de productos y detalles del producto.
Los usuarios pueden hacer clic en el nombre de un producto de la lista para ver los detalles en una nueva vista, con una *URL* o ruta distinta.

Este paso del tutorial te guía a través de la creación de un carrito de compras en las siguientes fases:

* Actualiza la vista de detalles del producto para incluir un botón de **Compra**, , que agrega el producto actual a una lista de productos que administra un servicio de carrito.
* Agrega un componente `cart`, que muestra los artículos en el carrito.
* Agrega un componente de envío, que recupera los precios de envío de los artículos en el carrito mediante el uso de `HttpClient` de *Angular* para recuperar los datos de envío desde un archivo `.json`.

{@a create-cart-service}

## Crea el servicio de carrito de compras

En *Angular*, un servicio es una instancia de una clase que puedes poner a disposición de cualquier parte de tu aplicación usando el [sistema de inyección de dependencia](guide/glossary#inyeccion-de-dependencia-id "Definición de inyección de dependencia") de *Angular*.

Actualmente, los usuarios pueden ver la información del producto y la aplicación puede simular el intercambio y las notificaciones sobre los cambios del producto.

El siguiente paso es crear una forma para que los usuarios agreguen productos a un carrito.
Esta sección te guía a través de la adición de un botón **Buy** y configura un servicio de carrito para almacenar información sobre los productos en el carrito.

{@a generate-cart-service}

### Definir un servicio de carrito

1. Para generar un servicio de carrito, haz clic con el botón derecho en el directorio `app`, elige `Generador Angular` y escoge `Service`.
    Nombra el nuevo servicio `cart`.

    <code-example header="src/app/cart.service.ts" path="getting-started/src/app/cart.service.1.ts"></code-example>

1. Importa la interfaz `Product` de `./Products.js`.
1. En la clase `CartService`, define una propiedad de `items` para almacenar el arreglo de los productos actuales en el carrito.

    <code-example path="getting-started/src/app/cart.service.ts" header="src/app/cart.service.ts" region="props"></code-example>

1. Define métodos para agregar artículos al carrito, devolver artículos del carrito y borrar los artículos del carrito.

    <code-example path="getting-started/src/app/cart.service.ts" header="src/app/cart.service.ts" region="methods"></code-example>

    * El método `addToCart()` agrega un producto a un arreglo de `items`.

    * El método `getItems()` recopila los artículos que los usuarios agregan al carrito y devuelve cada artículo con su cantidad asociada.

    * El método `clearCart()` devuelve un arreglo vacío de elementos, que vacía el carrito.

{@a product-details-use-cart-service}

### Utiliza el servicio `cart`

Esta sección te guía a través del uso de `CartService` para agregar un producto al carrito.

1. En `product-details.component.ts`, importa el servicio `cart`.

    <code-example header="src/app/product-details/product-details.component.ts" path="getting-started/src/app/product-details/product-details.component.ts" region="cart-service">
    </code-example>

1. Inyecta el servicio `cart` agregándolo al `constructor()`.

    <code-example path="getting-started/src/app/product-details/product-details.component.ts" header="src/app/product-details/product-details.component.ts" region="inject-cart-service">
        </code-example>

1. Define el método `addToCart()`, que agrega el producto actual al carrito.

    <code-example path="getting-started/src/app/product-details/product-details.component.ts" header="src/app/product-details/product-details.component.ts" region="add-to-cart"></code-example>

    El método `addToCart()` hace lo siguiente:
    * Toma el `product` actual como argumento.
    * Utiliza el método `addToCart()` de `CartService` para agregar el producto al carrito.
    * Muestra un mensaje de que has agregado un producto al carrito.

1. En `product-details.component.html`, agrega un botón con la etiqueta **Buy**, y vincula el evento `click()` al método `addToCart()`.
    Este código actualiza la plantilla de detalles del producto con un botón **Buy** que agrega el producto actual al carrito.

    <code-example header="src/app/product-details/product-details.component.html" path="getting-started/src/app/product-details/product-details.component.html">
    </code-example>

1. Verifica que el nuevo botón **Buy** aparece como se esperaba al actualizar la aplicación y hacer clic en el nombre de un producto para mostrar sus detalles.

    <div class="lightbox">
      <img src='generated/images/guide/start/product-details-buy.png' alt="Display details for selected product with a Buy button">
    </div>

 1. Haz clic en el botón **Buy** para agregar el producto a la lista almacenada de artículos en el carrito y mostrar un mensaje de confirmación.

    <div class="lightbox">
      <img src='generated/images/guide/start/buy-alert.png' alt="Muestra detalles del producto seleccionado con un botón Buy">
    </div>

## Crea la vista del carrito

Para que los clientes vean su carrito, puedes crear la vista del carrito en dos pasos:

1. Crea un componente `cart` y configura el enrutamiento al nuevo componente.
1. Muestra los artículos del carrito.

### Configura el componente `cart`

 Para crear la vista del carrito, sigue los mismos pasos que llevaste a cabo para crear el `ProductDetailsComponent` y configura el enrutamiento para el nuevo componente.

1. Genera un componente para el carrito llamado `cart` haciendo clic con el botón derecho en el directorio `app`, eligiendo `Generador Angular` y `Component`.

    <code-example header="src/app/cart/cart.component.ts" path="getting-started/src/app/cart/cart.component.1.ts"></code-example>

    *StackBlitz* también genera un `ngOnInit()` de manera predeterminada en los componentes.  Puedes ignorar el `CartComponent` `ngOnInit()` para este tutorial.

1. Asegúrate de que el `CartComponent` recién creado se agregue a las `declarations` del módulo en `app.module.ts`.

    <code-example header="src/app/app.module.ts" path="getting-started/src/app/app.module.ts" region="declare-cart">
    </code-example>

1. Aún en `app.module.ts`, agrega una ruta para el componente `CartComponent`, con una `path` de `cart`.

    <code-example header="src/app/app.module.ts" path="getting-started/src/app/app.module.ts" region="cart-route">
    </code-example>

1. Actualiza el botón **Checkout** para que se dirija a la *URL* `/cart`.
    En `top-bar.component.html`, agrega una directiva `routerLink` que apunte a `/cart`.

    <code-example header="src/app/top-bar/top-bar.component.html" path="getting-started/src/app/top-bar/top-bar.component.html" region="cart-route">
    </code-example>

1. Verifica que el nuevo `CartComponent` funciona como se esperaba haciendo clic en el botón **Checkout**.
    ¡Puedes ver el "carrito funciona!" texto predeterminado, y la *URL* tiene el patrón `https://Getting-started.stackblitz.io/cart`, donde `Getting-started.stackblitz.io` puede ser diferente para tu proyecto *StackBlitz*.

    <div class="lightbox">
      <img src='generated/images/guide/start/cart-works.png' alt="Muestra la vista de carrito antes de personalizar">
    </div>

### Mostrar los artículos del carrito

Esta sección te muestra cómo utilizar el servicio de carrito para mostrar los productos en el carrito.


1. En `cart.component.ts`, importa el `CartService` del archivo `cart.service.ts`.

    <code-example header="src/app/cart/cart.component.ts" path="getting-started/src/app/cart/cart.component.2.ts" region="imports">
    </code-example>

1. Inyecta el `CartService` para que el `CartComponent` lo pueda usar agregándolo al `constructor()`.

    <code-example path="getting-started/src/app/cart/cart.component.2.ts" header="src/app/cart/cart.component.ts" region="inject-cart">
    </code-example>

1. Define la propiedad `items` para almacenar los productos en el carrito.

    <code-example path="getting-started/src/app/cart/cart.component.2.ts" header="src/app/cart/cart.component.ts" region="items">
    </code-example>

    Este código establece los elementos usando el método `getItems()` de `CartService`.
    Definiste este método [cuando creaste `cart.service.ts`](#generate-cart-service).

1. Actualiza la plantilla del carrito con un encabezado y usa un `<div>` con un `*ngFor` para mostrar cada uno de los elementos del carrito con su nombre y precio.
    La plantilla `CartComponent` resultante es la siguiente.

    <code-example header="src/app/cart/cart.component.html" path="getting-started/src/app/cart/cart.component.2.html" region="prices">
    </code-example>

1. Verifica que tu carrito funciona como se esperaba:

    * Haz clic en **My Store**
    * Haz clic en el nombre de un producto para mostrar sus detalles.
    * Haz clic en el botón **Buy** para agregar el producto al carrito.
    * Haz clic en **Checkout** para ver el carro.

    <div class="lightbox">
      <img src='generated/images/guide/start/cart-page-full.png' alt="Cart view with products added">
    </div>

Para obtener más información sobre los servicios, consulta [Introducción a los servicios y la inyección de dependencia](guide/architecture-services "Conceptos > Introducción a los servicios e ID").

## Recuperar precios de envío

Los servidores a menudo devuelven datos en forma de flujo.
Los flujos son útiles porque facilitan la transformación de los datos devueltos y la modificación de la forma en que solicitas esos datos.
`HttpClient` de *Angular* es una forma integrada de obtener datos de *API*s externas y proporcionarlos a tu aplicación como un flujo.

Esta sección te muestra cómo usar `HttpClient` para recuperar los precios de envío de un archivo externo.

La aplicación que *StackBlitz* genera para esta guía viene con datos de envío predefinidos en `assets/shipping.json`.
Utiliza estos datos para agregar los precios de envío de los artículos en el carrito.

<code-example header="src/assets/shipping.json" path="getting-started/src/assets/shipping.json">
</code-example>

### Configura `AppModule` para usar `HttpClient`

Para usar el `HttpClient` de *Angular*, debes configurar tu aplicación para usar `HttpClientModule`.

El `HttpClientModule` de *Angular* registra los proveedores que tu aplicación necesita para usar el servicio `HttpClient` en toda tu aplicación.

1. En `app.module.ts`, importe `HttpClientModule` del paquete `@angular/common/http` en la parte superior del archivo con las otras importaciones.
    Como hay varias otras importaciones, este fragmento de código las omite por brevedad.
    Asegúrate de dejar las importaciones existentes en su lugar.

    <code-example header="src/app/app.module.ts" path="getting-started/src/app/app.module.ts" region="http-client-module-import">
    </code-example>

1. Para registrar los proveedores `HttpClient` de *Angular* globalmente, agrega `HttpClientModule` a el arreglo `imports` de `@NgModule()` en `AppModule`.

    <code-example path="getting-started/src/app/app.module.ts" header="src/app/app.module.ts" region="http-client-module">
    </code-example>

### Configura `CartService` para usar `HttpClient`

El siguiente paso es inyectar el servicio `HttpClient` en tu servicio para que tu aplicación pueda obtener datos e interactuar con *API*s y recursos externos.

1. En `cart.service.ts`, import `HttpClient` desde el paquete `@angular/common/http`.

    <code-example header="src/app/cart.service.ts" path="getting-started/src/app/cart.service.ts" region="import-http">
    </code-example>

1. Inyecta `HttpClient` en el `constructor()` de `CartService` .

    <code-example path="getting-started/src/app/cart.service.ts" header="src/app/cart.service.ts" region="inject-http">
    </code-example>

### Configura `CartService` para obtener los precios de envío

Para obtener datos de envío, desde `shipping.json`, puedes usar el método  `get()` de `HttpClient`.

1. En `cart.service.ts`, debajo del método `clearCart()`, define un nuevo método `getShippingPrices()` que utilice el método `get()` de `HttpClient`.

    <code-example header="src/app/cart.service.ts" path="getting-started/src/app/cart.service.ts" region="get-shipping"></code-example>

Para obtener más información sobre el `HttpClient` de *Angular*, consulta la guía [Interacción cliente-servidor](guide/http "Interacción del servidor a través de HTTP").

## Crea un componente de envío

Ahora que has configurado tu aplicación para recuperar datos de envío, puedes crear un lugar para representar esos datos.

1. Genera un nuevo componente llamado `shipping` haciendo clic con el botón derecho en el directorio `app`, eligiendo el `Generador Angular` y selecciona `Component`.

    <code-example header="src/app/shipping/shipping.component.ts" path="getting-started/src/app/shipping/shipping.component.1.ts"></code-example>

1. En `app.module.ts`, agrega una ruta para el envío.
    Especifica una `path` de `shipping` y un componente de `ShippingComponent`.

    <code-example header="src/app/app.module.ts" path="getting-started/src/app/app.module.ts" region="shipping-route"></code-example>

    Todavía no hay un enlace al nuevo componente de envío, pero puedes ver su plantilla en el panel de vista previa ingresando la *URL* que especifica su ruta.
    La *URL* tiene el patrón: `https://Getting-started.stackblitz.io/shipping` donde la parte `Getting-started.stackblitz.io` puede ser diferente para tu proyecto *StackBlitz*.

### Configura el `ShippingComponent` para usar `CartService`

Esta sección te guía a través de la modificación del `ShippingComponent` para recuperar los datos de envío a través de *HTTP* del archivo `shipping.json`.

1. En `shipping.component.ts`, importa `CartService`.

    <code-example header="src/app/shipping/shipping.component.ts" path="getting-started/src/app/shipping/shipping.component.ts" region="imports"></code-example>

1. Inyecta el servicio de carrito en el `constructor()` de `ShippingComponent`.

    <code-example path="getting-started/src/app/shipping/shipping.component.ts" header="src/app/shipping/shipping.component.ts" region="inject-cart-service"></code-example>

1. Define una propiedad `shippingCosts` que establezca la propiedad `shippingCosts` usando el método `getShippingPrices()` del `CartService`.

    <code-example path="getting-started/src/app/shipping/shipping.component.ts" header="src/app/shipping/shipping.component.ts" region="props"></code-example>

1. Actualiza la plantilla `ShippingComponent` para mostrar los tipos de envío y los precios utilizando la tubería `async`.

    <code-example header="src/app/shipping/shipping.component.html" path="getting-started/src/app/shipping/shipping.component.html"></code-example>

    La tubería `async` devuelve el último valor de un flujo de datos y continúa haciéndolo durante la vida útil de un determinado componente.
    Cuando *Angular* destruye ese componente, la tubería `async` se detiene automáticamente.
    Para obtener información detallada sobre la tubería `async`, consulta la [documentación de la *API* de `AsyncPipe`](/api/common/AsyncPipe).

1. Agrega un enlace desde la vista `CartComponent` a la vista `ShippingComponent`.

    <code-example header="src/app/cart/cart.component.html" path="getting-started/src/app/cart/cart.component.2.html"></code-example>

1. Haz clic en el botón **Checkout** para ver el carrito actualizado.
    Recuerda que cambiar la aplicación hace que se actualice la vista previa, lo que vacía el carrito.

    <div class="lightbox">
      <img src='generated/images/guide/start/cart-empty-with-shipping-prices.png' alt="Carrito con enlace a precios de envío">
    </div>

    Haz clic en el enlace para navegar a los precios de envío.

    <div class="lightbox">
      <img src='generated/images/guide/start/shipping-prices.png' alt="Muestra precios de envío">
    </div>

## ¿Qué sigue?

Ahora tienes una aplicación de tienda con un catálogo de productos, un carrito de compras y puedes buscar precios de envío.

Para continuar explorando *Angular*:

* Continúa con [Formularios para la entrada del usuario](start/start-forms "Formularios para entrada del usuario") para finalizar la aplicación agregando la vista del carrito de compras y un formulario de pago.
* Ve a [Despliegue](start/start-deployment "Despliegue") para pasar al desarrollo local o desplegar tu aplicación en *Firebase* o en tu propio servidor.
