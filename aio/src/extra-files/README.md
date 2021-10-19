# Directorio de archivos adicionales

Este directorio se usa para archivos adicionales que se deben incluir en implementaciones en `firebase`.

Después de que se haya creado la aplicación `AIO` y antes de que se implementen todos los archivos y directorios
dentro del directorio con el mismo nombre que el modo de implementación actual (siguiente, estable, archivo)
se copiará al directorios `dist`.

Consulta el script `scripts/deploy-to-firebase.js` para obtener más detalles.

**Nota**:
El script `deploy-to-firebase.js` siempre espera que haya un directorio para el modo de implementación actual
(incluso si está vacío).
