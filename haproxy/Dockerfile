# syntax=docker/dockerfile:1

FROM haproxy:lts-alpine
RUN apk update; apk --no-progress --no-cache add \
    iptables iproute2; \
    apk --no-progress --no-cache upgrade; \
    rm -rf /var/cache/apk/*;
