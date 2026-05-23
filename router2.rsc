# 2026-05-23 15:10:47 by RouterOS 7.22
# system id = kHkInORuasE
#
/interface ethernet
set [ find default-name=ether4 ] disable-running-check=no name=BACKUUP1
set [ find default-name=ether2 ] disable-running-check=no name="LAN CLIENT 2"
set [ find default-name=ether1 ] disable-running-check=no name="LAN ROUTER 2"
set [ find default-name=ether3 ] disable-running-check=no name=MANAGEMENT
/ip pool
add name=dhcp_pool0 ranges=192.168.10.2-192.168.10.254
add name=dhcp_pool1 ranges=192.168.20.2-192.168.20.254
add name=dhcp_pool2 ranges=192.168.20.2-192.168.20.254
/ip dhcp-server
add address-pool=dhcp_pool2 interface="LAN CLIENT 2" name=dhcp1
/routing ospf instance
add disabled=no name=ROUTER2 router-id=3.3.3.3
/routing ospf area
add disabled=no instance=ROUTER2 name=BACKBONE
/ip address
add address=10.10.20.2/30 interface="LAN ROUTER 2" network=10.10.20.0
add address=192.168.20.1/24 interface="LAN CLIENT 2" network=192.168.20.0
add address=10.10.30.2/30 interface=BACKUUP1 network=10.10.30.0
add address=192.168.89.99/31 interface=MANAGEMENT network=192.168.89.98
/ip dhcp-client
add interface="LAN ROUTER 2" name=client1
/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.1
add address=192.168.20.0/24 gateway=192.168.20.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8
/routing ospf interface-template
add area=BACKBONE disabled=no interfaces="LAN ROUTER 2"
add area=BACKBONE disabled=no interfaces="LAN CLIENT 2" passive
add area=BACKBONE cost=100 disabled=no interfaces=BACKUUP1
/system identity
set name=Router2
