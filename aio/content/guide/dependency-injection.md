# Inyección de dependencias en *Angular*

Las dependencias son servicios u objetos que una clase necesita para llevar a cabo su función.
La inyección de dependencias, o *ID*, es un patrón de diseño en el que una clase solicita dependencias de fuentes externas en lugar de crearlas.

El marco *ID* de *Angular* proporciona dependencias a una clase en la instanciación.
Utiliza la *ID* de *Angular* para aumentar la flexibilidad y modularidad en tus aplicaciones.

<div class="alert is-helpful">

Consulta el <live-example></live-example> para ver un ejemplo funcional que contiene los fragmentos de código de esta guía.

</div>

## Crear un servicio inyectable

Para generar una nueva clase `HeroService` en el directorio `src/app/heroes` usa el siguiente comando de la [*CLI* de *Angular*](cli).

<code-example language="sh">
ng generate service heroes/hero
</code-example>

Este comando crea el siguiente `HeroService` predeterminado.

<code-example path="dependency-injection/src/app/heroes/hero.service.0.ts" header="src/app/heroes/hero.service.ts (CLI-generated)">
</code-example>

El decorador `@Injectable()` especifica que *Angular* puede usar esta clase en el sistema *ID*.
Los metadatos, `provideIn: 'root'`, significa que el `HeroService` es visible en toda la aplicación.

A continuación, para obtener los datos simulados del héroe, agrega un método `getHeroes()` que devuelva los héroes de `mock.heroes.ts`.

<code-example path="dependency-injection/src/app/heroes/hero.service.3.ts" header="src/app/heroes/hero.service.ts">
</code-example>

Para mayor claridad y facilidad de mantenimiento, se recomienda que definas los componentes y servicios en archivos separados.

Si (acaso) combinas un componente y un servicio en el mismo archivo, es importante definir primero el servicio y luego el componente.
Si defines el componente antes del servicio, *Angular* devuelve un error de referencia nulo en el entorno de ejecución.


{@a injector-config}
{@a bootstrap}

## Inyección de servicios

La inyección de servicios hace que sean visibles para un componente.

Para inyectar una dependencia en el `constructor()` de un componente, proporciona un argumento al constructor con el tipo de dependencia.
El siguiente ejemplo especifica el `HeroService` en el constructor `HeroListComponent`.
El tipo de `heroService` es `HeroService`.

<code-example header="src/app/heroes/hero-list.component (constructor signature)" path="dependency-injection/src/app/heroes/hero-list.component.ts"
region="ctor-signature">
</code-example>


Para obtener más información, consulta [Proporcionar dependencias en módulos](guide/providers) y [Inyectores jerárquicos](guide/hierarchical-dependency-injection).

{@a service-needs-service}

## Usar servicios en otros servicios

Cuando un servicio depende de otro servicio, sigue el mismo patrón para inyectar en un componente.
En el siguiente ejemplo, `HeroService` depende de un servicio `Logger` para informar de sus actividades.

Primero, importa el servicio `Logger`.
A continuación, inyecta el servicio `Logger` en el `constructor()` de `HeroService` especificando `private logger: Logger` entre paréntesis.

Cuando creas una clase cuyo `constructor()` tiene parámetros, especifica el tipo y metadatos sobre esos parámetros para que *Angular* pueda inyectar el servicio correcto.

Aquí, el `constructor()` especifica un tipo de `Logger` y almacena la instancia de `Logger` en un campo privado llamado `logger`.


Las siguientes pestañas de código presentan el servicio `Logger` y dos versiones de `HeroService`.
La primera versión de `HeroService` no depende del servicio `Logger`.
La segunda versión revisada depende del servicio `Logger`.

<code-tabs>

  <code-pane header="src/app/heroes/hero.service (v2)" path="dependency-injection/src/app/heroes/hero.service.2.ts">
  </code-pane>

  <code-pane header="src/app/heroes/hero.service (v1)" path="dependency-injection/src/app/heroes/hero.service.1.ts">
  </code-pane>

  <code-pane header="src/app/logger.service"
  path="dependency-injection/src/app/logger.service.ts">
  </code-pane>

</code-tabs>

En este ejemplo, el método `getHeroes()` usa el servicio `Logger` al registrar un mensaje cuando se buscan héroes.

## ¿Qué sigue?

* [Proveedores de dependencia](guide/dependency-injection-providers)
* [*Tokens* y proveedores de *ID*](guide/dependency-injection-providers)
* [Inyección de dependencias en acción](guide/dependency-injection-in-action)
