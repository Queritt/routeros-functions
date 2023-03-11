# HotspotOff
# 0.2
# 20230122

#--Route
ip route disable [find comment=Hotspot];
ip route disable [find comment=Hotspot-mark];
ip route set [find comment=Hotspot] distance=3;

#--Enable
# interface wireless disable [find comment=2G-Hotspot];
interface bridge port set wlan1 bridge=bridge1;
interface wireless set wlan1 mode=ap-bridge ssid=61212A security-profile=Private;    
ip dhcp-client disable [find comment=Hotspot];
interface disable [find comment=Hotspot];

#--QoS
queue tree disable [find comment=Hotspot]; 
queue tree enable [find comment=ISP-100];

#--Mangle
ip firewall mangle disable [find comment=Hotspot];
ip firewall mangle disable [find comment=Hotspot-IP]; 
# ip firewall mangle disable [find comment=TTL];

#--Scheduler
system scheduler enable ISPFailover;
system scheduler enable PPPFailover;
# system scheduler enable ISPStatus;

log warning Hotspot disabled as default.;
