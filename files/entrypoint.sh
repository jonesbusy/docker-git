#!/bin/sh

USER_ID=${LOCAL_USER_ID:-9001}
GROUP_ID=${GROUP_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
echo "Starting with GID : $GROUP_ID"

# Add user to git group
addgroup -S -g $GROUP_ID git
adduser -S -G git -u $USER_ID git

su-exec git "$@"
