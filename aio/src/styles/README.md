# Estilos *CSS* en `angular.io`

Este documento ofrece una descripción general de cómo se implementan y organizan en archivos los estilos *CSS* de `angular.io`.


## General

Los estilos se implementan usando [*Sass*](https://sass-lang.com/) y se almacenan en archivos `.scss` en [`src/styles/`](.).

> **Nota**:<br />
> No utilizamos estilos en línea para componentes.
> Los estilos de los componentes se definen en archivos `.scss` en [`src/styles/`](.) y no se hace referencia a ellos desde los archivos de componentes.


## Organización de archivos

Los archivos `.scss` están organizados en los siguientes subdirectorios:
- [`0-base/`](./0-base): Estilos generales que afectan a toda la aplicación.
- [`1-layouts/`](./1-layouts): Estilos para áreas/componentes relacionados con el diseño de la aplicación, como `top-menu`, `footer`, páginas de mercadotecnia, etc.
- [`2-modules/`](./2-modules): Estilos para componentes especializados (como botones, código, etiquetas, etc.) y páginas específicas (como página de lista de *API*, página de "Características", etc.).
- [`custom-themes/`](./custom-themes): Puntos de entrada para los diferentes temas disponibles en la aplicación (actualmente "claro" y "oscuro" ⏤`light` y `dark` respectivamente).

También hay algunos archivos de nivel superior en `[src/styles/`](.):
- [`_app-theme.scss`](./_app-theme.scss): Define un `theme()` *Sass mixin* para crear un tema de aplicación.
- [`_constants.scss`](./_constants.scss): Define varias constantes que se utilizarán en los estilos.
- [`_mixins.scss`](./_mixins.scss): Define los *mixins* de *Sass* que se utilizarán en todos los estilos.
- [`_print.scss`](./_print.scss): Contiene estilos que se aplicarán al imprimir.
- [`main.scss`](./main.scss): Punto de entrada de estilos.


### Estilos para un área/componente específico

Para cada área/componente, hay un subdirectorio en `1-layouts/` o `2-modules/`.

Cada uno de estos subdirectorios contiene un archivo `<nombre>.scss` con estilos para el área/componente correspondiente y también puede contener un archivo `<nombre>-theme.scss` con estilos relacionados con la temática.
Consulta la siguiente sección para obtener más detalles.

Cuando es apropiado, los estilos de estos archivos deben tener como alcance el componente destino (por ejemplo, utilizando el selector del componente).


## Tematización

*Angular.io* admite la elección entre temas. Actualmente, se admiten los temas "claro" y "oscuro" ⏤`light` y `dark` respectivamente.
Consulta también [#41129](https://github.com/angular/angular/pull/41129) para obtener más detalles/explicación sobre la implementación de la temática.


## Estilos para tematizar

Los estilos de cada área/componente se dividen en dos archivos: `<nombre>.scss` y `<nombre>-theme.scss`.

Los estilos generales van en `<nombre>.scss`.
Si un área/componente tiene estilos que podrían cambiar según el tema activo (como el color o el fondo), estos se incluyen en el archivo `*-theme.scss`.
Los estilos relacionados con el color, en particular, siempre se deben incluir en ese archivo, incluso si los estilos no cambian entre temas actualmente.
Esto hará que sea más fácil ajustar/agregar más temas en el futuro.

Dentro de cada archivo `*-theme.scss` hay un *mixin Sass* que toma una configuración de tema *Material* y genera el estilo apropiado para ese tema y componente.

Ventajas del enfoque elegido:
- La temática está contenida en un archivo por componente.
  Los desarrolladores solo necesitan ser conscientes de la existencia de un solo archivo cuando realizan cambios relacionados con la temática en un componente.
- Los temas se pueden cargar de forma diferida en tiempo de ejecución, evitando el crecimiento del estilo fragmentado predeterminado cada vez que se implementa un nuevo tema.

Desventajas del enfoque elegido:
- Dividir estilos en dos archivos significa que algunos selectores se duplicarán, lo que resultará en un aumento del tamaño total del fragmento de estilos.


## Aplicar un tema en el entorno de ejecución

Al compilar la aplicación, se generan los siguientes paquetes de estilos:
- Uno [basado en `main.scss`](https://github.com/angular/angular/blob/62b5a6cb079e489d91982abe88d644d73feb73f3/aio/angular.json#L44), que siempre se incluye en` index.html` y contiene estilos (no específicos del tema).
- [Un paquete por tema](https://github.com/angular/angular/blob/62b5a6cb079e489d91982abe88d644d73feb73f3/aio/angular.json#L45-L54), que se carga "bajo demanda" y contiene estilos específicos del tema.

Un paquete de temas se [carga en el entorno de ejecución](https://github.com/angular/angular/blob/62b5a6cb079e489d91982abe88d644d73feb73f3/aio/src/index.html#L33-L36) usando la regla [`@import`](https://developer.mozilla.org/es/docs/Web/CSS/@import) de *CSS*.
El tema apropiado se elige en función de las preferencias del usuario (ya sea a través de una configuración del sistema operativo o una configuración de agente de usuario) utilizando la [consulta de medios `prefers-color-esquema`](https://developer.mozilla.org/es/docs/Web/CSS/@media/prefers-color-scheme).

Una vez que la aplicación ha arrancado, el tema se [puede actualizar](https://github.com/angular/angular/blob/62b5a6cb079e489d91982abe88d644d73feb73f3/aio/src/app/shared/theme-picker/theme-toggle.component.ts#L49-L72) según una preferencia específica de la aplicación almacenada previamente.
Siempre que el usuario cambie explícitamente el tema usando el componente de alternancia de tema, la nueva preferencia [se almacena](https://github.com/angular/angular/blob/62b5a6cb079e489d91982abe88d644d73feb73f3/aio/src/app/shared/theme-picker/theme-toggle.component.ts#L89) para usarla en futuras visitas.

> **Nota**:<br />
> La infraestructura de tematización se basa en la implementación de [*material.angular.io*](https://github.com/angular/material.angular.io).
