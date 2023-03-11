# HotspotOn
# 0.2
# 2023/01/22

#--Scheduler
/system scheduler disable ISPFailover;
/system scheduler disable PPPFailover;
# /system scheduler disable ISPStatus;

#--Mangle
/ip firewall mangle enable [find comment="Hotspot"];
/ip firewall mangle enable [find comment="Hotspot-IP"];
# /ip firewall mangle enable [find comment="TTL"]; 

#--QoS
/queue tree disable [find comment="ISP-100"]; 
/queue tree enable [find comment="Hotspot"]; 

#--Enable
/interface enable [find comment="Hotspot"];
/ip dhcp-client enable [find comment="Hotspot"];
/interface wireless set wlan1 mode=station ssid=AndroidAP4056 security-profile=Hotspot; 
/interface bridge port set wlan1 bridge=bridge3;
#/interface wireless enable [find comment="2G-Hotspot"]; 

#--Route
/ip route set [find comment="Hotspot"] distance=1;
/ip route enable [find comment="Hotspot"];
/ip route enable [find comment="Hotspot-mark"];

/log warning "Hotspot enabled as default.";
