#!/bin/sh

# Mark incoming packets matching an existing local socket
iptables -t mangle -A PREROUTING -p tcp -m socket -j MARK --set-mark 1
iptables -t nat -A POSTROUTING -j SNAT --to-source "$(ip --brief a | grep -F 'eth0' | awk '{print $3;}' | sed -E 's|\/[0-9]+||')"

# Redirect all marked packets for local processing, i.e. to the open, transparent socket
ip rule add fwmark 1 lookup 100
ip route add local 0.0.0.0/0 dev lo table 100

########

#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
	set -- haproxy -W -db "$@"
fi

exec "$@"
