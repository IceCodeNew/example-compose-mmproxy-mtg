# syntax=docker/dockerfile:1

FROM bitnami/minideb
RUN install_packages iproute2
COPY --link --from=ghcr.io/9seconds/mtg:2 /mtg /mtg

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENTRYPOINT [ "/mtg" ]
CMD [ "run", "/config.toml" ]
