# Use Ubuntu base image
FROM --platform=linux/amd64  ubuntu:latest

# Set environment variables
ENV USER sentry
ENV HOME /home/$USER
# Install necessary packages for download and unpacking
RUN apt-get update \
  && apt-get install -y curl unzip bash jq supervisor expect cron \
  && rm -rf /var/lib/apt/lists/*

# Create sentry user
RUN useradd --create-home --shell /bin/bash $USER

# Add scripts and configurations
COPY --chown=$USER:$USER notify_webhook.sh $HOME/notify_webhook.sh
COPY --chown=$USER:$USER check_updates.sh $HOME/check_updates.sh
COPY --chown=$USER:$USER sentry_wrapper.sh $HOME/sentry_wrapper.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY  sentry_cron /etc/cron.d/sentry_cron


# Apply cron job
RUN chmod 0644 /etc/cron.d/sentry_cron \
  && crontab -u $USER /etc/cron.d/sentry_cron

# Download, extract, and update the sentry-node-cli-linux.zip file
USER $USER
WORKDIR $HOME
RUN chmod +x $HOME/check_updates.sh
RUN chmod +x $HOME/sentry_wrapper.sh
RUN chmod +x $HOME/notify_webhook.sh
RUN $HOME/check_updates.sh

USER root
# Set up supervisor
ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]

