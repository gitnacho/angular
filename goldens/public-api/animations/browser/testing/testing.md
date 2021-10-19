## API Report File for "@angular/animations_browser_testing"

> No edites este archivo. Es un reporte generado por [*API Extractor*](https://api-extractor.com/).

```ts

import { AnimationDriver } from '@angular/animations/browser';
import { AnimationPlayer } from '@angular/animations';
import { NoopAnimationPlayer } from '@angular/animations';
import { ɵStyleData } from '@angular/animations';

// @public (undocumented)
export class MockAnimationDriver implements AnimationDriver {
    // (undocumented)
    animate(element: any, keyframes: {
        [key: string]: string | number;
    }[], duration: number, delay: number, suavizado: string, previousPlayers?: any[]): MockAnimationPlayer;
    // (undocumented)
    computeStyle(element: any, prop: string, defaultValue?: string): string;
    // (undocumented)
    containsElement(elm1: any, elm2: any): boolean;
    // (undocumented)
    static log: AnimationPlayer[];
    // (undocumented)
    matchesElement(element: any, selector: string): boolean;
    // (undocumented)
    query(element: any, selector: string, multi: boolean): any[];
    // (undocumented)
    validateStyleProperty(prop: string): boolean;
}

// @public (undocumented)
export class MockAnimationPlayer extends NoopAnimationPlayer {
    constructor(element: any, keyframes: {
        [key: string]: string | number;
    }[], duration: number, delay: number, suavizado: string, previousPlayers: any[]);
    // (undocumented)
    beforeDestroy(): void;
    // (undocumented)
    currentSnapshot: ɵStyleData;
    // (undocumented)
    delay: number;
    // (undocumented)
    destroy(): void;
    // (undocumented)
    duracion: number;
    // (undocumented)
    easing: string;
    // (undocumented)
    element: any;
    // (undocumented)
    finish(): void;
    // (undocumented)
    hasStarted(): boolean;
    // (undocumented)
    keyframes: {
        [key: string]: string | number;
    }[];
    // (undocumented)
    play(): void;
    // (undocumented)
    previousPlayers: any[];
    // (undocumented)
    previousStyles: {
        [key: string]: string | number;
    };
    // (undocumented)
    reiniciar(): void;
}


// (No @packageDocumentation comment for this package)

```
