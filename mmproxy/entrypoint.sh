#!/bin/sh

echo "packets_mark is: ${packets_mark:=123}"
echo
echo "net.ipv4.conf.eth0.route_localnet is: $(cat /proc/sys/net/ipv4/conf/eth0/route_localnet)"

# Save conntrack CONNMARK on packets sent with MARK 123.
iptables -t mangle -I PREROUTING -m mark --mark "$packets_mark" -m comment --comment mmproxy -j CONNMARK --save-mark
ip6tables -t mangle -I PREROUTING -m mark --mark "$packets_mark" -m comment --comment mmproxy -j CONNMARK --save-mark

# Restore MARK on packets belonging to connections with conntrack CONNMARK 123.
iptables -t mangle -I OUTPUT -m connmark --mark "$packets_mark" -m comment --comment mmproxy -j CONNMARK --restore-mark
ip6tables -t mangle -I OUTPUT -m connmark --mark "$packets_mark" -m comment --comment mmproxy -j CONNMARK --restore-mark

# Route packets with MARK 123 to routing table 100
ip rule add fwmark "$packets_mark" lookup 100
ip -6 rule add fwmark "$packets_mark" lookup 100

# In routing table=100 treat all IP addresses as bound to
# loopback, and pass them to network stack for processing:
ip route add local 0.0.0.0/0 dev lo table 100
ip -6 route add local ::/0 dev lo table 100

exec /usr/local/bin/go-mmproxy "$@"
