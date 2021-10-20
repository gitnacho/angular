# Agregar navegación

Esta guía se basa en el primer paso del tutorial de introducción, [Empieza con una aplicación *Angular* básica](start "Empieza con una aplicación Angular básica").

En esta etapa de desarrollo, la aplicación de la tienda en línea tiene un catálogo de productos básico.

En las siguientes secciones, agregarás las siguientes características a la aplicación:

* Escribe una *URL* en la barra de direcciones para navegar a la página del producto correspondiente.
* Haz clic en los enlaces de la página para navegar dentro de tu aplicación de una sola página.
* Haz clic en los botones de avance y retroceso del navegador para navegar por el historial del navegador de forma intuitiva.

{@a definir-rutas}

## Asociar una ruta de *URL* con un componente

La aplicación ya usa el `Router` de *Angular* para navegar al `ProductListComponent`.
Esta sección te muestra cómo definir una ruta para mostrar detalles de productos individuales.

1. Genera un nuevo componente para los detalles del producto.
    En la lista de archivos, haz clic con el botón derecho en el directorio `app`, elige `Angular Generator` y `Component`.
    Nombra al componente `product-details`.

1. En `app.module.ts`, agrega una ruta para los detalles del producto, con una `path` de `products/:productId` y `ProductDetailsComponent` para el `component`, incluye `ProductDetailsComponent` en las declaraciones de `AppModule`.

    <code-example header="src/app/app.module.ts" path="getting-started/src/app/app.module.ts" region="product-details-route">
    </code-example>

1. Abre `product-list.component.html`.

1. Modifica el nombre del ancla del producto para incluir un `routerLink` con el `product.id` como parámetro.

    <code-example header="src/app/product-list/product-list.component.html" path="getting-started/src/app/product-list/product-list.component.html" region="router-link">
    </code-example>

    La directiva `RouterLink` te ayuda a personalizar el elemento de ancla.
    En este caso, la ruta, o *URL*, contiene un segmento fijo, `/products`.
    El segmento final es variable, insertando la propiedad `id` del producto actual.
    Por ejemplo, la *URL* de un producto con un `id` de 1 sería similar a `https://Getting-started-myfork.stackblitz.io/products/1`.

 1. Verifica que el enrutador funcione según lo previsto haciendo clic en el nombre del producto.
    La aplicación debería mostrar el `ProductDetailsComponent`, que actualmente dice "¡product-details funciona!"

    Observa que cambia la *URL* en la ventana de vista previa.
    El segmento final es `products/#" donde "#" es el número de la ruta en la que hiciste clic.

    <div class="lightbox">
      <img src="generated/images/guide/start/product-details-works.png" alt="Vista de detalles del producto con URL actualizada">
    </div>

## Ver detalles del producto

El `ProductDetailsComponent` maneja la visualización de cada producto.
El enrutador *Angular* muestra componentes basados ​​en la *URL* del navegador y [tus rutas definidas](#definir-rutas).

En esta sección, usarás el enrutador *Angular* para combinar los datos de `products` y la información de ruta para mostrar los detalles específicos de cada producto.

1. En `product-details.component.ts`, importa `ActivatedRoute` desde `@angular/router`, y el arreglo `products` desde `../products`.

    <code-example header="src/app/product-details/product-details.component.ts" path="getting-started/src/app/product-details/product-details.component.1.ts" region="imports">
    </code-example>

1. Define la propiedad `product`.

    <code-example header="src/app/product-details/product-details.component.ts" path="getting-started/src/app/product-details/product-details.component.1.ts" region="product-prop">
    </code-example>

1. Inyecta `ActivatedRoute` en el `constructor()` agregando `private route: ActivatedRoute` como argumento entre paréntesis del constructor.

    <code-example header="src/app/product-details/product-details.component.ts" path="getting-started/src/app/product-details/product-details.component.1.ts" region="props-methods">
    </code-example>

    `ActivatedRoute` es específico para cada componente que carga el enrutador *Angular*.
    `ActivatedRoute` contiene información sobre la ruta y los parámetros de la ruta.

    Al inyectar `ActivatedRoute`, estás configurando el componente para usar un servicio.
    El paso [Gestionar datos](start/start-data "Pruébalo: Gestionar datos") cubre los servicios con más detalle.

1. En el método `ngOnInit()`, extrae el `productId` de los parámetros de ruta y busca el producto correspondiente en el arreglo `products`.

    <code-example path="getting-started/src/app/product-details/product-details.component.1.ts" header="src/app/product-details/product-details.component.ts" region="get-product">
    </code-example>

    Los parámetros de la ruta corresponden a las variables de ruta que defines en la ruta.
    Para acceder a los parámetros de la ruta, usamos `route.snapshot`, que es el `ActivatedRouteSnapshot` que contiene información sobre la ruta activa en ese momento en particular.
    La *URL* que coincide con la ruta proporciona el `productId`.
    *Angular* usa el `productId` para mostrar los detalles de cada producto único.

1. Actualiza la plantilla `ProductDetailsComponent` para mostrar los detalles del producto con una directiva `*ngIf`.
    Si existe un producto, el `<div>` se representa con un nombre, precio y descripción.

    <code-example header="src/app/product-details/product-details.component.html" path="getting-started/src/app/product-details/product-details.component.html" region="details">
    </code-example>

    La línea, `<h4>{{ product.price | currency }}</h4>`, utiliza la tubería `currency` para transformar `product.price` de un número a una cadena de moneda.
    Una tubería es una forma en que puedes transformar datos en tu plantilla *HTML*.
    Para obtener más información sobre tuberías *Angular*, consulta [Tuberías](guide/pipes "Tuberías").

Cuando los usuarios hacen clic en un nombre en la lista de productos, el enrutador los dirige a la *URL* distinta del producto, muestra el `ProductDetailsComponent` y muestra los detalles del producto.

<div class="lightbox">
  <img src="generated/images/guide/start/product-details-routed.png" alt="Página de detalles del producto con URL actualizada y todos los detalles mostrados">
</div>

Para obtener más información sobre el enrutador *Angular*, consulta [Enrutador y navegación](guide/router "Guía del enrutador y navegación").

## ¿Qué sigue?

Has configurado tu aplicación para que pueda ver los detalles del producto, cada uno con una *URL* distinta.

Para continuar explorando *Angular*:

* Continúe con [Gestión de datos](start/start-data "Pruébala: Gestión de datos") para agregar una función de carrito de compras, administrar los datos del carrito y recuperar datos externos para los precios de envío.
* Ve a [Despliegue](start/start-deployment "Pruébalo: Despliegue") para desplegar tu aplicación en *Firebase* o pasar al desarrollo local.

@reviewed 2021-09-15
