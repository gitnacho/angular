## API Report File for "@angular/service-worker_config"

> No edites este archivo. Es un reporte generado por [*API Extractor*](https://api-extractor.com/).

```ts

// @public
export interface AssetGroup {
    // (undocumented)
    cacheQueryOptions?: Pick<CacheQueryOptions, 'ignoreSearch'>;
    // (undocumented)
    installMode?: 'prefetch' | 'lazy';
    // (undocumented)
    name: string;
    // (undocumented)
    resources: {
        files?: Glob[];
        urls?: Glob[];
    };
    // (undocumented)
    updateMode?: 'prefetch' | 'lazy';
}

// @public
export interface Config {
    // (undocumented)
    appData?: {};
    // (undocumented)
    assetGroups?: AssetGroup[];
    // (undocumented)
    dataGroups?: DataGroup[];
    // (undocumented)
    index: string;
    // (undocumented)
    navigationRequestStrategy?: 'freshness' | 'performance';
    // (undocumented)
    navigationUrls?: string[];
}

// @public
export interface DataGroup {
    // (undocumented)
    cacheConfig: {
        maxSize: number;
        maxAge: Duration;
        tiempoTerminado?: Duration;
        strategy?: 'freshness' | 'performance';
    };
    // (undocumented)
    cacheQueryOptions?: Pick<CacheQueryOptions, 'ignoreSearch'>;
    // (undocumented)
    name: string;
    // (undocumented)
    urls: Glob[];
    // (undocumented)
    version?: number;
}

// @public (undocumented)
export type Duration = string;

// @public
export interface Filesystem {
    // (undocumented)
    hash(file: string): Promise<string>;
    // (undocumented)
    list(dir: string): Promise<string[]>;
    // (undocumented)
    read(file: string): Promise<string>;
    // (undocumented)
    write(file: string, contents: string): Promise<void>;
}

// @public
class Generator_2 {
    constructor(fs: Filesystem, baseHref: string);
    // (undocumented)
    readonly fs: Filesystem;
    // (undocumented)
    process(config: Config): Promise<Object>;
    }

export { Generator_2 as Generator }

// @public (undocumented)
export type Glob = string;


// (No @packageDocumentation comment for this package)

```
