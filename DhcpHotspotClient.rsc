# 0.1
# 2022/05
:local dhcpAddress [/ip dhcp-client get [find comment="Hotspot"] address];
:set dhcpAddress [:pick $dhcpAddress 0 [:find $dhcpAddress "/" -1]];
:local dhcpGateway [/ip dhcp-client get [find comment="Hotspot"] gateway];

:local mangleAddress [/ip firewall mangle get [find comment="Hotspot-IP"] src-address];
:local routeGateway [/ip route get [find comment="Hotspot"] gateway];


:if ($mangleAddress != $dhcpAddress) do={
	/ip firewall mangle set [find comment="Hotspot-IP"] src-address=$dhcpAddress;
}

:if ($routeGateway != $dhcpGateway) do={
	/ip route set [find comment="Hotspot"] gateway=$dhcpGateway;
	/ip route set [find comment="Hotspot-mark"] gateway=$dhcpGateway;
}
