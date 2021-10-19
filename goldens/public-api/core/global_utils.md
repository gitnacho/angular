## API Report File for "angular-srcs"

> No edites este archivo. Es un reporte generado por [*API Extractor*](https://api-extractor.com/).

```ts

// @public
export function applyChanges(component: {}): void;

// @public
export interface ComponentDebugMetadata extends DirectiveDebugMetadata {
    // (undocumented)
    changeDetection: ChangeDetectionStrategy;
    // (undocumented)
    encapsulation: ViewEncapsulation;
}

// @public
export interface DirectiveDebugMetadata {
    // (undocumented)
    inputs: Record<string, string>;
    // (undocumented)
    outputs: Record<string, string>;
}

// @public
export function getComponent<T>(element: Element): T | null;

// @public
export function getContext<T>(element: Element): T | null;

// @public
export function getDirectiveMetadata(directiveOrComponentInstance: any): ComponentDebugMetadata | DirectiveDebugMetadata | null;

// @public
export function getDirectives(node: Node): {}[];

// @public
export function getHostElement(componentOrDirective: {}): Element;

// @public
export function getInjector(elementOrDir: Element | {}): Injector;

// @public
export function getListeners(element: Element): Listener[];

// @public
export function getOwningComponent<T>(elementOrDir: Element | {}): T | null;

// @public
export function getRootComponents(elementOrDir: Element | {}): {}[];

// @public
export interface Listener {
    callback: (value: any) => any;
    element: Element;
    name: string;
    type: 'dom' | 'output';
    useCapture: boolean;
}


// (No @packageDocumentation comment for this package)

```
