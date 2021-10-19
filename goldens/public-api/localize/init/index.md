## API Report File for "@angular/localize_init"

> No edites este archivo. Es un reporte generado por [*API Extractor*](https://api-extractor.com/).

```ts

// @public
const $localize_2: LocalizeFn;

export { $localize_2 as $localize }

// @public (undocumented)
export interface LocalizeFn {
    // (undocumented)
    (messageParts: TemplateStringsArray, ...expressions: readonly any[]): string;
    locale?: string;
    translate?: TranslateFn;
}

// @public (undocumented)
export interface TranslateFn {
    // (undocumented)
    (messageParts: TemplateStringsArray, expressions: readonly any[]): [TemplateStringsArray, readonly any[]];
}


// (No @packageDocumentation comment for this package)

```
