# Encriptación

Basado en https://github.com/circleci/encrypted-files

En la interfaz de usuario web de *CircleCI*, tenemos una variable secreta llamada `KEY`
https://circleci.com/gh/angular/angular/edit#env-vars
que solo está expuesta a compilaciones que no son de bifurcación
(consulte "Pasar secretos a compilaciones a partir de solicitudes de extracción bifurcadas" en
https://circleci.com/gh/angular/angular/edit#advanced-settings)

Usamos esto como una clave de cifrado *AES* simétrica para cifrar tokens como
un `token` de *GitHub* que permite publicar instantáneas.

Para crear el archivo `github_token`, tomamos este enfoque:
- Encuentra las compilaciones-Angular:token en la base de datos interna de pw
- Ve dentro de la imagen de la ventana acoplable predeterminada de `CircleCI` para que use la misma versión de `openssl` que usaremos en el entorno de ejecución: `docker run --rm -it circleci/node:10.12`
- echo "https://[token]:@github.com" > credentials
- openssl aes-256-cbc -e -in credentials -out .circleci/github_token -k $KEY
- Si es necesario, codifica en base64 el resultado para que lo puedas copiar y pegar fuera de la ventana acoplable: `base64 github_token`
