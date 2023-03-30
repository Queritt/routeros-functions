# 0.1
# 2022/05
:local dhcpGateway [/ip dhcp-client get [find comment="LTE"] gateway];
:local dhcpAddress [/ip dhcp-client get [find comment="LTE"] address];
:set dhcpAddress [:pick $dhcpAddress 0 [:find $dhcpAddress "/" -1]];

:local routeGateway [/ip route get [find comment="LTE"] gateway];
:local ruleAddress [/ip route rule get [find comment="LTE"] src-address];
:set ruleAddress [:pick $ruleAddress 0 [:find $ruleAddress "/" -1]];
:local mangleAddress [/ip firewall mangle get [find comment="LTE-IP"] src-address];
:local netwatchAddress [/tool netwatch get [find comment="LTE"] host];

#--Route
:if ($routeGateway != $dhcpGateway) do={
    /ip route set [find comment="LTE"] gateway=$dhcpGateway;
    /ip route set [find comment="LTE-mark"] gateway=$dhcpGateway;
}

#--Route Rule
:if ($ruleAddress != $dhcpAddress) do={
    /ip route rule set [find comment="LTE"] src-address=$dhcpAddress;
}

#--Mangle
:if ($mangleAddress != $dhcpAddress) do={
    /ip firewall mangle set [find comment="LTE-IP"] src-address=$dhcpAddress;
}

#--Netwatch
:if ($netwatchAddress != $dhcpGateway) do={
    /tool netwatch set [find comment="LTE"] host=$dhcpGateway;
}
