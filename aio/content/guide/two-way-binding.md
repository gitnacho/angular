# Two-way binding

Two-way binding gives components in your application a way to share data.
Use two-way binding to listen for events and update values simultaneously between parent and child components.

<div class="alert is-helpful">

Consulta el <live-example></live-example> para ver un ejemplo funcional que contiene los fragmentos de código de esta guía.

</div>

## Requisitos previos

To get the most out of two-way binding, you should have a basic understanding of the following concepts:

* [Property binding](guide/property-binding)
* [Event binding](guide/event-binding)
* [Inputs and Outputs](guide/inputs-outputs)

<hr>

Two-way binding combines property binding with event binding:

* [Property binding](guide/property-binding) sets a specific element property.
* [Event binding](guide/event-binding) listens for an element change event.

## Adding two-way data binding

Angular's two-way binding syntax is a combination of square brackets and parentheses, `[()]`.
The `[()]` syntax combines the brackets of property binding, `[]`, with the parentheses of event binding, `()`, as follows.

<code-example path="two-way-binding/src/app/app.component.html" header="src/app/app.component.html" region="two-way-syntax"></code-example>

## How two-way binding works

For two-way data binding to work, the `@Output()` property must use the pattern, `inputChange`, where `input` is the name of the `@Input()` property.
For example, if the `@Input()` property is `size`, the `@Output()` property must be `sizeChange`.

The following `sizerComponent` has a `size` value property and a `sizeChange` event.
The `size` property is an `@Input()`, so data can flow into the `sizerComponent`.
The `sizeChange` event is an `@Output()`, which lets data flow out of the `sizerComponent` to the parent component.

Next, there are two methods, `dec()` to decrease the font size and `inc()` to increase the font size.
These two methods use `resize()` to change the value of the `size` property within min/max value constraints, and to emit an event that conveys the new `size` value.

<code-example path="two-way-binding/src/app/sizer/sizer.component.ts" region="sizer-component" header="src/app/sizer.component.ts"></code-example>

The `sizerComponent` template has two buttons that each bind the click event to the `inc()` and `dec()` methods.
When the user clicks one of the buttons, the `sizerComponent` calls the corresponding method.
Both methods, `inc()` and `dec()`, call the `resize()` method with a `+1` or `-1`, which in turn raises the `sizeChange` event with the new size value.

<code-example path="two-way-binding/src/app/sizer/sizer.component.html" header="src/app/sizer.component.html"></code-example>


In the `AppComponent` template, `fontSizePx` is two-way bound to the `SizerComponent`.

<code-example path="two-way-binding/src/app/app.component.html" header="src/app/app.component.html" region="two-way-1"></code-example>

In the `AppComponent`, `fontSizePx` establishes the initial `SizerComponent.size` value by setting the value to `16`.

<code-example path="two-way-binding/src/app/app.component.ts" header="src/app/app.component.ts" region="font-size"></code-example>

Clicking the buttons updates the `AppComponent.fontSizePx`.
The revised `AppComponent.fontSizePx` value updates the style binding, which makes the displayed text bigger or smaller.

The two-way binding syntax is shorthand for a combination of property binding and event binding.
The `SizerComponent` binding as separate property binding and event binding is as follows.

<code-example path="two-way-binding/src/app/app.component.html" header="src/app/app.component.html (expanded)" region="two-way-2"></code-example>

The `$event` variable contains the data of the `SizerComponent.sizeChange` event.
Angular assigns the `$event` value to the `AppComponent.fontSizePx` when the user clicks the buttons.

<div class="callout is-helpful">

  <header>Two-way binding in forms</header>

  Because no built-in HTML element follows the `x` value and `xChange` event pattern, two-way binding with form elements requires `NgModel`.
  For more information on how to use two-way binding in forms, see Angular [NgModel](guide/built-in-directives#ngModel).

</div>
