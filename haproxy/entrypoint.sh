#!/bin/sh

# Mark incoming packets matching an existing local socket
iptables -t mangle -N DIVERT
iptables -t mangle -A PREROUTING -m socket -j DIVERT
iptables -t mangle -A DIVERT -j MARK --set-mark 1
iptables -t mangle -A DIVERT -j ACCEPT

# Redirect all marked packets for local processing, i.e. to the open, transparent socket
ip rule add fwmark 1 lookup 100
ip route add local 0.0.0.0/0 dev lo table 100

exec /usr/local/bin/docker-entrypoint.sh "$@"
