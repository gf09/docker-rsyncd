FROM debian:stable-slim

# Install rsync with iconv support and netcat-openbsd for healthcheck
RUN apt-get update && \
    apt-get install -y rsync netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Copy your rsyncd.conf into the image
COPY rsyncd.conf /etc/rsyncd.conf

# Expose the rsync daemon port
EXPOSE 873

# Add a healthcheck to verify rsync daemon is responsive
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD nc -z localhost 873 || exit 1

# Run rsync daemon in foreground with your config
CMD ["rsync", "--daemon", "--no-detach", "--config=/etc/rsyncd.conf"]
