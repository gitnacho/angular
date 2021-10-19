## Router migration to remove canActivate property from Routes that also have redirectTo

The activation stage of the router happens after redirects so any `canActivate` guards
will not be executed. This invalid configuration is now an error. This migration 
removes `canActivate` from the `Route` to fix pre-existing invalid configurations.

#### Antes
```ts
import { Routes } from '@angular/router';

const routes: Routes = [
  {path: '', redirectTo: 'other', canActivate: [MyGuard]}
];
```

#### Después:
```ts
import { Routes } from '@angular/router';

const routes: Routes = [
  {path: '', redirectTo: 'other'}
];
```
