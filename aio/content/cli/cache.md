
# Persistent disk cache
Angular CLI saves a number of cachable operations on disk by default.

When you re-run the same build, the build system restores the state of the previous build and re-uses previously performed operations, which decreases the time taken to build and test your applications and libraries.

Para modificar la configuración de caché predeterminada, agrega el objeto `cli.cache` a tu [Configuración del espacio de trabajo](guide/workspace-config).
El objeto va debajo de `cli.cache` en el nivel superior del archivo, fuera de las secciones de `projects`.

```json
{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "version": 1,
  "cli": {
    "cache": {
      ...
    }
  },
  "projects": {}
}
```

Para obtener más información, consulta [opciones de caché](guide/workspace-config#opciones-de-cache).

### Enabling and disabling the cache
Caching is enabled by default. To disable caching run the following command:

```bash
ng config cli.cache.enabled false
```

To re-enable caching, set `cli.cache.enabled` to `true`.

### Cache environments
By default, disk cache is only enabled for local environments.

To enable caching for all environments, run the following command:

```bash
ng config cli.cache.environment all
```

Para obtener más información, consulta `environment` en [opciones de caché](guide/workspace-config#opciones-de-cache).

<div class="alert is-helpful">

The Angular CLI checks for the presence and value of the `CI` environment variable to determine in which environment it is running.

</div>

### Cache path

By default, `.angular/cache` is used as a base directory to store cache results. To change this path, run the following command:

```bash
ng config cli.cache.path ".cache/ng"
```

### Clearing the cache

To clear the cache, run one of the following commands.

To clear the cache on Unix-based operating systems:

```bash
rm -rf .angular/cache
```

To clear the cache on Windows:

```bash
rmdir /s /q .angular/cache
```

For more information, see [rm command](https://man7.org/linux/man-pages/man1/rm.1.html) and [rmdir command](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/rmdir).