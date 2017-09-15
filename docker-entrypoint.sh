#!/bin/bash
set -e

if [ "$CREATE_USER_UID" -a "$CREATE_USER_GID" ]; then
    echo "Create 'site-owner' group with GID=$CREATE_USER_GID"
    groupadd -g $CREATE_USER_GID site-owner
    echo "Add 'www-data' user to group 'site-owner'"
    usermod -a -G site-owner www-data
    echo "Create 'site-owner' user with UID=$CREATE_USER_UID, GID=$CREATE_USER_GID"
    useradd -d /var/www -g $CREATE_USER_GID -s /bin/false -M -N -u $CREATE_USER_UID site-owner
fi

if [ -n "$PACKAGE_DIR" -a -d "$PACKAGE_DIR" ]; then
    cd $PACKAGE_DIR
    /usr/bin/yarn install --production --global --link-folder /usr/local/bin/ --modules-folder /usr/lib/node_modules/ --global-folder /usr/lib/node_modules/
fi

if [ "$@" = "start" ]; then
	cd $PACKAGE_DIR
	/usr/local/bin/gosu site-owner:site-owner /usr/bin/yarn start
else
	exec "$@"
fi
