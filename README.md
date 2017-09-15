# nodejs

Node.JS

Based on debian:stretch.

## Building

Just run `make`.

## Volumes

* `/var/www`
* `/var/lib/nodejs/node_modules`

## Exposed ports

## Environment variables

* `CREATE_USER_UID`
* `CREATE_USER_GID`
* `NODE_PATH` (default: `/var/lib/nodejs/node_modules`)
* `NPM_CONFIG_PREFIX` (default: `/var/lib/nodejs/node_modules`)
* `PACKAGE_DIR` (optional, directory where `package.json` is located)
