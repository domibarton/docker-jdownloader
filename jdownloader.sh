#!/bin/bash
set -e

#
# Display settings on standard out.
#

USER="jdownloader"

echo "JDownloader settings"
echo "===================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${JDOWNLOADER_UID:=666}"
echo "  GID:        ${JDOWNLOADER_GID:=666}"
echo

#
# Change UID / GID of JDownloader user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${JDOWNLOADER_UID} ]] || usermod  -o -u ${JDOWNLOADER_UID} ${USER}
[[ $(id -g ${USER}) == ${JDOWNLOADER_GID} ]] || groupmod -o -g ${JDOWNLOADER_GID} ${USER}
echo "[DONE]"

#
# Set directory permissions.
#

printf "Setting permissions... "
chown -R ${USER}: /jdownloader
chown ${USER}: /media
echo "[DONE]"

#
# Finally, start JDownloader.
#

echo "Starting JDownloader..."
exec su -pc "java -Djava.awt.headless=true -jar JDownloader.jar" ${USER}
