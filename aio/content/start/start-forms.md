# Usar formularios para la entrada del usuario

Esta guía se basa en [Gestión de datos](start/start-data "Pruébala: Gestión de datos") del tutorial de introducción, [Empezar con una aplicación *Angular* básica](start "Empezar con una aplicación Angular básica").

Esta sección te guía a través de la adición de una función de pago basada en formularios para recopilar información del usuario como parte del pago.

## Definir el modelo del formulario de pago

Este paso te muestra cómo configurar el modelo del formulario de pago en la clase `Component`.
El modelo de formulario determina el estado del formulario.

1. Abre `cart.component.ts`.

1. Importa el servicio `FormBuilder` del paquete `@angular/forms`.
  Este servicio proporciona métodos convenientes para generar controles.

  <code-example header="src/app/cart/cart.component.ts" path="getting-started/src/app/cart/cart.component.ts" region="imports">
  </code-example>

1. Inyecta el servicio `FormBuilder` en el `constructor()` de `CartComponent`.
  Este servicio es parte del módulo `ReactiveFormsModule`, que ya has importado.

  <code-example header="src/app/cart/cart.component.ts" path="getting-started/src/app/cart/cart.component.ts" region="inject-form-builder">
  </code-example>

1. Para recopilar el nombre y la dirección del usuario, utiliza el método `group()` de `FormBuilder` para establecer la propiedad `checkoutForm` en un modelo de formulario que contenga los campos `name` y `address`.

  <code-example header="src/app/cart/cart.component.ts" path="getting-started/src/app/cart/cart.component.ts" region="checkout-form-group"></code-example>

1. Define un método `onSubmit()` para procesar el formulario.
  Este método permite a los usuarios enviar su nombre y dirección.
  Además, este método utiliza el método `clearCart()` del `CartService` para restablecer el formulario y limpiar el carrito.

  Toda la clase del componente `cart` es la siguiente:

  <code-example header="src/app/cart/cart.component.ts" path="getting-started/src/app/cart/cart.component.ts">
  </code-example>

## Crea el formulario de pago

Utiliza los siguientes pasos para agregar un formulario de pago en la parte inferior de la vista `cart`.

1. En la parte inferior de `cart.component.html`, agrega un elemento *HTML* `<form>` y un botón **Purchase**.

1. Utiliza un enlace de propiedad `formGroup` para vincular `checkoutForm` al `<form>` *HTML*.

  <code-example header="src/app/cart/cart.component.html" path="getting-started/src/app/cart/cart.component.3.html" region="checkout-form">
  </code-example>

1. En la etiqueta `form`, usa un enlace de evento `ngSubmit` para escuchar el envío del formulario y llama al método `onSubmit()` con el valor `checkoutForm`.

  <code-example path="getting-started/src/app/cart/cart.component.html" header="src/app/cart/cart.component.html (cart component template detail)" region="checkout-form-1">
  </code-example>

1. Agrega campos `<input>` para `name` y `address`, cada uno con un atributo `formControlName` que se une a los controles del formulario `checkoutForm` para `name` y `address` a sus campos `<input>`.
  El componente completo es el siguiente:

  <code-example path="getting-started/src/app/cart/cart.component.html" header="src/app/cart/cart.component.html" region="checkout-form-2">
  </code-example>

Después de poner algunos artículos en el carrito, los usuarios pueden revisar sus artículos, ingresar su nombre y dirección y enviar su compra.

<div class="lightbox">
  <img src='generated/images/guide/start/cart-with-items-and-form.png' alt="Vista del carrito con formulario de pago">
</div>

Para confirmar el envío, abre la consola para ver un objeto que contiene el nombre y la dirección de envió.

## ¿Qué sigue?

Tienes una aplicación de tienda en línea completa con un catálogo de productos, un carrito de compras y una función de pago.

[Continúa con la sección "Despliegue"](start/start/deployment "Pruébala: Despliegue") para pasar al desarrollo local o implementar tu aplicación en *Firebase* o en tu propio servidor.

@reviewed 2021-09-15
