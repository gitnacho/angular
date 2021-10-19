# Inyección de dependencias en acción

Esta guía explora muchas de las características de la inyección de dependencias (*ID*) en *Angular*.

<div class="alert is-helpful">

Consulta el <live-example></live-example> para ver un ejemplo funcional que contiene los fragmentos de código de esta guía.

</div>

{@a multiple-service-instances}

## Varias instancias del servicio (espacio controlado)

A veces deseas varias instancias de un servicio en *el mismo nivel* de la jerarquía de componentes.

Un buen ejemplo es un servicio que mantiene el estado de su instancia de componente complementario.
Necesitas una instancia separada del servicio para cada componente.
Cada servicio tiene su propio estado de trabajo, aislado del servicio y estado de un componente diferente.
Esto se hace en un espacio controlado (*sandboxing* en inglés) porque cada instancia de servicio y componente tiene su propio espacio controlado para jugar.

{@a hero-bios-component}

En este ejemplo, `HeroBiosComponent` presenta tres instancias de `HeroBioComponent`.

<code-example path="dependency-injection-in-action/src/app/hero-bios.component.ts" region="simple" header="ap/hero-bios.component.ts">

</code-example>


Cada `HeroBioComponent` puede editar la biografía de un solo héroe.
`HeroBioComponent` se basa en `HeroCacheService` para buscar, almacenar en caché y realizar otras operaciones de persistencia en ese héroe.

<code-example path="dependency-injection-in-action/src/app/hero-cache.service.ts" region="service" header="src/app/hero-cache.service.ts">

</code-example>


Tres instancias de `HeroBioComponent` no pueden compartir la misma instancia de `HeroCacheService`,
ya que estarían compitiendo entre sí para determinar qué héroe almacenar en caché.

En cambio, cada `HeroBioComponent` obtiene su *propia* Instancia de `HeroCacheService`
enumerando `HeroCacheService` en su arreglo de metadatos `providers`.

<code-example path="dependency-injection-in-action/src/app/hero-bio.component.ts" region="component" header="src/app/hero-bio.component.ts">

</code-example>


El padre `HeroBiosComponent` enlaza un valor a `heroId`.
`ngOnInit` pasa ese *ID* al servicio, que busca y almacena en caché el héroe.
El captador de la propiedad `hero` saca al héroe almacenado en caché del servicio.
La plantilla muestra esta propiedad vinculada a datos.

Encuentra este ejemplo en <live-example name="dependency-injection-in-action">código en vivo</live-example>
y confirma que las tres instancias de `HeroBioComponent` tienen almacenados en caché sus propios datos de héroe.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/hero-bios.png" alt="Bios">
</div>

{@a qualify-dependency-lookup}

## Califica la búsqueda de dependencias con decoradores de parámetros

Cuando una clase requiere una dependencia, esa dependencia se agrega al constructor como parámetro.
Cuando *Angular* necesita crear una instancia de la clase, recurre al marco *ID* para proporcionar la dependencia.
De forma predeterminada, el marco *ID* busca un proveedor en la jerarquía de inyectores,
comenzando en el inyector local del componente y, si es necesario, burbujeando
a través del árbol del inyectores hasta que llega al inyector raíz.

* El primer inyector configurado con un proveedor proporciona la dependencia (una instancia de servicio o valor) al constructor.

* Si no se encuentra ningún proveedor en el inyector raíz, el marco *ID* arroja un error.

Hay una serie de opciones para modificar el comportamiento de búsqueda predeterminado, utilizando *decoradores de parámetros*
en los parámetros con valor de servicio de un constructor de clases.

{@a optional}

### Hace una dependencia `@Optional` y limita la búsqueda con `@Host`

Las dependencias se pueden registrar en cualquier nivel de la jerarquía de componentes.
Cuando un componente solicita una dependencia, *Angular* comienza con el inyector de ese componente
y sube por el árbol de inyectores hasta encontrar el primer proveedor adecuado.
*Angular* arroja un error si no puede encontrar la dependencia durante ese recorrido.

