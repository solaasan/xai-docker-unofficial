#!/bin/bash

# delayed to give enough time for sentry to assume control
(sleep 3s && chown sentry /var/run/supervisor.sock && chmod 660 /var/run/supervisor.sock) &

# Run supervisord
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
