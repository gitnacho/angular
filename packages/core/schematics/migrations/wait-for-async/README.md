## async -> waitForAsync migration

Automatically migrates from `async` to `waitForAsync` by changing function calls and renaming imports.

#### Antes
```ts
import { async } from '@angular/core/testing';

it('should work', async(() => {
  // async testing logic
}));
```

#### Después:
```ts
import { waitForAsync } from '@angular/core/testing';

it('should work', waitForAsync(() => {
  // async testing logic
}));
```
