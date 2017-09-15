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
	/usr/bin/npm config set prefix "$NODE_PATH"
    cd $PACKAGE_DIR
    if [ -f "$PACKAGE_DIR/yarn.lock" ]; then
        /usr/bin/yarn install
    else
        /usr/bin/npm install
    fi
fi

exec "$@"
