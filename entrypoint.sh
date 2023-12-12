#!/bin/bash

# Set file permissions with delay after supervisord is up in a very silly way ^_^
(sleep 3s && chown sentry /var/run/supervisor.sock && chmod 660 /var/run/supervisor.sock) &

# Run supervisord
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
