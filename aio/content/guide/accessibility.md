# Accesibilidad en *Angular*

La web es utilizada por una amplia variedad de personas, incluidas aquellas que tienen discapacidades visuales o motoras.
Hay disponible una variedad de tecnologías de asistencia que facilitan mucho a estos grupos
interactuar con aplicaciones de software basadas en la web.
Además, diseñar una aplicación para que sea más accesible generalmente mejora la experiencia del usuario para todos los usuarios.

Para obtener una introducción detallada a los problemas y las técnicas para diseñar aplicaciones accesibles, consulta la sección [Accesibilidad](https://developers.google.com/web/fundamentals/accessibility/#what_is_accessibility) de la [Web Fundamentals](https : //developers.google.com/web/fundamentals/)  de *Google*.

Esta página analiza las mejores prácticas para diseñar aplicaciones *Angular* que
funcionan bien para todos los usuarios, incluidos aquellos que dependen de las tecnologías de asistencia.

<div class="alert is-helpful">

  Para ver la aplicación de ejemplo que describe esta página, consulta <live-example></live-example>.

</div>

## Atributos de accesibilidad

Crear una experiencia web accesible a menudo implica establecer [atributos *ARIA*](https://developers.google.com/web/fundamentals/accessibility/semantics-aria)
para proporcionar un significado semántico donde de otro modo podría faltar.
Utiliza la sintaxis de la plantilla [enlace de atributo](guide/attribute-binding) para controlar los valores de los atributos relacionados con la accesibilidad.

Cuando se vincula a los atributos *ARIA* en *Angular*, debes usar el prefijo `attr`, como
la especificación *ARIA* depende específicamente de los atributos *HTML* en lugar de las propiedades de los elementos *DOM*.

```HTML
<!-- Usa attr. cuando se vincula a un atributo ARIA -->
<button [attr.aria-label]="myActionLabel">...</button>
```

Ten en cuenta que esta sintaxis solo es necesaria para los enlazar atributos.
Los atributos *ARIA* estáticos no requieren sintaxis adicional.

```HTML
<!-- Los atributos *ARIA* estáticos no requieren sintaxis adicional -->
<button aria-label="Save document">...</button>
```

<div class="alert is-helpful">

   Por convención, los atributos *HTML* usan nombres en minúsculas (`tabindex`), mientras que las propiedades usan nombres `camelCase` (`tabIndex`).

   Consulta la guía [Sintaxis de enlace](guide/binding-syntax#html-attribute-vs-dom-property) para obtener más información sobre la diferencia entre atributos y propiedades.

</div>


## Componentes de la interfaz de usuario *Angular*

La biblioteca [Material *Angular*](https://material.angular.io/), que es mantenida por el equipo de *Angular*, es un conjunto de componentes de interfaz de usuario reutilizables que pretende ser totalmente accesible.
El [Kit de desarrollo de componentes (*KDC*)](https://material.angular.io/cdk/categories) incluye el paquete `a11y` que proporciona herramientas para admitir diversas áreas de accesibilidad.
Por ejemplo:

* `LiveAnnouncer` se utiliza para anunciar mensajes para usuarios de lectores de pantalla que utilizan una región `aria-live`. Consulta la documentación del *W3C* para obtener más información sobre [regiones `aria-live`](https://www.w3.org/WAI/PF/aria-1.1/states_and_properties#aria-live).

* La directiva `cdkTrapFocus` atrapa el foco de la tecla *Tab* dentro de un elemento. Úselo para crear una experiencia accesible para componentes como los diálogos modales, donde el enfoque debe estar restringido.

Para obtener detalles completos de estas y otras herramientas, consulta la [Descripción general de accesibilidad de *KDC Angular*](https://material.angular.io/cdk/a11y/overview).


### Aumento de elementos nativos

Los elementos *HTML* nativos capturan una serie de patrones de interacción estándar que son importantes para la accesibilidad.
Al crear componentes de *Angular*, debes reutilizar estos elementos nativos directamente cuando sea posible, en lugar de volver a implementar comportamientos bien soportados.

Por ejemplo, en lugar de crear un elemento personalizado para una nueva variedad de botones, crea un componente que use un selector de atributos con un elemento `<button>` nativo.
Esto se aplica comúnmente a `<button>` y `<a>`, pero se puede usar con muchos otros tipos de elementos.

Puedes ver ejemplos de este patrón en *Material Angular*: [`MatButton`](https://github.com/angular/components/blob/50d3f29b6dc717b512dbd0234ce76f4ab7e9762a/src/material/button/button.ts#L67-L69), [`MatTabNav`](https://github.com/angular/components/blob/50d3f29b6dc717b512dbd0234ce76f4ab7e9762a/src/material/tabs/tab-nav-bar/tab-nav-bar.ts#L139), [`MatTable`](https://github.com/angular/components/blob/50d3f29b6dc717b512dbd0234ce76f4ab7e9762a/src/material/table/table.ts#L22).

### Usar contenedores para elementos nativos

A veces, el uso del elemento nativo apropiado requiere un elemento contenedor.
Por ejemplo, el elemento `<input>` nativo no puede tener hijos, por lo que cualquier componente de entrada de texto personalizado necesita
envolver un `<input>` con elementos adicionales.
Si bien puedes incluir el `<input>` en la plantilla de tu componente personalizado,
esto hace que sea imposible para los usuarios del componente establecer propiedades y atributos arbitrarios para el elemento de entrada.
En su lugar, crea un componente contenedor que utilice la proyección de contenido para incluir el control nativo en la
*API* del componente.

Puedes ver [`MatFormField`](https://material.angular.io/components/form-field/overview) como un ejemplo de este patrón.

## Caso de estudio: Construir una barra de progreso personalizada

El siguiente ejemplo muestra cómo hacer que una barra de progreso sea accesible mediante el enlace de *host* para controlar los atributos relacionados con la accesibilidad.

* El componente define un elemento habilitado para la accesibilidad con el atributo *HTML* estándar `role` y los atributos *ARIA*. El atributo *ARIA* `aria-valuenow` está vinculado a la entrada del usuario.

   <code-example path="accessibility/src/app/progress-bar.component.ts" header="src/app/progress-bar.component.ts" region="progressbar-component"></code-example>


* En la plantilla, el atributo `aria-label` asegura que el control sea accesible para los lectores de pantalla.

   <code-example path="accessibility/src/app/app.component.html" header="src/app/app.component.html" region="template"></code-example>


## Gestión de enrutamiento y enfoque

El seguimiento y control de [`focus`](https://developers.google.com/web/fundamentals/accessibility/focus/) en una interfaz de usuario es una consideración importante en el diseño de accesibilidad.
Al usar el enrutamiento *Angular*, debes decidir dónde se centra el enfoque de la página en la navegación.

Para evitar depender únicamente de las señales visuales, debes asegurarte de que las actualizaciones de tu código de enrutamiento se centren después de la navegación de la página.
Utiliza el evento `NavigationEnd` del servicio `Router` para saber cuándo actualizar
el `focus`.

El siguiente ejemplo muestra cómo buscar y enfocar el encabezado del contenido principal en el *DOM* después de la navegación.

```ts

router.events.pipe(filter(e => e instanceof NavigationEnd)).subscribe(() => {
  const mainHeader = document.querySelector('#main-content-header')
  if (mainHeader) {
    mainHeader.focus();
  }
});

```
En una aplicación real, el elemento que recibe el foco dependerá de la
estructura y diseño de la aplicación.
El elemento enfocado debe poner a los usuarios en una posición para moverse inmediatamente al contenido principal que acaba de ser mostrado.
Debes evitar situaciones en las que el foco vuelva al elemento `body` después de un cambio de ruta.


## Recursos adicionales

* [Accesibilidad ⏤ *Google Web Fundamentals*](https://developers.google.com/web/fundamentals/accessibility)

* [Especificación de *ARIA* y prácticas de autoría](https://www.w3.org/TR/wai-aria/)

* [*Material Design* ⏤ Accesibilidad](https://material.io/design/usability/accessibility.html)

* [*Smashing Magazine*](https://www.smashingmagazine.com/search/?q=accessibility)

* [Componentes inclusivos](https://inclusive-components.design/)

* [Recursos de accesibilidad y ejemplos de código](https://dequeuniversity.com/resources/)

* [*W3C* ⏤ Iniciativa de accesibilidad web](https://www.w3.org/WAI/people-use-web/)

* [*Rob Dodson* `A11ycasts`](https://www.youtube.com/watch?v=HtTyRajRuyY)

* [*Angular ESLint*](https://github.com/angular-eslint/angular-eslint#functionality) proporciona reglas de lucimiento que pueden ayudarte para garantizar que tu código cumpla con los estándares de accesibilidad.

Libros

* "Una web para todos: Diseño de experiencias de usuario accesibles", Sarah Horton y Whitney Quesenbery

* "Patrones de diseño inclusivo", Heydon Pickering
