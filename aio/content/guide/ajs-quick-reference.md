# *AngularJS* a conceptos *Angular* ⏤ Referencia rápida


{@a top}


*Angular* es el nombre del *Angular* de hoy y de mañana.
*AngularJS* es el nombre de todas las versiones v1.x de *Angular*.

Esta guía te ayuda a realizar la transición de *AngularJS* a *Angular*
mapeando la sintaxis de *AngularJS* a la sintaxis de *Angular* equivalente.


**Ve la sintaxis *Angular* en este <live-example name="ajs-quick-reference"></live-example>**.

## Conceptos básicos de plantilla
Las plantillas son la parte orientada al usuario de una aplicación *Angular* y están escritas en *HTML*.
La siguiente tabla enumera algunas de las características clave de la plantilla *AngularJS* con su sintaxis de plantilla *Angular* equivalente.


<table width="100%">

  <col width="50%">

  </col>

  <col width="50%">

  </col>

  <tr>

    <th>
      AngularJS
    </th>

    <th>
      Angular
    </th>

  </tr>

  <tr style=top>

    <td>


      ### Enlaces/interpolación

      <code-example hideCopy>
        Tu héroe favorito es: {{vm.favoriteHero}}
      </code-example>


      En *AngularJS*, una expresión entre llaves denota un enlace unidireccional.
      Esto vincula el valor del elemento a una propiedad en el controlador
      asociado con esta plantilla.

      Cuando se usa la sintaxis `controller as`,
      el enlace tiene el prefijo del alias del controlador (`vm` o `$ctrl`) porque
      tiene que ser específico sobre la fuente de la vinculación.
    </td>

    <td>


      ### Enlaces/interpolación

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.html" region="interpolation"></code-example>


      En *Angular*, una expresión de plantilla entre llaves todavía denota un enlace unidireccional.
      Esto vincula el valor del elemento a una propiedad del componente.
      El contexto de la vinculación está implícito y siempre es el
      componente asociado, por lo que no necesita una variable de referencia.

      Para obtener más información, consulta la guía [Interpolación](guide/interpolation).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### Filtros

      <code-example hideCopy>
        &lt;td>{{movie.title | uppercase}}&lt;/td>
      </code-example>


      Para filtrar la salida en las plantillas de *AngularJS*, usa el carácter de barra vertical (|) y uno o más filtros.

      Este ejemplo filtra la propiedad `title` a mayúsculas.
    </td>

    <td>


      ### Tuberías

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="uppercase"></code-example>


      En *Angular*, usa una sintaxis similar con el carácter de tubería (|) para filtrar la salida, pero ahora los llama **tuberías** (`pipes`).
      Muchos (pero no todos) los filtros integrados de *AngularJS* son
      tuberías integradas en *Angular*.

      Para obtener más información, consulta [Filtros/tuberías](guide/ajs-quick-reference#filtros-tuberias) a continuación.
    </td>

  </tr>

  <tr style=top>

    <td>


      ### Variables locales

      <code-example hideCopy format="">
        &lt;tr ng-repeat="movie in vm.movies">
          &lt;td>{{movie.title}}&lt;/td>
        &lt;/tr>
      </code-example>


      Aquí, `movie` es una variable local definida por el usuario.
    </td>

    <td>


      ### Variables de entrada

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="local"></code-example>


      *Angular* tiene verdaderas variables de entrada de plantilla que se definen explícitamente usando la palabra clave `let`.

      Para obtener más información, consulta la sección [Resumen de directivas estructurales](guide/directivas-estructurales#resumen) de [Directivas estructurales](guide/structural-directives).
    </td>

  </tr>

</table>


## Directivas de plantilla
*AngularJS* proporciona más de setenta directivas integradas para plantillas.
Muchas de ellas no son necesarias en *Angular* debido a su sistema de enlace más capaz y expresivo.
Las siguientes son algunas de las directivas clave integradas de *AngularJS* y sus equivalentes en *Angular*.


<table width="100%">

  <col width="50%">

  </col>

  <col width="50%">

  </col>

  <tr>

    <th>
      AngularJS
    </th>

    <th>
      Angular
    </th>

  </tr>

  <tr style=top>

    <td>


      ### `ng-app`

      <code-example hideCopy>
        &lt;body ng-app="movieHunter">
      </code-example>


      El proceso de inicio de la aplicación se llama **`bootstrapping`**.

      Aunque puedes arrancar una aplicación *AngularJS* en código,
      muchas aplicaciones arrancan declarativamente con la directiva `ng-app`,
      dándole el nombre del módulo de la aplicación (`movieHunter`).
    </td>

    <td>


      ### Proceso de arranque

      <code-example hideCopy path="ajs-quick-reference/src/main.ts" header="main.ts"></code-example>
      <br>

      <code-example hideCopy path="ajs-quick-reference/src/app/app.module.1.ts" header="app.module.ts"></code-example>


      *Angular* no tiene una directiva de arranque.
      Para iniciar la aplicación en código, arranca explícitamente el módulo raíz de la aplicación (`AppModule`)
      en `main.ts`
      y el componente raíz de la aplicación (`AppComponent`) en `app.module.ts`.
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-class`

      <code-example hideCopy format="">
        &lt;div ng-class="{active: isActive}">
        &lt;div ng-class="{active: isActive,
                           shazam: isImportant}">
      </code-example>


      En *AngularJS*, la directiva `ng-class` incluye/excluye clases *CSS*
      basadas en una expresión. Esa expresión suele ser un objeto de control de clave-valor con cada
      clave del objeto definido como un nombre de clase *CSS*, y cada valor definido como una expresión de plantilla
      que se evalúa como un valor booleano.

      En el primer ejemplo, la clase `active` se aplica al elemento si `isActive` es `true`.

      Puedes especificar varias clases, como se muestra en el segundo ejemplo.
    </td>

    <td>


      ### `ngClass`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="ngClass"></code-example>


      En *Angular*, la directiva `ngClass` funciona de manera similar.
      Incluye/excluye clases *CSS* basadas en una expresión.

      En el primer ejemplo, la clase `active` se aplica al elemento si `isActive` es `true`.

      Puedes especificar varias clases, como se muestra en el segundo ejemplo.

      *Angular* también tiene **enlace de clase**, que es una buena manera de agregar o eliminar una sola clase,
      como se muestra en el tercer ejemplo.

      Para obtener más información, consulta la página [Vinculación de atributos, clases y estilos](guide/attribute-binding).

    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-click`

      <code-example hideCopy format="">
        &lt;button ng-click="vm.toggleImage()">
        &lt;button ng-click="vm.toggleImage($event)">
      </code-example>


      En *AngularJS*, la directiva `ng-click` te permite especificar un comportamiento personalizado cuando se hace clic en un elemento.

      En el primer ejemplo, cuando el usuario hace clic en el botón, se ejecuta el método `toggleImage()` en el controlador al que hace referencia el alias `vm` controller as`.

      El segundo ejemplo demuestra el paso del objeto `$event`, que proporciona detalles sobre el evento
      al controlador.
    </td>

    <td>


      ### Enlazar al evento `click`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="event-binding"></code-example>


      Las directivas basadas en eventos de *AngularJS* no existen en *Angular*.
      Más bien, define el enlace unidireccional desde la vista de plantilla al componente utilizando **enlace de evento**.

      Para la vinculación de eventos, define el nombre del evento de destino entre paréntesis y
      especifica una declaración de plantilla, entre comillas, a la derecha de los iguales. *Angular* entonces
      configura un controlador de eventos para el evento destino. Cuando se genera el evento, el controlador
      ejecuta la declaración de plantilla.

      En el primer ejemplo, cuando un usuario hace clic en el botón, se ejecuta el método `toggleImage()` en el componente asociado.

      El segundo ejemplo demuestra el paso del objeto `$event`, que proporciona detalles sobre el evento
      al componente.

      Para obtener una lista de eventos *DOM*, consulta: https://developer.mozilla.org/en-US/docs/Web/Events.

      Para obtener más información, consulta la página [Vinculación de eventos](guide/event-binding).

    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-controller`

      <code-example hideCopy format="">
        &lt;div ng-controller="MovieListCtrl as vm">
      </code-example>


      En *AngularJS*, la directiva `ng-controller` adjunta un controlador a la vista.
      El uso del `ng-controller` (o la definición del controlador como parte del enrutamiento) vincula la
      vista al código del controlador asociado con esa vista.
    </td>

    <td>


      ### Decorador `Component`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.ts" region="component"></code-example>


      En *Angular*, la plantilla ya no especifica su controlador asociado.
      Más bien, el componente especifica su plantilla asociada como parte del decorador de clase del componente.

      Para obtener más información, consulta [Descripción general de la arquitectura](guide/architecture#components).

    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-hide`
      En *AngularJS*, la directiva `ng-hide` muestra u oculta el elemento *HTML* asociado basado en
      una expresión. Para obtener más información, consulta [ng-show](guide/ajs-quick-reference#ng-show).
    </td>

    <td>


      ### Enlazar a la propiedad `hidden`
      En *Angular*, usa el enlace de propiedad; no hay directiva `hide` incorporada.
      Para obtener más información, consulta [ng-show](guide/ajs-quick-reference#ng-show).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-href`

      <code-example hideCopy format="">
        &lt;a ng-href="{{ angularDocsUrl }}">Angular Docs&lt;/a>
      </code-example>


      La directiva `ng-href` permite a *AngularJS* preprocesar la propiedad `href` para que
      pueda reemplazar la expresión de enlace con la *URL* adecuada antes del navegador
      recupere esa *URL*.

      En *AngularJS*, el `ng-href` se usa a menudo para activar una ruta como parte de la navegación.

      <code-example hideCopy format="">
        &lt;a ng-href="#{{ moviesHash }}">Movies&lt;/a>
      </code-example>


      El enrutamiento se maneja de manera diferente en *Angular*.
    </td>

    <td>


      ### Enlazar a la propiedad `href`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="href"></code-example>


      *Angular* usa el enlace de propiedad; no hay directiva `href ` incorporada.
      Coloca la propiedad `href` del elemento entre corchetes y establécela en una expresión de plantilla entre comillas.

      Para obtener más información, consulta la página [Enlace de propiedad](guide/property-binding).

      En *Angular*, `href` ya no se usa para enrutamiento. El enrutamiento usa `routerLink`, como se muestra en el siguiente ejemplo.

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="router-link"></code-example>


      Para obtener más información sobre el enrutamiento, consulta [Definición de una ruta básica](guide/router#ruta-basica)
      en la página [Enrutamiento y navegación](guide/router).

    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-if`

      <code-example hideCopy format="">
        &lt;table ng-if="movies.length">
      </code-example>


      En *AngularJS*, la directiva `ng-if` elimina o recrea una parte del *DOM*,
      basadas en una expresión. Si la expresión es falsa, el elemento se elimina del *DOM*.

      En este ejemplo, el elemento `<table>` se elimina del *DOM* a menos que el arreglo `movies` tenga una longitud mayor que cero.
    </td>

    <td>


      ### `*ngIf`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.html" region="ngIf"></code-example>


      La directiva `*ngIf` en *Angular* funciona igual que la directiva `ng-if` en *AngularJS*. Quita
      o recrea una parte del *DOM* basándose en una expresión.

      En este ejemplo, el elemento `<table>` se elimina del *DOM* a menos que el arreglo `movies` tenga una longitud.

      El (*) antes de `ngIf` es obligatorio en este ejemplo.
      Para obtener más información, consulta [Directivas estructurales](guide/structural-directives).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-model`

      <code-example hideCopy format="">
        &lt;input ng-model="vm.favoriteHero"/>
      </code-example>


      En *AngularJS*, la directiva `ng-model` vincula un control de formulario a una propiedad en el controlador asociado con la plantilla.
      Esto proporciona **enlace bidireccional**, mediante el cual cualquier cambio realizado en el valor en la vista se sincroniza con el modelo, y cualquier cambio en el modelo se sincroniza con el valor en la vista.
    </td>

    <td>


      ### `ngModel`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.html" region="ngModel"></code-example>


      En *Angular*, **enlace bidireccional** se denota con '[()]', descriptivamente referido como un "plátano en una caja". Esta sintaxis es un atajo para definir tanto el enlace de propiedad (desde el componente hasta la vista)
      y vinculación de eventos (desde la vista al componente), proporcionando así un enlace bidireccional.

      Para obtener más información sobre el enlace bidireccional con `ngModel`, consulta [`NgModel`&mdash;Enlace bidireccional para
      elementos de formulario con `[(ngModel)]`](../guide/built-in-directives#ngModel)
      sección de la página [Directivas integradas](guide/built-in-directives).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-repeat`

      <code-example hideCopy format="">
        &lt;tr ng-repeat="movie in vm.movies">
      </code-example>


      En *AngularJS*, la directiva `ng-repeat` repite el elemento *DOM* asociado
      para cada elemento de la colección especificada.

      En este ejemplo, el elemento de la fila de la tabla (`<tr>`) se repite para cada objeto de película en la colección de películas.
    </td>

    <td>


      ### `*ngFor`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.html" region="ngFor"></code-example>


      La directiva `*ngFor` en *Angular* es similar a la directiva `ng-repeat` en *AngularJS*. Se repite
      el elemento *DOM* asociado para cada elemento de la colección especificada.
      Exactamente, convierte el elemento definido (`<tr>` en este ejemplo) y su contenido en una plantilla y
      usa esa plantilla para instanciar una vista para cada elemento de la lista.

      Observa las otras diferencias de sintaxis:
      Se requiere el (*) antes de `ngFor`;
      la palabra clave `let` identifica a `movie` como una variable de entrada;
      la preposición de la lista es `of`, no `in`.

      Para obtener más información, consulta [Directivas estructurales](guide/structural-directives).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-show`

      <code-example hideCopy format="">
        &lt;h3 ng-show="vm.favoriteHero">
          Tu héroe favorito es: {{vm.favoriteHero}}
        &lt;/h3>
      </code-example>


      En *AngularJS*, la directiva `ng-show` muestra u oculta el elemento *DOM* asociado, basado en
      una expresión.

      En este ejemplo, el elemento `<div>` se muestra si la variable `favoriteHero` es `true`.
    </td>

    <td>


      ### Enlazar a la propiedad `hidden`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.html" region="hidden"></code-example>


      *Angular* usa el enlace de propiedad; no hay directiva `show ` incorporada.
      Para ocultar y mostrar elementos, vincula a la propiedad *HTML* `hidden`.

      Para mostrar un elemento de forma condicional, coloca la propiedad `hidden` del elemento entre corchetes y
      configúralo en una expresión de plantilla entre comillas que se evalúe como el *opuesto* de `show`.

      En este ejemplo, el elemento `<div>` está oculto si la variable `favoriteHero` no es `true`.

      Para obtener más información sobre el enlace de propiedad, consulta la página [Enlace de propiedad](guide/property-binding).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-src`

      <code-example hideCopy format="">
        &lt;img ng-src="{{movie.imageurl}}">
      </code-example>


      La directiva `ng-src` permite a *AngularJS* preprocesar la propiedad `src` para que
      pueda reemplazar la expresión de enlace con la *URL* adecuada antes del navegador
      recupere esa *URL*.
    </td>

    <td>


      ### Enlazar a la propiedad `src`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="src"></code-example>


      *Angular* usa el enlace de propiedad; no hay directiva `src` incorporada.
      Coloca la propiedad `src` entre corchetes y establécela en una expresión de plantilla entre comillas.

      Para obtener más información sobre el enlace de propiedad, consulta la página [Enlace de propiedad](guide/property-binding).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-style`

      <code-example hideCopy format="">
        &lt;div ng-style="{color: colorPreference}">
      </code-example>


      En *AngularJS*, la directiva `ng-style` establece un estilo *CSS* en un elemento *HTML*
      basado en una expresión. Esa expresión suele ser un objeto de control de clave-valor con cada
      clave del objeto definido como una propiedad *CSS*, y cada valor definido como una expresión
      que evalúa a un valor apropiado para el estilo.

      En el ejemplo, el estilo `color` se establece en el valor actual de la variable `colorPreference`.
    </td>

    <td>


      ### `ngStyle`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="ngStyle"></code-example>


      En *Angular*, la directiva `ngStyle` funciona de manera similar. Establece un estilo *CSS* en un elemento *HTML* basado en una expresión.

      En el primer ejemplo, el estilo `color` se establece en el valor actual de la variable `colorPreference`.

      *Angular* también tiene **enlace de estilo**, que es una buena forma de establecer un estilo único. Esto se muestra en el segundo ejemplo.

      Para obtener más información sobre el enlace de estilo, consulta la sección [Enlace de estilo](guide/attribute-binding#enlace-de-estilo) del
      la página [Enlace de atributo](guide/attribute-binding).

      Para obtener más información sobre la directiva `ngStyle`, consulta [`NgStyle`](guide/built-in-directives#ngstyle)
      sección de la página [Directivas integradas](guide/built-in-directives).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `ng-switch`

      <code-example hideCopy format="">
        &lt;div ng-switch="vm.favoriteHero &&
                        vm.checkMovieHero(vm.favoriteHero)">
            &lt;div ng-switch-when="true">
              ¡Excelente elección!
            &lt;/div>
            &lt;div ng-switch-when="false">
              ¡No hay película, lo siento!
            &lt;/div>
            &lt;div ng-switch-default>
              Por favor, ingresa tu héroe favorito.
            &lt;/div>
        &lt;/div>
      </code-example>


      En ¨AngularJS*, la directiva `ng-switch` intercambia el contenido de
      un elemento seleccionando una de las plantillas según el valor actual de una expresión.

      En este ejemplo, si `favoriteHero` no está configurado, la plantilla muestra "Por favor, ingresa ...".
      Si se establece `favoriteHero`, verifica el héroe de la película llamando a un método del controlador.
      Si ese método devuelve `true`, la plantilla muestra "¡Excelente elección!".
      Si ese método devuelve `false`, la plantilla muestra "¡No hay película, lo siento!".
    </td>

    <td>


      ### `ngSwitch`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.html" region="ngSwitch"></code-example>


      En *Angular*, la directiva `ngSwitch` funciona de manera similar.
      Muestra un elemento cuyo `*ngSwitchCase` coincide con el valor actual de la expresión `ngSwitch`.

      En este ejemplo, si no se establece `favoriteHero`, el valor de `ngSwitch` es `null`
      y se muestra `*ngSwitchDefault`, "Por favor ingrese ...".
      Si se establece `favoriteHero`, la aplicación verifica el héroe de la película llamando a un método de componente.
      Si ese método devuelve `true`, la aplicación selecciona `*ngSwitchCase="true"` y muestra: "¡Excelente elección!"
      Si ese método devuelve `false`, la aplicación selecciona `*ngSwitchCase="false"` y muestra: "¡No hay película, lo siento!"

      En este ejemplo, se requiere el (*) antes de `ngSwitchCase` y `ngSwitchDefault`.

      Para obtener más información, consulta [Las directivas `NgSwitch`](guide/built-in-directives#ngSwitch)
      sección de la página [Directivas integradas](guide/built-in-directives).
    </td>

  </tr>

</table>


{@a filters-pipes}



## Filtros/tuberías
**Tuberías** *Angular* proporcionar formato y transformación para los datos en la plantilla, similar a los filtros de **AngularJS**.
Muchos de los filtros incorporados en *AngularJS* tienen tuberías correspondientes en *Angular*.
Para obtener más información sobre tuberías, consulta [*Tuberías*](guide/pipes).


<table width="100%">

  <col width="50%">

  </col>

  <col width="50%">

  </col>

  <tr>

    <th>
      AngularJS
    </th>

    <th>
      Angular
    </th>

  </tr>

  <tr style=top>

    <td>


      ### `currency`

      <code-example hideCopy>
        &lt;td>{{movie.price | currency}}&lt;/td>
      </code-example>


      Formatea un número como moneda.
    </td>

    <td>


      ### `currency`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="currency"></code-example>


      La tubería `currency` de *Angular* es similar aunque algunos de los parámetros han cambiado.
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `date`

      <code-example hideCopy>
        &lt;td>{{movie.releaseDate | date}}&lt;/td>
      </code-example>


      Formatea una fecha en una cadena según el formato solicitado.
    </td>

    <td>


      ### `date`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="date"></code-example>


      La tubería `date` de *Angular* es similar.

    </td>

  </tr>

  <tr style=top>

    <td>


      ### `filter`

      <code-example hideCopy>
        &lt;tr ng-repeat="movie in movieList | filter: {title:listFilter}">
      </code-example>


      Selecciona un subconjunto de elementos de la colección definida, según los criterios de filtrado.
    </td>

    <td>


      ### none
      Por motivos de rendimiento, no existe una tubería comparable en *Angular*. Haz todo tu filtrado en el componente. Si necesitas el mismo código de filtrado en varias plantillas, considera la posibilidad de crear una tubería personalizada.

    </td>

  </tr>

  <tr style=top>

    <td>


      ### json

      <code-example hideCopy>
        &lt;pre>{{movie | json}}&lt;/pre>
      </code-example>


      Convierte un objeto *JavaScript* en una cadena *JSON*. Esto es útil para depurar.
    </td>

    <td>


      ### json

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="json"></code-example>


      La tubería `json` de *Angular* hace lo mismo.
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `limitTo`

      <code-example hideCopy>
        &lt;tr ng-repeat="movie in movieList | limitTo:2:0">
      </code-example>


      Selecciona hasta el primer parámetro (2) número de elementos de la colección
      comenzando (opcionalmente) en el índice inicial (0).
    </td>

    <td>


      ### `slice`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="slice"></code-example>


      El `SlicePipe` hace lo mismo pero el *orden de los parámetros se invierte*, de acuerdo con
      el método `Slice` de *JavaScript*.
      El primer parámetro es el índice inicial; el segundo es el límite.
      Al igual que en *AngularJS*, codificar esta operación dentro del componente podría mejorar el rendimiento.
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `lowercase`

      <code-example hideCopy>
        &lt;td>{{movie.title | lowercase}}&lt;/td>
      </code-example>


      Convierte la cadena a minúsculas.
    </td>

    <td>


      ### `lowercase`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="lowercase"></code-example>


      La tubería *Angular* en minúsculas hace lo mismo.
    </td>

  </tr>

  <tr style=top>

    <td>


      ### number

      <code-example hideCopy>
        &lt;td>{{movie.starRating | number}}&lt;/td>
      </code-example>


      Formatea un número como texto.
    </td>

    <td>


      ### number

      <code-example hideCopy path="ajs-quick-reference/src/app/app.component.html" region="number"></code-example>


      La tubería `number` de *Angular* es similar.
      Proporciona más funcionalidad a la hora de definir
      los lugares decimales, como se muestra en el segundo ejemplo anterior.

      *Angular* también tiene una tubería `porcent`, que formatea un número como un porcentaje local
      como se muestra en el tercer ejemplo.
    </td>

  </tr>

  <tr style=top>

    <td>


      ### `orderBy`

      <code-example hideCopy>
        &lt;tr ng-repeat="movie in movieList | orderBy : 'title'">
      </code-example>


      Muestra la colección en el orden especificado por la expresión.
      En este ejemplo, el título de la película ordena la `movieList`.
    </td>

    <td>


      ### none
      Por motivos de rendimiento, no existe una tubería comparable en *Angular*.
      En su lugar, utiliza el código del componente para ordenar u ordenar los resultados. Si necesitas el mismo código de ordenación o clasificación en varias plantillas, considera la posibilidad de crear una tubería personalizada.

    </td>

  </tr>

</table>



{@a controllers-components}



## Módulos/controladores/componentes
Tanto en *AngularJS* como en *Angular*, los módulos te ayudan a organizar tu aplicación en bloques cohesivos de funcionalidad.

En *AngularJS*, escribe el código que proporciona el modelo y los métodos para la vista en un **controlador**.
En *Angular*, construyes un **componente**.

Debido a que gran parte del código de *AngularJS* está en *JavaScript*, el código de *JavaScript* se muestra en la columna de *AngularJS*.
El código angular se muestra usando *TypeScript*.


<table width="100%">

  <col width="50%">

  </col>

  <col width="50%">

  </col>

  <tr>

    <th>
      AngularJS
    </th>

    <th>
      Angular
    </th>

  </tr>

  <tr style=top>

    <td>


      ### IIFE

      <code-example hideCopy>
        (function () {
          ...
        }());
      </code-example>


      En *AngularJS*, una expresión de función invocada inmediatamente (o *IIFE*) alrededor del código del controlador
      lo mantiene fuera del espacio de nombres global.

    </td>

    <td>


      ### none
      Esto no es un problema en *Angular* porque los módulos *ES 2015*
      maneja el espacio de nombres por ti.

      Para obtener más información sobre los módulos, consulta la sección [Módulos](guide/architecture#modulos) del
      [Descripción general de la arquitectura](guide/architecture).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### Módulos *Angular*

      <code-example hideCopy>
        angular.module("movieHunter", ["ngRoute"]);
      </code-example>


      En *AngularJS*, un módulo *Angular* realiza un seguimiento de los controladores, servicios y otro código.
      El segundo argumento define la lista de otros módulos de los que depende este módulo.
    </td>

    <td>


      ### `NgModules`

      <code-example hideCopy path="ajs-quick-reference/src/app/app.module.1.ts"></code-example>


      Los `NgModules`, definidos con el decorador `NgModule`, tienen el mismo propósito:

      * `imports` ⏤ especifica la lista de otros módulos de los que depende este módulo
      * `declaration` ⏤ realiza un seguimiento de tus componentes, tuberías y directivas.

      Para obtener más información sobre los módulos, consulta [`NgModules`](guide/ngmodules).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### Registro de controlador

      <code-example hideCopy>
        angular
          .module("movieHunter")
          .controller("MovieListCtrl",
                      ["movieService",
                       MovieListCtrl]);
      </code-example>


      *AngularJS* tiene un código en cada controlador que busca un módulo *Angular* apropiado
      y registra el controlador con ese módulo.

      El primer argumento es el nombre del controlador. El segundo argumento define las cadenas de los nombres de
      todas las dependencias inyectadas en este controlador y una referencia a la función del controlador.
    </td>

    <td>


      ### Decorador `Component`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.ts" region="component"></code-example>


      *Angular* agrega un decorador a la clase componente para proporcionar los metadatos necesarios.
      El decorador `@Component` declara que la clase es un componente y proporciona metadatos sobre
      ese componente, como su selector (o etiqueta) y su plantilla.

      Así es como se asocia una plantilla con la lógica, que se define en la clase componente.

      Para obtener más información, consulta los [Componentes](guide/architecture#componentes)
      sección de la página [Descripción general de la arquitectura](guide/architecture).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### Función controlador

      <code-example hideCopy>
        function MovieListCtrl(movieService) {
        }
      </code-example>


      En *AngularJS*, escribe el código para el modelo y los métodos en una función controlador.
    </td>

    <td>


      ### Clase `Component`

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.ts" region="class"></code-example>


      En *Angular*, crea una clase `Component` para contener el modelo de datos y los métodos de control. Utiliza la palabra clave <code>export</code> de *TypeScript* para exportar la clase de modo que la funcionalidad se pueda importar a `NgModules`.

      Para obtener más información, consulta los [Componentes](guide/architecture#componentes)
      sección de la página [Descripción general de la arquitectura](guide/architecture).
    </td>

  </tr>

  <tr style=top>

    <td>


      ### Inyección de dependencias

      <code-example hideCopy>
        MovieListCtrl.$inject = ['MovieService'];
        function MovieListCtrl(movieService) {
        }
      </code-example>


      En *AngularJS*, pasa cualquier dependencia como argumentos de la función del controlador.
      Este ejemplo inyecta un `MovieService`.

      Para protegerte contra problemas de minificación, dilo explícitamente a *Angular*
      que debería inyectar una instancia de `MovieService` en el primer parámetro.
    </td>

    <td>


      ### Inyección de dependencias

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.ts" region="di"></code-example>


      En *Angular*, pasa dependencias como argumentos al constructor de la clase `Component`.
      Este ejemplo inyecta un `MovieService`.
      El tipo *TypeScript* del primer parámetro le dice a *Angular* qué inyectar, incluso después de la minificación.

      Para obtener más información, consulta la [inyección de dependencia](guide/architecture#inyeccion-de-dependencia)
      sección de la [Descripción general de la arquitectura](guide/architecture).
    </td>

  </tr>

</table>

{@a style-sheets}



## Hojas de estilo
Las hojas de estilo le dan a tu aplicación un aspecto agradable.
En *AngularJS*, especifica las hojas de estilo para toda tu aplicación.
A medida que la aplicación crece con el tiempo, los estilos de muchas partes de la aplicación
se fusionan, lo que puedes provocar resultados inesperados.
En *Angular*, aún puedes definir hojas de estilo para toda tu aplicación. Pero ahora también puedes
encapsular una hoja de estilo dentro de un componente específico.

<table width="100%">

  <col width="50%">

  </col>

  <col width="50%">

  </col>

  <tr>

    <th>
      AngularJS
    </th>

    <th>
      Angular
    </th>

  </tr>

  <tr style=top>

    <td>


      ### Etiqueta `link`

      <code-example hideCopy>
        &lt;link href="styles.css" rel="stylesheet" />
      </code-example>


      *AngularJS*, usa una etiqueta `link` en la sección `header` del archivo `index.html`
      para definir los estilos de la aplicación.
    </td>

    <td>



      ### Configuración de estilos
      <code-example hideCopy path="ajs-quick-reference/.angular-cli.1.json" region="styles"></code-example>

      Con *Angular CLI*, puedes configurar tus estilos globales en el archivo `angular.json`.
      Puedes cambiar el nombre de la extensión a `.scss` para usar `sass`.

      ### `StyleUrls`
      En *Angular*, puedes usar la propiedad `styles` o `styleUrls` de los metadatos `@Component` para definir
      una hoja de estilo para un componente en particular.

      <code-example hideCopy path="ajs-quick-reference/src/app/movie-list.component.ts" region="style-url"></code-example>


      Esto te permite establecer estilos apropiados para componentes individuales que no se filtrarán
      otras partes de la aplicación.
    </td>

  </tr>

</table>
