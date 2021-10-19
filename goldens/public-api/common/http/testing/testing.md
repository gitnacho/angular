## API Report File for "@angular/common_http_testing"

> No edites este archivo. Es un reporte generado por [*API Extractor*](https://api-extractor.com/).

```ts

import { HttpEvent } from '@angular/common/http';
import { HttpHeaders } from '@angular/common/http';
import { HttpRequest } from '@angular/common/http';
import * as i0 from '@angular/core';
import * as i1 from '@angular/common/http';
import { Observer } from 'rxjs';

// @public
export class HttpClientTestingModule {
    // (undocumented)
    static ɵfac: i0.ɵɵFactoryDeclaration<HttpClientTestingModule, never>;
    // (undocumented)
    static ɵinj: i0.ɵɵInjectorDeclaration<HttpClientTestingModule>;
    // (undocumented)
    static ɵmod: i0.ɵɵNgModuleDeclaration<HttpClientTestingModule, never, [typeof i1.HttpClientModule], never>;
}

// @public
export abstract class HttpTestingController {
    abstract expectNone(url: string, description?: string): void;
    abstract expectNone(params: RequestMatch, description?: string): void;
    abstract expectNone(matchFn: ((req: HttpRequest<any>) => boolean), description?: string): void;
    abstract expectNone(match: string | RequestMatch | ((req: HttpRequest<any>) => boolean), description?: string): void;
    abstract expectOne(url: string, description?: string): TestRequest;
    abstract expectOne(params: RequestMatch, description?: string): TestRequest;
    abstract expectOne(matchFn: ((req: HttpRequest<any>) => boolean), description?: string): TestRequest;
    abstract expectOne(match: string | RequestMatch | ((req: HttpRequest<any>) => boolean), description?: string): TestRequest;
    abstract match(match: string | RequestMatch | ((req: HttpRequest<any>) => boolean)): TestRequest[];
    abstract verify(opts?: {
        ignoreCancelled?: boolean;
    }): void;
}

// @public
export interface RequestMatch {
    // (undocumented)
    method?: string;
    // (undocumented)
    url?: string;
}

// @public
export class TestRequest {
    constructor(request: HttpRequest<any>, observer: Observer<HttpEvent<any>>);
    get cancelled(): boolean;
    error(error: ErrorEvent, opts?: {
        headers?: HttpHeaders | {
            [name: string]: string | string[];
        };
        status?: number;
        statusText?: string;
    }): void;
    event(event: HttpEvent<any>): void;
    flush(body: ArrayBuffer | Blob | boolean | string | number | Object | (boolean | string | number | Object | null)[] | null, opts?: {
        headers?: HttpHeaders | {
            [name: string]: string | string[];
        };
        status?: number;
        statusText?: string;
    }): void;
    // (undocumented)
    request: HttpRequest<any>;
}

// (No @packageDocumentation comment for this package)

```