En algunos casos, debes limitar la búsqueda o acomodar una dependencia faltante.
Puedes modificar el comportamiento de búsqueda de *Angular* con la calificación decoradora `@Host` y `@Optional`
en un parámetro con valor de servicio del constructor del componente.

* El decorador de propiedades `@Optional` le dice a *Angular* que devuelva un valor nulo cuando no pueda encontrar la dependencia.

* El decorador de propiedades `@Host` detiene la búsqueda ascendente en el *componente host*.
El componente *host* suele ser el componente que solicita la dependencia.
Sin embargo, cuando este componente se proyecta en un componente *padre*,
ese componente padre se convierte en el anfitrión. El siguiente ejemplo cubre este segundo caso.

Estos decoradores se pueden utilizar individualmente o juntos, como se muestra en el ejemplo.
Este `HeroBiosAndContactsComponent` es una revisión de `HeroBiosComponent` que viste [arriba](guide/dependency-injection-in-action#hero-bios-componente).

<code-example path="dependency-injection-in-action/src/app/hero-bios.component.ts" region="hero-bios-and-contacts" header="src/app/hero-bios.component.ts (HeroBiosAndContactsComponent)">

</code-example>

Enfoque en la plantilla:

<code-example path="dependency-injection-in-action/src/app/hero-bios.component.ts" region="template" header="dependency-injection-in-action/src/app/hero-bios.component.ts"></code-example>

Ahora hay un nuevo elemento `<hero-contact>` entre las etiquetas `<hero-bio>`.
Los *proyectos Angular*, o *transcluye*, el correspondiente `HeroContactComponent` en la vista `HeroBioComponent`,
colocándolo en la ranura `<ng-content>` de la plantilla `HeroBioComponent`.

<code-example path="dependency-injection-in-action/src/app/hero-bio.component.ts" region="template" header="src/app/hero-bio.component.ts (template)"></code-example>

El resultado se muestra a continuación, con el número de teléfono del héroe de `HeroContactComponent` proyectado sobre la descripción del héroe.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/hero-bio-and-content.png" alt="bio u contacto">
</div>


Aquí está `HeroContactComponent`, que demuestra los decoradores calificados.

<code-example path="dependency-injection-in-action/src/app/hero-contact.component.ts" region="component" header="src/app/hero-contact.component.ts">

</code-example>

Enfoque en los parámetros del constructor.

<code-example path="dependency-injection-in-action/src/app/hero-contact.component.ts" region="ctor-params" header="src/app/hero-contact.component.ts"></code-example>

La función `@Host()` que decora la propiedad del constructor `heroCache` asegura que
obtienes una referencia al servicio de caché del `HeroBioComponent` padre.
*Angular* arroja un error si el padre carece de ese servicio, incluso si un componente superior
en el árbol de componentes lo incluye.

Una segunda función `@Host()` decora la propiedad del constructor `loggerService`.
La única instancia de `LoggerService` en la aplicación se proporciona en el nivel de `AppComponent`.
El host `HeroBioComponent` no tiene su propio proveedor `LoggerService`.

*Angular* arroja un error si no has decorado la propiedad con `@Optional()`.
Cuando la propiedad está marcada como opcional, *Angular* establece `loggerService` en `null` y el resto del componente se adapta.


Aquí está `HeroBiosAndContactsComponent` en acción.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/hero-bios-and-contacts.png" alt="Biografía con contacto en">
</div>



Si comentas el decorador `@Host()`, *Angular* sube por el árbol de ancestros del inyector
hasta que encuentra al registrador en el nivel `AppComponent`.
La lógica del registrador se activa y la pantalla del héroe se actualiza
con el marcador "!!!" para indicar que se encontró el registrador.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/hero-bio-contact-no-host.png" alt="Sin @Host">
</div>


Si restauras el decorador `@Host()` y comenta `@Optional`,
la aplicación lanza una excepción cuando no puede encontrar al registrador requerido en el nivel del componente anfitrión.

`EXCEPTION: No provider for LoggerService! (HeroContactComponent -> LoggerService)`

### Proporciona un proveedor personalizado con `@Inject`

El uso de un proveedor personalizado te permite proporcionar una implementación concreta para las dependencias implícitas, como las *API*s de navegador integradas. El siguiente ejemplo utiliza un `InjectionToken` para proporcionar la *API* del navegador [localStorage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage) como una dependencia en el `BrowserStorageService`.

<code-example path="dependency-injection-in-action/src/app/storage.service.ts" header="src/app/storage.service.ts">

</code-example>

La función `factory` devuelve la propiedad `localStorage` que se adjunta al objeto `window` del navegador. El decorador `Inject` es un parámetro del constructor utilizado para especificar un proveedor personalizado de una dependencia. Este proveedor personalizado ahora se puede redefinir durante la prueba con una *API* simulada de `localStorage` en lugar de interactuar con las *API*s del navegador real.

{@a skip}

### Modify the provider search with `@Self` and `@SkipSelf`

Providers can also be scoped by injector through constructor parameter decorators. The following example overrides the `BROWSER_STORAGE` token in the `Component` class `providers` with the `sessionStorage` browser API. The same `BrowserStorageService` is injected twice in the constructor, decorated with `@Self` and `@SkipSelf` to define which injector handles the provider dependency.

<code-example path="dependency-injection-in-action/src/app/storage.component.ts" header="src/app/storage.component.ts">

</code-example>

Using the `@Self` decorator, the injector only looks at the component's injector for its providers. The `@SkipSelf` decorator allows you to skip the local injector and look up in the hierarchy to find a provider that satisfies this dependency. The `sessionStorageService` instance interacts with the `BrowserStorageService` using the `sessionStorage` browser API, while the `localStorageService` skips the local injector and uses the root `BrowserStorageService` that uses the `localStorage` browser API.

{@a component-element}

## Inject the component's DOM element

Although developers strive to avoid it, many visual effects and third-party tools, such as jQuery,
require DOM access.
As a result, you might need to access a component's DOM element.

To illustrate, here's a minimal version of `HighlightDirective` from
the [Attribute Directives](guide/attribute-directives) page.

<code-example path="dependency-injection-in-action/src/app/highlight.directive.ts" header="src/app/highlight.directive.ts">

</code-example>

The directive sets the background to a highlight color when the user mouses over the
DOM element to which the directive is applied.

Angular sets the constructor's `el` parameter to the injected `ElementRef`.
(An `ElementRef` is a wrapper around a DOM element,
whose `nativeElement` property exposes the DOM element for the directive to manipulate.)

The sample code applies the directive's `appHighlight` attribute to two `<div>` tags,
first without a value (yielding the default color) and then with an assigned color value.

<code-example path="dependency-injection-in-action/src/app/app.component.html" region="highlight" header="src/app/app.component.html (highlight)"></code-example>


The following image shows the effect of mousing over the `<hero-bios-and-contacts>` tag.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/highlight.png" alt="Highlighted bios">
</div>
{@a defining-providers}


### Defining providers

A dependency can't always be created by the default method of instantiating a class.
You learned about some other methods in [Dependency Providers](guide/dependency-injection-providers).
The following `HeroOfTheMonthComponent` example demonstrates many of the alternatives and why you need them.
It's visually simple: a few properties and the logs produced by a logger.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/hero-of-month.png" alt="Hero of the month">
</div>

The code behind it customizes how and where the DI framework provides dependencies.
The use cases illustrate different ways to use the [*provide* object literal](guide/dependency-injection-providers#provide) to associate a definition object with a DI token.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="hero-of-the-month" header="hero-of-the-month.component.ts">

</code-example>

The `providers` array shows how you might use the different provider-definition keys;
`useValue`, `useClass`, `useExisting`, or `useFactory`.

{@a usevalue}


#### Value providers: `useValue`

The `useValue` key lets you associate a fixed value with a DI token.
Use this technique to provide *runtime configuration constants* such as website base addresses and feature flags.
You can also use a value provider in a unit test to provide mock data in place of a production data service.

The `HeroOfTheMonthComponent` example has two value providers.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="use-value" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts"></code-example>

* The first provides an existing instance of the `Hero` class to use for the `Hero` token, rather than
requiring the injector to create a new instance with `new` or use its own cached instance.
Here, the token is the class itself.

* The second specifies a literal string resource to use for the `TITLE` token.
The `TITLE` provider token is *not* a class, but is instead a
special kind of provider lookup key called an [injection token](guide/dependency-injection-in-action#injection-token), represented by
an `InjectionToken` instance.

You can use an injection token for any kind of provider but it's particularly
helpful when the dependency is a simple value like a string, a number, or a function.

The value of a *value provider* must be defined before you specify it here.
The title string literal is immediately available.
The `someHero` variable in this example was set earlier in the file as shown below.
You can't use a variable whose value will be defined later.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="some-hero" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts">

</code-example>

Other types of providers can create their values *lazily*; that is, when they're needed for injection.

{@a useclass}


#### Class providers: `useClass`

The `useClass` provider key lets you create and return a new instance of the specified class.

You can use this type of provider to substitute an *alternative implementation*
for a common or default class.
The alternative implementation could, for example, implement a different strategy,
extend the default class, or emulate the behavior of the real class in a test case.

The following code shows two examples in `HeroOfTheMonthComponent`.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="use-class" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts"></code-example>

The first provider is the *de-sugared*, expanded form of the most typical case in which the
class to be created (`HeroService`) is also the provider's dependency injection token.
The short form is generally preferred; this long form makes the details explicit.

The second provider substitutes `DateLoggerService` for `LoggerService`.
`LoggerService` is already registered at the `AppComponent` level.
When this child component requests `LoggerService`, it receives a `DateLoggerService` instance instead.

<div class="alert is-helpful">

This component and its tree of child components receive `DateLoggerService` instance.
Components outside the tree continue to receive the original `LoggerService` instance.

</div>

`DateLoggerService` inherits from `LoggerService`; it appends the current date/time to each message:

<code-example path="dependency-injection-in-action/src/app/date-logger.service.ts" region="date-logger-service" header="src/app/date-logger.service.ts"></code-example>

{@a useexisting}

#### Alias providers: `useExisting`

The `useExisting` provider key lets you map one token to another.
In effect, the first token is an *alias* for the service associated with the second token,
creating two ways to access the same service object.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="use-existing" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts">

</code-example>

You can use this technique to narrow an API through an aliasing interface.
The following example shows an alias introduced for that purpose.

Imagine that `LoggerService` had a large API, much larger than the actual three methods and a property.
You might want to shrink that API surface to just the members you actually need.
In this example, the `MinimalLogger` [class-interface](#class-interface) reduces the API to two members:


<code-example path="dependency-injection-in-action/src/app/minimal-logger.service.ts" header="src/app/minimal-logger.service.ts"></code-example>

The following example puts `MinimalLogger` to use in a simplified version of `HeroOfTheMonthComponent`.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.1.ts" header="src/app/hero-of-the-month.component.ts (minimal version)"></code-example>

The `HeroOfTheMonthComponent` constructor's `logger` parameter is typed as `MinimalLogger`, so only the `logs` and `logInfo` members are visible in a TypeScript-aware editor.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/minimal-logger-intellisense.png" alt="MinimalLogger restricted API">
</div>


Behind the scenes, Angular sets the `logger` parameter to the full service registered under the `LoggingService` token, which happens to be the `DateLoggerService` instance that was [provided above](guide/dependency-injection-in-action#useclass).


<div class="alert is-helpful">

This is illustrated in the following image, which displays the logging date.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/date-logger-entry.png" alt="DateLoggerService entry">
</div>

</div>

{@a usefactory}

#### Factory providers: `useFactory`

The `useFactory` provider key lets you create a dependency object by calling a factory function,
as in the following example.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="use-factory" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts">

</code-example>

The injector provides the dependency value by invoking a factory function,
that you provide as the value of the `useFactory` key.
Notice that this form of provider has a third key, `deps`, which specifies
dependencies for the `useFactory` function.

Use this technique to create a dependency object with a factory function
whose inputs are a combination of *injected services* and *local state*.

The dependency object (returned by the factory function) is typically a class instance,
but can be other things as well.
In this example, the dependency object is a string of the names of the runners up
to the "Hero of the Month" contest.

In the example, the local state is the number `2`, the number of runners up that the component should show.
The state value is passed as an argument to `runnersUpFactory()`.
The `runnersUpFactory()` returns the *provider factory function*, which can use both
the passed-in state value and the injected services `Hero` and `HeroService`.


<code-example path="dependency-injection-in-action/src/app/runners-up.ts" region="factory-synopsis" header="runners-up.ts (excerpt)"></code-example>

The provider factory function (returned by `runnersUpFactory()`) returns the actual dependency object,
the string of names.

* The function takes a winning `Hero` and a `HeroService` as arguments.
Angular supplies these arguments from injected values identified by
the two *tokens* in the `deps` array.

* The function returns the string of names, which Angular than injects into
the `runnersUp` parameter of `HeroOfTheMonthComponent`.

<div class="alert is-helpful">

The function retrieves candidate heroes from the `HeroService`,
takes `2` of them to be the runners-up, and returns their concatenated names.
Look at the <live-example name="dependency-injection-in-action"></live-example>
for the full source code.

</div>

{@a tokens}

## Provider token alternatives: class interface and 'InjectionToken'

Angular dependency injection is easiest when the provider token is a class
that is also the type of the returned dependency object, or service.

However, a token doesn't have to be a class and even when it is a class,
it doesn't have to be the same type as the returned object.
That's the subject of the next section.
{@a class-interface}

### Class interface

The previous *Hero of the Month* example used the `MinimalLogger` class
as the token for a provider of `LoggerService`.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="use-existing" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts">

</code-example>

`MinimalLogger` is an abstract class.

<code-example path="dependency-injection-in-action/src/app/minimal-logger.service.ts" header="dependency-injection-in-action/src/app/minimal-logger.service.ts"></code-example>

An abstract class is usually a base class that you can extend.
In this app, however there is no class that inherits from `MinimalLogger`.
The `LoggerService` and the `DateLoggerService` could have inherited from `MinimalLogger`,
or they could have implemented it instead, in the manner of an interface.
But they did neither.
`MinimalLogger` is used only as a dependency injection token.

When you use a class this way, it's called a *class interface*.

As mentioned in [DI Providers](guide/dependency-injection-providers#di-and-interfaces),
an interface is not a valid DI token because it is a TypeScript artifact that doesn't exist at run time.
Use this abstract class interface to get the strong typing of an interface,
and also use it as a provider token in the way you would a normal class.

A class interface should define *only* the members that its consumers are allowed to call.
Such a narrowing interface helps decouple the concrete class from its consumers.


<div class="alert is-helpful">

Using a class as an interface gives you the characteristics of an interface in a real JavaScript object.
To minimize memory cost, however, the class should have *no implementation*.
The `MinimalLogger` transpiles to this unoptimized, pre-minified JavaScript for a constructor function.

<code-example path="dependency-injection-in-action/src/app/minimal-logger.service.ts" region="minimal-logger-transpiled" header="dependency-injection-in-action/src/app/minimal-logger.service.ts"></code-example>

Notice that it doesn't have any members. It never grows no matter how many members you add to the class,
as long as those members are typed but not implemented.

Look again at the TypeScript `MinimalLogger` class to confirm that it has no implementation.

</div>


{@a injection-token}


### 'InjectionToken' objects

Dependency objects can be simple values like dates, numbers and strings, or
shapeless objects like arrays and functions.

Such objects don't have application interfaces and therefore aren't well represented by a class.
They're better represented by a token that is both unique and symbolic,
a JavaScript object that has a friendly name but won't conflict with
another token that happens to have the same name.

`InjectionToken` has these characteristics.
You encountered them twice in the *Hero of the Month* example,
in the *title* value provider and in the *runnersUp* factory provider.

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="provide-injection-token" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts"></code-example>

You created the `TITLE` token like this:

<code-example path="dependency-injection-in-action/src/app/hero-of-the-month.component.ts" region="injection-token" header="dependency-injection-in-action/src/app/hero-of-the-month.component.ts"></code-example>

The type parameter, while optional, conveys the dependency's type to developers and tooling.
The token description is another developer aid.


{@a di-inheritance}

## Inject into a derived class

Take care when writing a component that inherits from another component.
If the base component has injected dependencies,
you must re-provide and re-inject them in the derived class
and then pass them down to the base class through the constructor.

In this contrived example, `SortedHeroesComponent` inherits from `HeroesBaseComponent`
to display a *sorted* list of heroes.

<div class="lightbox">
  <img src="generated/images/guide/dependency-injection-in-action/sorted-heroes.png" alt="Sorted Heroes">
</div>

The `HeroesBaseComponent` can stand on its own.
It demands its own instance of `HeroService` to get heroes
and displays them in the order they arrive from the database.

<code-example path="dependency-injection-in-action/src/app/sorted-heroes.component.ts" region="heroes-base" header="src/app/sorted-heroes.component.ts (HeroesBaseComponent)">

</code-example>


<div class="alert is-helpful">

### Keep constructors simple

Constructors should do little more than initialize variables.
This rule makes the component safe to construct under test without fear that it will do something dramatic like talk to the server.
That's why you call the `HeroService` from within the `ngOnInit` rather than the constructor.

</div>


Users want to see the heroes in alphabetical order.
Rather than modify the original component, sub-class it and create a
`SortedHeroesComponent` that sorts the heroes before presenting them.
The `SortedHeroesComponent` lets the base class fetch the heroes.

Unfortunately, Angular cannot inject the `HeroService` directly into the base class.
You must provide the `HeroService` again for *this* componente *padre*,
then pass it down to the base class inside the constructor.


<code-example path="dependency-injection-in-action/src/app/sorted-heroes.component.ts" region="sorted-heroes" header="src/app/sorted-heroes.component.ts (SortedHeroesComponent)">

</code-example>


Now take note of the `afterGetHeroes()` method.
Your first instinct might have been to create an `ngOnInit` method in `SortedHeroesComponent` and do the sorting there.
But Angular calls the *derived* class's `ngOnInit` *before* calling the base class's `ngOnInit`
so you'd be sorting the heroes array *before they arrived*. That produces a nasty error.

Overriding the base class's `afterGetHeroes()` method solves the problem.

These complications argue for *avoiding component inheritance*.


{@a forwardref}

## Break circularities with a forward class reference (*forwardRef*)

The order of class declaration matters in TypeScript.
You can't refer directly to a class until it's been defined.

This isn't usually a problem, especially if you adhere to the recommended *one class per file* rule.
But sometimes circular references are unavoidable.
You're in a bind when class 'A' refers to class 'B' and 'B' refers to 'A'.
One of them has to be defined first.

The Angular `forwardRef()` function creates an *indirect* reference that Angular can resolve later.

The *Parent Finder* sample is full of circular class references that are impossible to break.

You face this dilemma when a class makes *a reference to itself*
as does `AlexComponent` in its `providers` array.
The `providers` array is a property of the `@Component()` decorator function which must
appear *above* the class definition.

Break the circularity with `forwardRef`.

<code-example path="dependency-injection-in-action/src/app/parent-finder.component.ts" region="alex-providers" header="parent-finder.component.ts (AlexComponent providers)"></code-example>
