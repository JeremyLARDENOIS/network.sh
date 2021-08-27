ip link add veth0 type veth peer name brveth0
ip link set brveth0 up

ip link add veth1 type veth peer name brveth1
ip link set brveth1 up

ip link add br10 type bridge
ip link set br10 up

ip addr add 192.168.1.11/24 brd + dev br10

ip netns add ns0
ip netns add ns1

ip link set veth0 netns ns0
ip link set veth1 netns ns1

ip netns exec ns0    ip addr add 192.168.1.20/24 dev veth0
ip netns exec ns0    ip link set veth0 up
ip netns exec ns0    ip link set lo up

ip netns exec ns1    ip addr add 192.168.1.21/24 dev veth1
ip netns exec ns1    ip link set veth1 up
ip netns exec ns1    ip link set lo up

ip link set  brveth0 master br10
ip link set  brveth1 master br10