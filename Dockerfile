FROM debian:stable-slim

# Install rsync with iconv support
RUN apt-get update && \
    apt-get install -y rsync && \
    rm -rf /var/lib/apt/lists/*

# Copy your rsyncd.conf into the image
COPY rsyncd.conf /etc/rsyncd.conf

# Expose the rsync daemon port
EXPOSE 873

# Run rsync daemon in foreground with your config
CMD ["rsync", "--daemon", "--no-detach", "--config=/etc/rsyncd.conf"]
