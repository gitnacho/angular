# Template expression operators

<div class="callout is-critical">

<header>Marked for archiving</header>

To ensure that you have the best experience possible, this topic is marked for archiving until we determine that it clearly conveys the most accurate information possible.

In the meantime, this topic might be helpful: [Hierarchical injectors](guide/hierarchical-dependency-injection).

If you think this content should not be archived, please file a [GitHub issue](https://github.com/angular/angular/issues/new?template=3-docs-bug.md).

</div>

The Angular template expression language employs a subset of JavaScript syntax supplemented with a few special operators
for specific scenarios.

<div class="alert is-helpful">

Consulta el <live-example></live-example> para ver un ejemplo funcional que contiene los fragmentos de código de esta guía.

</div>

{@a non-null-assertion-operator}

## The non-null assertion operator ( `!` )

When you use TypeScript's `--strictNullChecks` flag, you can prevent the type checker from throwing an error with Angular's non-null assertion operator, `!`.

The Angular non-null assertion operator causes the TypeScript type checker to suspend strict `null` and `undefined` checks for a specific property expression.

For example, you can assert that `item` properties are also defined.

<code-example path="template-expression-operators/src/app/app.component.html" region="non-null" header="src/app/app.component.html"></code-example>

Often, you want to make sure that any property bindings aren't `null` or `undefined`.
However, there are situations in which such states are acceptable.
For those situations, you can use Angular's non-null assertion operator to prevent TypeScript from reporting that a property is `null` or `undefined`.

The non-null assertion operator, `!`, is optional unless you turn on strict null checks.

For more information, see TypeScript's [strict null checking](http://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-0.html "Strict null checking in TypeScript").


{@a any-type-cast-function}

## The `$any()` type cast function

Sometimes a binding expression triggers a type error during [AOT compilation](guide/aot-compiler) and it is not possible or difficult to fully specify the type.
To silence the error, you can use the `$any()` cast function to cast
the expression to the [`any` type](https://www.typescriptlang.org/docs/handbook/basic-types.html#any) as in the following example:

<code-example path="built-in-template-functions/src/app/app.component.html" region="any-type-cast-function-1" header="src/app/app.component.html"></code-example>

Using `$any()` prevents TypeScript from reporting that `bestByDate` is not a member of the `item` object.

The `$any()` cast function also works with `this` to allow access to undeclared members of the component.

<code-example path="built-in-template-functions/src/app/app.component.html" region="any-type-cast-function-2" header="src/app/app.component.html"></code-example>

The `$any()` cast function works anywhere in a binding expression where a method call is valid.
