# syntax=docker/dockerfile:1

FROM bitnami/minideb
ENV packets_mark=123
RUN install_packages iproute2 iptables
ADD  --link --chmod=775 https://github.com/IceCodeNew/go-collection/raw/latest-release/assets/go-mmproxy /usr/local/bin/go-mmproxy
COPY --link --chmod=775 entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
