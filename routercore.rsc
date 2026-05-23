# 2026-05-23 15:09:54 by RouterOS 7.22
# system id = F40uokMdzWN
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=INTERNET
set [ find default-name=ether4 ] disable-running-check=no name=MANAGEMENT
set [ find default-name=ether3 ] disable-running-check=no name=\
    "ROUTER 1- ROUTER 3"
set [ find default-name=ether2 ] disable-running-check=no name=\
    "ROUTER1 - ROUTER2"
/routing ospf instance
add disabled=no name="ROUTER CORE" originate-default=always router-id=1.1.1.1
/routing ospf area
add disabled=no instance="ROUTER CORE" name=BACKBONE
/ip address
add address=10.10.10.1/30 interface="ROUTER1 - ROUTER2" network=10.10.10.0
add address=10.10.20.1/30 interface="ROUTER 1- ROUTER 3" network=10.10.20.0
/ip dhcp-client
add interface=INTERNET name=client1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat out-interface=INTERNET
/routing ospf interface-template
add area=BACKBONE disabled=no interfaces="ROUTER 1- ROUTER 3"
add area=BACKBONE disabled=no interfaces="ROUTER1 - ROUTER2"
/system identity
set name=Router_Core
