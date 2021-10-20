Este es un directorio que define el punto de entrada `@angular/compiler-cli/private`. El punto de entrada se puede utilizar para
exponer el código que necesitan otros paquetes del marco *Angular*, sin tener que exponer el código a través del
punto de entrada primario.

El punto de entrada principal tiene un par de desventajas cuando se trata de importación de paquetes cruzados:
 * Exporta varias otras cosas que terminarán creando dependencias de tipos adicionales. p.ej. cuando
   el paquete de localización de *Angular* se basa en él, podrías terminar confiando accidentalmente en `@types/node`.
 * El punto de entrada principal tiene un gráfico de construcción más grande, lo que ralentiza el desarrollo local al igual que muchas más cosas.
   puede invalidar los objetivos dependientes. Un subconjunto más pequeño conduce a compilaciones incrementales más rápidas.