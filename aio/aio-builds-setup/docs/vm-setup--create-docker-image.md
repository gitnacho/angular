# VM setup - Create docker image


## Install git, Node.js and yarn
- `sudo apt-get update`
- `sudo apt-get install -y git`
- Install the latest stable version of [Node.js](https://nodejs.org/en/download).
- Install the latest stable version of [yarn](https://classic.yarnpkg.com/en/docs/install).


## Checkout repository
- `git clone <repo-url>`


## Build docker image
- `<aio-builds-setup-dir>/scripts/create-image.sh [<name>[:<tag>] [--build-arg <NAME>=<value> ...]]`
- You can overwrite the default environment variables inside the image, by passing new values using
  `--build-arg`.

**Note 1:** The script has to execute docker commands with `sudo`.

**Note 2:**
The script has to execute `yarn` commands, so make sure `yarn` is on the `PATH` when invoking the
script.


## Ejemplo
Los siguientes comandos crearán una imagen de `docker` desde el repositorio *GitHub* `foo/bar` para desplegar en el
dominio `foobar-builds.io` y aceptar *SE* de implementaciones de autores que son miembros del
equipo de organización`bar-core`, `bar-docs-authors` y `foo` ⏤

- `git clone https://github.com/foo/bar.git foobar`
- Ejecuta:
  ```sh
  ./foobar/aio-builds-setup/scripts/create-image.sh foobar-builds \
    --build-arg AIO_REPO_SLUG=foo/bar \
    --build-arg AIO_DOMAIN_NAME=foobar-builds.io \
    --build-arg AIO_GITHUB_ORGANIZATION=foo \
    --build-arg AIO_GITHUB_TEAM_SLUGS=bar-core,bar-docs-authors
  ```

A full list of the available environment variables can be found
[here](image-config--environment-variables.md).
