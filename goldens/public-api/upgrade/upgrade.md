## API Report File for "@angular/upgrade"

> No edites este archivo. Es un reporte generado por [*API Extractor*](https://api-extractor.com/).

```ts

import { CompilerOptions } from '@angular/core';
import { Injector } from '@angular/core';
import { NgModuleRef } from '@angular/core';
import { Type } from '@angular/core';
import { Version } from '@angular/core';

// @public @deprecated
export class UpgradeAdapter {
    constructor(ng2AppModule: Type<any>, compilerOptions?: CompilerOptions | undefined);
    bootstrap(element: Element, modules?: any[], config?: IAngularBootstrapConfig): UpgradeAdapterRef;
    downgradeNg2Component(component: Type<any>): Function;
    downgradeNg2Provider(token: any): Function;
    registerForNg1Tests(modules?: string[]): UpgradeAdapterRef;
    upgradeNg1Component(name: string): Type<any>;
    upgradeNg1Provider(name: string, options?: {
        asToken: any;
    }): void;
}

// @public @deprecated
export class UpgradeAdapterRef {
    dispose(): void;
    // (undocumented)
    ng1Injector: IInjectorService;
    // (undocumented)
    ng1RootScope: IRootScopeService;
    // (undocumented)
    ng2Injector: Injector;
    // (undocumented)
    ng2ModuleRef: NgModuleRef<any>;
    ready(fn: (upgradeAdapterRef: UpgradeAdapterRef) => void): void;
}

// @public (undocumented)
export const VERSION: Version;


// (No @packageDocumentation comment for this package)

```