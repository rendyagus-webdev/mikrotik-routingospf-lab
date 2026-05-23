# 2026-05-23 15:12:39 by RouterOS 7.22
# system id = 8IDMyDTAU3L
#
/interface ethernet
set [ find default-name=ether3 ] disable-running-check=no name=BACKUP
set [ find default-name=ether2 ] disable-running-check=no name="LAN CLIENT"
set [ find default-name=ether1 ] disable-running-check=no name="LAN ROUTER1"
set [ find default-name=ether4 ] disable-running-check=no name=MANAGEMENT
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface="LAN CLIENT" name=dhcp1
/routing ospf instance
add disabled=no name=ROUTER1 router-id=2.2.2.2
/routing ospf area
add disabled=no instance=ROUTER1 name=BACKBONE
/ip address
add address=10.10.10.2/30 interface="LAN ROUTER1" network=10.10.10.0
add address=192.168.10.1/24 interface="LAN CLIENT" network=192.168.10.0
add address=10.10.30.1/30 interface=BACKUP network=10.10.30.0
add address=192.168.99.99/31 interface=MANAGEMENT network=192.168.99.98
/ip dhcp-client
add interface="LAN ROUTER1" name=client1
/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8
/routing ospf interface-template
add area=BACKBONE disabled=no interfaces="LAN ROUTER1"
add area=BACKBONE disabled=no interfaces="LAN CLIENT" passive
add area=BACKBONE cost=100 disabled=no interfaces=BACKUP
/system identity
set name=Router1
