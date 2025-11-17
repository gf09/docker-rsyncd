FROM debian:stable-slim
RUN apt-get update && apt-get install -y rsync && rm -rf /var/lib/apt/lists/*
COPY rsyncd.conf /etc/rsyncd.conf
EXPOSE 873
CMD ["rsync", "--daemon", "--no-detach", "--config=/etc/rsyncd.conf"]
