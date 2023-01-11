# syntax=docker/dockerfile:1

FROM haproxy:lts-alpine
USER root
RUN apk update; apk --no-progress --no-cache add \
    iptables iproute2; \
    apk --no-progress --no-cache upgrade; \
    rm -rf /var/cache/apk/*;
COPY --link --chmod=755 ./entrypoint.sh /

# USER haproxy
ENTRYPOINT [ "/entrypoint.sh" ]
