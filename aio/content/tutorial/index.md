<h1 class="no-toc">Tutorial y aplicación <code>Tour of Heroes</code></h1>

<div class="callout is-helpful">
<header>Primeros pasos</header>

En este tutorial, crearás tu propia aplicación desde cero, proporcionando experiencia con el proceso de desarrollo típico, así como una introducción a los conceptos, herramientas y terminología básicos del diseño de aplicaciones.

Si eres completamente nuevo en *Angular*, es posible que desees probar primero la aplicación de inicio rápido [**Pruébala ahora**](start).
Está basada en un proyecto listo para usar y parcialmente completado, que puedes examinar y modificar en el entorno de desarrollo interactivo *StackBlitz*, donde puedes ver los resultados en tiempo real.

El tutorial "Pruébalo" cubre los mismos temas principales (componentes, sintaxis de plantilla, enrutamiento, servicios y acceso a datos mediante *HTTP*) en un formato condensado, siguiendo las mejores prácticas más actuales.

</div>

Este tutorial de `Tour of Heroes` te muestra cómo configurar tu entorno de desarrollo local y desarrollar una aplicación usando la [herramienta *CLI* de *Angular*](cli "referencia de comandos CLI"), y proporciona una introducción a los fundamentos de *Angular*.

La aplicación `Tour of Heroes` que crearás ayuda a una agencia de personal a administrar su establo de héroes.
La aplicación tiene muchas de las características que esperarías encontrar en cualquier aplicación basada en datos.
La aplicación terminada adquiere y muestra una lista de héroes, edita el detalle de un héroe seleccionado y navega entre diferentes vistas de datos heroicos.

Encontrarás referencias y expansiones de este dominio de aplicación en muchos de los ejemplos utilizados en la documentación de *Angular*, pero no es necesario que sigas este tutorial para comprender esos ejemplos.

Al final de este tutorial, podrás hacer lo siguiente:

* Utilizar [directivas *Angular*](guide/glossary#directiva "Definición de directivas")   incorporadas para mostrar y ocultar elementos y mostrar listas de datos del héroe.
* Crear [componentes *Angular*](guide/glossary#componente "Definición de componentes") para mostrar los detalles del héroe y mostrar un arreglo de héroes.
* Utilizar [enlace unidireccional de datos](guide/glossary#vinculacion-de-datos "Definición de vinculación de datos") para datos de solo lectura.
* Add editable fields to update a model with two-way data binding.
* Bind component methods to user events, like keystrokes and clicks.
* Enable users to select a hero from a master list and edit that hero in the details view.
* Format data with [pipes](guide/glossary#pipe "Pipe definition").
* Create a shared [service](guide/glossary#service "Service definition") to assemble the heroes.
* Use [routing](guide/glossary#router "Router definition") to navigate among different views and their components.

You'll learn enough Angular to get started and gain confidence that
Angular can do whatever you need it to do.

<div class="callout is-helpful">
<header>Solution</header>

After completing all tutorial steps, the final application will look like this: <live-example name="toh-pt6"></live-example>.

</div>

## What you'll build

Here's a visual idea of where this tutorial leads, beginning with the "Dashboard"
view and the most heroic heroes:

<div class="lightbox">
  <img src='generated/images/guide/toh/heroes-dashboard-1.png' alt="Output of heroes dashboard">
</div>

You can click the two links above the dashboard ("Dashboard" and "Heroes")
to navigate between this Dashboard view and a Heroes view.

If you click the dashboard hero "Magneta," the router opens a "Hero Details" view
where you can change the hero's name.

<div class="lightbox">
  <img src='generated/images/guide/toh/hero-details-1.png' alt="Details of hero in app">
</div>

Clicking the "Back" button returns you to the Dashboard.
Links at the top take you to either of the main views.
If you click "Heroes," the application displays the "Heroes" master list view.


<div class="lightbox">
  <img src='generated/images/guide/toh/heroes-list-2.png' alt="Output of heroes list app">
</div>

When you click a different hero name, the read-only mini detail beneath the list reflects the new choice.

You can click the "View Details" button to drill into the
editable details of the selected hero.

The following diagram captures all of the navigation options.

<div class="lightbox">
  <img src='generated/images/guide/toh/nav-diagram.png' alt="View navigations">
</div>

Here's the application in action:

<div class="lightbox">
  <img src='generated/images/guide/toh/toh-anim.gif' alt="Tour of Heroes in Action">
</div>
