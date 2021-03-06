FROM debian:11-slim
RUN mkdir -p /root/.regctl
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
COPY --from=regclient/regctl /regctl /usr/bin/regctl
COPY ./scripts/* /usr/bin/