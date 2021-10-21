# Introducción a las animaciones *Angular*

La animación proporciona la ilusión de movimiento: Los elementos *HTML* cambian de estilo con el tiempo. Las animaciones bien diseñadas pueden hacer que tu aplicación sea más divertida y sencilla de usar, pero no son solo cosméticos. Las animaciones pueden mejorar tu aplicación y la experiencia del usuario de varias formas:

* Sin animaciones, las transiciones de páginas web pueden parecer abruptas y discordantes.

* El movimiento mejora en gran medida la experiencia del usuario, por lo que las animaciones brindan a los usuarios la oportunidad de detectar la respuesta de la aplicación a sus acciones.

* Las buenas animaciones llaman la atención del usuario de forma intuitiva hacia donde se necesita.

Por lo general, las animaciones involucran múltiples estilos de *transformaciones* a través del tiempo. Un elemento *HTML* se puede mover, cambiar de color, crecer o encogerse, desvanecerse o deslizarse fuera de la página. Estos cambios pueden ocurrir de forma simultánea o secuencial. Puedes controlar el momento de cada transformación.

El sistema de animación de *Angular* se basa en la funcionalidad *CSS*, lo que significa que puedes animar cualquier propiedad que el navegador considere animable. Esto incluye posiciones, tamaños, transformaciones, colores, bordes y más. El *W3C* mantiene una lista de propiedades animables en su página de [Transiciones *CSS*](https://www.w3.org/TR/css-transitions-1/).


## Sobre esta guía

Esta guía cubre las funciones básicas de animación *Angular* para comenzar a agregar animaciones *Angular* a tu proyecto.

Las funciones descritas en esta guía &mdash; y las funciones más avanzadas descritas en las guías de animaciones *Angular* relacionadas &mdash; se muestran en una aplicación de ejemplo disponible como `<live-example></live-example>`.

#### Requisitos previos

La guía asume que estás familiarizado con la creación de aplicaciones *Angular* básicas, como se describe en las siguientes secciones:

* [*Tutorial*](tutorial)
* [Descripción general de la arquitectura](guide/architecture)


## Primeros pasos

Los principales módulos de *Angular* para animaciones son `@angular/animations` y `@angular/platform-browser`. Cuando creas un nuevo proyecto con la *CLI*, estas dependencias se agregan automáticamente a tu proyecto.

Para comenzar a agregar animaciones *Angular* a tu proyecto, importa los módulos específicos de animación junto con la funcionalidad *Angular* estándar.

### Paso 1: Habilitar el módulo `animations`

Importa `BrowserAnimationsModule`, que introduce la capacidad de animación en tu módulo raíz de la aplicación *Angular*.

<code-example path="animations/src/app/app.module.1.ts" header="src/app/app.module.ts" language="typescript"></code-example>

<div class="alert is-helpful">

**Nota**: Cuando usas la *CLI* para crear tu aplicación, el módulo de la aplicación raíz `app.module.ts` se coloca en el directorio `src/app`.
</div>

### Paso 2: Importar funciones de animación en archivos de componentes

Si planeas usar funciones de animación específicas en archivos de componentes, importa esas funciones desde `@angular/animations`.

<code-example path="animations/src/app/app.component.ts" header="src/app/app.component.ts" region="imports" language="typescript">
</code-example>

<div class="alert is-helpful">

**Nota**: Consulta un [resumen de las funciones de animación disponibles](guide/animations#resumen-de-la-api-de-animacion) al final de esta guía.
</div>

### Paso 3: Agregar la propiedad de metadatos de animación

En el archivo del componente, agrega una propiedad de metadatos llamada `animations:` dentro del decorador `@Component()`. Pones el disparador que define una animación dentro de la propiedad `animations` de metadatos.

<code-example path="animations/src/app/app.component.ts" header="src/app/app.component.ts" region="decorator" language="typescript">
</code-example>

## Animar una transición

Animemos una transición que cambia un solo elemento *HTML* de un estado a otro. Por ejemplo, puedes especificar que un botón muestre **Abierto** o **Cerrado** basado en la última acción del usuario. Cuando el botón está en el estado `open`, es visible y amarillo. Cuando es el estado `closed`, es translúcido y azul.

En *HTML*, estos atributos se establecen mediante estilos *CSS* habituales, como el color y la opacidad. En *Angular*, usa la función `style()` para especificar un conjunto de estilos *CSS* para usar con animaciones. Recopila un conjunto de estilos en un estado de animación y asigna un nombre al estado, como `open` o `closed`.

<div class="alert is-helpful">

  Creemos un nuevo componente `open-close` para animar con transiciones simples.

  Ejecuta el siguiente comando en la terminal para generar el componente:

  `ng g component open-close`

  Esto creará el componente en `src/app/open-close.component.ts`.
</div>

### Estilos y estado de animación

Utiliza la función `state()` de *Angular* para definir diferentes estados para llamar al final de cada transición. Esta función toma dos argumentos: un nombre único como `open` o `closed` y una función `style()`.

Utiliza la función `style()` para definir un conjunto de estilos para asociarlos con un nombre de estado dado. Debes usar [*camelCase*](guide/glossary#convenciones-de-casos) para los atributos de estilo que contienen guiones, como `backgroundColor` o envolverlos entre comillas, como`'background-color'`.

Veamos cómo trabaja la función `state()` de *Angular* con la función `style⁣(⁠)` para establecer los atributos de estilo *CSS*. En este fragmento de código, se establecen varios atributos de estilo al mismo tiempo para el estado. En el estado `open`, el botón tiene una altura de 200 píxeles, una opacidad de 1 y un color de fondo amarillo.

<code-example path="animations/src/app/open-close.component.ts" header="src/app/open-close.component.ts" region="state1" language="typescript">
</code-example>

En el siguiente estado `closed`, el botón tiene una altura de 100 píxeles, una opacidad de 0.8 y un color de fondo azul.

<code-example path="animations/src/app/open-close.component.ts" header="src/app/open-close.component.ts" region="state2" language="typescript">
</code-example>

### Transiciones y coordinación

En *Angular*, puedes establecer varios estilos sin ninguna animación. Sin embargo, sin más refinamiento, el botón se transforma instantáneamente sin desvanecimiento, sin encogimiento u otro indicador visible de que se está produciendo un cambio.

Para que el cambio sea menos abrupto, debes definir una animación *transition* para especificar los cambios que ocurren entre un estado y otro durante un período de tiempo. La función `transition()` acepta dos argumentos: el primer argumento acepta una expresión que define la dirección entre dos estados de transición, y el segundo argumento acepta uno o una serie de pasos `animate()`.


Utiliza la función `animate()` para definir la duración, el retardo y la suavidad de una transición, y para designar la función de estilo para definir estilos mientras se realizan las transiciones. Utiliza la función `animate()` para definir la función `keyframes()` para animaciones de varios pasos. Estas definiciones se colocan en el segundo argumento de la función `animate()`.

#### Metadatos de animación: duración, retraso y relajación

La función `animate()` (segundo argumento de la función de transición) acepta los parámetros de entrada `timings` y `styles`.

El parámetro `timings` toma un número o una cadena definida en tres partes.

> `animate (duración)` o `animate ('reducción de la demora de duración')`

La primera parte, `duration`, es obligatoria. La duración se puede expresar en milisegundos como un número sin comillas o en segundos con comillas y un especificador de tiempo. Por ejemplo, una duración de una décima de segundo se puede expresar de la siguiente manera:

* Como un número simple, en milisegundos: `100`

* En una cadena, en milisegundos: `'100ms'`

* En una cadena, como segundos: `'0.1s'`

El segundo argumento, `delay`, tiene la misma sintaxis que `duration`. Por ejemplo:

* Espera 100ms y luego ejecuta por 200ms: `'0.2s 100ms'`

El tercer argumento, `easing`, controla cómo [acelera y desacelera](https://easings.net/) la animación durante su tiempo de ejecución. Por ejemplo, `easy-in` hace que la animación comience lentamente y aumente la velocidad a medida que avanza.

* Espera 100ms, se ejecuta durante 200ms. Usa una curva de desaceleración para comenzar rápido y desacelerar lentamente hasta un punto de reposo: `'0.2s 100ms ease-out'`

* Ejecuta durante 200ms, sin demora. Usa una curva estándar para comenzar lento, acelerar en el medio y luego desacelerar lentamente al final: `'0.2s ease-in-out'`

* Comienza de inmediato, se ejecuta durante 200ms. Usa una curva de aceleración para comenzar lento y terminar a máxima velocidad: `'0.2s ease-in'`

<div class="alert is-helpful">

**Nota**: Consulta el tema del sitio web de *Material Design* sobre [curvas naturales de suavizado](https://material.io/design/motion/speed.html#easing) para obtener información general sobre las curvas de suavizado.
</div>

Este ejemplo proporciona una transición de estado de `open` a `closed` con una transición de un segundo entre estados.

<code-example path="animations/src/app/open-close.component.ts" header="src/app/open-close.component.ts" language="typescript"
region="transition1">
</code-example>

En el fragmento de código anterior, el operador `=>` indica transiciones unidireccionales y `<=>` es bidireccional. Dentro de la transición, `animate()` especifica cuánto tiempo lleva la transición. En este caso, el cambio de estado de `open` a `closed` toma un segundo, expresado aquí como `1s`.

Este ejemplo agrega una transición de estado del estado `closed` al estado `open` con un arco de animación de transición de 0.5 segundos.

<code-example path="animations/src/app/open-close.component.ts" header="src/app/open-close.component.ts" language="typescript"
region="transition2">
</code-example>

<div class="alert is-helpful">

**Nota**: Algunas notas adicionales sobre el uso de estilos dentro de las funciones `state` y `transition`.

* Usa `state()` para definir los estilos que se aplican al final de cada transición, persisten después de que se completa la animación.

* Utiliza `transition()` para definir estilos intermedios, que crean la ilusión de movimiento durante la animación.

* Cuando las animaciones están deshabilitadas, los estilos `transition()` se pueden omitir, pero los estilos `state()` no.

* Incluye varios pares de estados dentro del mismo argumento `transition()`:<br/>`transition('on => off, off => void')`.
</div>

### Activar la animación

Una animación requiere un *disparador*, para que sepa cuándo comenzar. La función `trigger()` recopila los estados y las transiciones, y le da un nombre a la animación, para que la puedas adjuntar al elemento desencadenante en la plantilla *HTML*.

La función `trigger()` describe el nombre de la propiedad para observar los cambios. Cuando ocurre un cambio, el disparador inicia las acciones incluidas en su definición. Estas acciones pueden ser transiciones u otras funciones, como veremos más adelante.

En este ejemplo, nombraremos el disparador `openClose` y lo adjuntaremos al elemento `button`. El disparador describe los estados `open` y `closed`, y los tiempos para las dos transiciones.

<div class="alert is-helpful">

**Nota**: Dentro de cada llamada a la función `trigger()`, un elemento solo puede estar en un estado en un momento dado. Sin embargo, es posible que varios desencadenantes estén activos simultáneamente.
</div>

### Definir animaciones y adjuntarlas a la plantilla *HTML*

Las animaciones se definen en los metadatos del componente que controla el elemento *HTML* a animar. Pon el código que define tus animaciones bajo la propiedad `animations:` dentro del decorador `@Component()`.

<code-example path="animations/src/app/open-close.component.ts" header="src/app/open-close.component.ts" language="typescript" region="component"></code-example>

Cuando hayas definido un disparador de animación para un componente, adjúntalo a un elemento en la plantilla de ese componente, colocando el nombre del disparador entre paréntesis y precediéndolo con un símbolo `@`. Luego, puedes vincular el desencadenador a una expresión de plantilla utilizando la sintaxis de enlace de propiedad angular estándar como se muestra a continuación, donde `triggerName` es el nombre del desencadenador y `expression` se evalúa a un estado de animación definido.

```
<div [@triggerName]="expression">...</div>;
```

La animación se ejecuta o activa cuando el valor de la expresión cambia a un nuevo estado.

El siguiente fragmento de código vincula el activador al valor de la propiedad `isOpen`.

<code-example path="animations/src/app/open-close.component.1.html" header="src/app/open-close.component.html"
region="trigger">
</code-example>

En este ejemplo, cuando la expresión `isOpen` se evalúa a un estado definido de`open` o `closed`, notifica al activador `openClose` de un cambio de estado. Luego, depende del código `openClose` manejar el cambio de estado e iniciar una animación de cambio de estado.

Para los elementos que entran o salen de una página (insertados o eliminados del *DOM*), puedes hacer que las animaciones sean condicionales. Por ejemplo, usa `*ngIf` con el disparador de animación en la plantilla *HTML*.

<div class="alert is-helpful">

**Nota**: En el archivo de componentes, establece el disparador que define las animaciones como el valor de la propiedad `animations:` en el decorador `@Component()`.

En el archivo de plantilla *HTML*, utiliza el nombre del disparador para adjuntar las animaciones definidas al elemento *HTML* que se va a animar.

</div>

### Revisión de código

Aquí están los archivos de código expuestos en el ejemplo de transición.

<code-tabs>

<code-pane header="src/app/open-close.component.ts" path="animations/src/app/open-close.component.ts" language="typescript"
region="component">
</code-pane>

<code-pane header="src/app/open-close.component.html" path="animations/src/app/open-close.component.1.html"
region="trigger">
</code-pane>

<code-pane header="src/app/open-close.component.css" path="animations/src/app/open-close.component.css">
</code-pane>

</code-tabs>

### Resumen

Aprendiste a agregar animación a una transición entre dos estados, usando `style()` y `state()` junto con `animate()` para el tiempo.

Obtén información sobre funciones más avanzadas en animaciones *Angular* en la sección Animación, comenzando con técnicas avanzadas en [transición y disparadores](guide/transition-and-triggers).

{@a resumen-de-la-api-de-animacion}
## Resumen de la *API* de animación

La *API* funcional proporcionada por el módulo `@angular/animations` proporciona un lenguaje específico de dominio (*DSL*) para crear y controlar animaciones en aplicaciones *Angular*. Consulta la [referencia de la *API*](api/animations) para obtener una lista completa y detalles de sintaxis de las principales funciones y las estructuras de datos relacionadas.

<table>

<tr>
<th style="vertical-align: top">
Nombre de función
</th>

<th style="vertical-align: top">
Qué hace
</th>
</tr>

<tr>
<td><code>trigger()</code></td>
<td>Inicia la animación y sirve como contenedor para todas las demás llamadas a funciones de animación. La plantilla *HTML* se vincula a <code>triggerName</code>. Utiliza el primer argumento para declarar un nombre de desencadenante único. Utiliza sintaxis de arreglo.</td>
</tr>

<tr>
<td><code>style()</code></td>
<td>Define uno o más estilos <span>CSS</span> para usar en animaciones. Controla la apariencia visual de los elementos <span>HTML</span> durante las animaciones. Utiliza la sintaxis de objeto.</td>
</tr>

<tr>
<td><code><a href="api/animations/state" class="code-anchor">state</a>()</code></td>
<td>Crea un conjunto con nombre de estilos <span>CSS</span> que se deben aplicar en una transición exitosa a un estado dado. Luego, se puede hacer referencia al estado por su nombre dentro de otras funciones de animación.</td>
</tr>

<tr>
<td><code>animate()</code></td>
<td>Especifica la información de tiempo para una transición. Valores opcionales para <code>delay</code> y <code>easing</code>. Puede contener llamadas <code>style()</code> dentro. </td>
</tr>

<tr>
<td><code>transition()</code></td>
<td>Define la secuencia de animación entre dos estados nombrados. Utiliza sintaxis de arreglo.</td>
</tr>

<tr>
<td><code>keyframes()</code></td>
<td>Permite un cambio secuencial entre estilos dentro de un intervalo de tiempo especificado. Úsalo dentro de <code>animate()</code>. Puedes incluir varias llamadas a <code>style()</code> dentro de cada <code>keyframe()</code>. Utiliza sintaxis de arreglo.</td>
</tr>

<tr>
<td><code><a href="api/animations/group" class="code-anchor">group</a>()</code></td>
<td>Especifica un grupo de pasos de animación (<em>animaciones internas</em>) que se ejecutarán en paralelo. La animación continúa solo después de que se hayan completado todos los pasos de la animación interna. Se utiliza dentro de <code>sequence()</code> o <code>transition()</code>. </td>
</tr>

<tr>
<td><code>query()</code></td>
<td>Busca uno o más elementos <em>HTML</em> internos dentro del elemento actual. </td>
</tr>

<tr>
<td><code>sequence()</code></td>
<td>Especifica una lista de pasos de animación que se ejecutan secuencialmente, uno por uno.</td>
</tr>

<tr>
<td><code>stagger()</code></td>
<td>Alterna la hora de inicio de las animaciones para varios elementos.</td>
</tr>

<tr>
<td><code>animation()</code></td>
<td>Produce una animación reutilizable que se puede invocar desde otro lugar. Usada junto con <code>useAnimation()</code>.</td>
</tr>

<tr>
<td><code>useAnimation()</code></td>
<td>Activa una animación reutilizable. Usada con <code>animation()</code>.</td>
</tr>

<tr>
<td><code>animateChild()</code></td>
<td>Permite que las animaciones de los componentes secundarios se ejecuten dentro del mismo período de tiempo que el principal.</td>
</tr>

</table>

## Más sobre animaciones *Angular*

También puedes estar interesado en lo siguiente:

* [Transición y disparadores](guide/transition-and-triggers)
* [Secuencias de animación complejas](guide/complex-animation-sequences)
* [Animaciones reutilizables](guide/reusable-animations)
* [Animaciones de transición de ruta](guide/route-animations)

<div class="alert is-helpful">

Consulta esta [presentación](https://www.youtube.com/watch?v=rnTK9meY5us), mostrada en la conferencia *AngularConnect* en noviembre de 2017, y el [código fuente](https://github.com/matsko/animationsftw.in) adjunto.
</div>
