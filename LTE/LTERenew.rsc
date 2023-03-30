# LTERenew
# 0.21
# 2023/02/23
# Code improved
:global lteInf lte1;
:if [/interface find name=$lteInf] do={
    :if [/system scheduler find name="LTEStatus" disabled=yes] do={
        /ip address set [find comment="LTE"] interface=$lteInf;
        /ip dhcp-client set [find comment="LTE"] interface=$lteInf;
        /ip address enable [find comment="LTE"];
        /ip route enable [find comment="LTE"];
        /ip route enable [find comment="LTE-mark"];
        /interface list member set [find comment="LTE"] interface=$lteInf;
        /ip firewall mangle set [find comment="LTE-INF"] in-interface=$lteInf;
        /ip firewall mangle enable [find comment="LTE-INF"];
        /ip firewall mangle enable [find comment="LTE"];
        /ip firewall mangle enable [find comment="LTE-IP"];
        /ip firewall mangle enable [find comment="TTL"];
        /ip firewall raw enable [find comment="LTE"];
        /system scheduler enable ISPFailover;
        #/system scheduler enable ISPStatus;
        /system scheduler enable LTEStatus;
    }
} else={
    :if [/system scheduler find name="LTEStatus" disabled=no] do={
        /system scheduler disable LTEStatus;
        # /system scheduler disable ISPStatus;
        /system scheduler disable ISPFailover; 
        /ip route set [find comment="LTE"] distance=4;
        /ip route disable [find comment="LTE"];
        /ip route disable [find comment="LTE-mark"];
        /ip address disable [find comment="LTE"];
        /ip firewall mangle disable [find comment="TTL"];
        /ip firewall mangle disable [find comment="LTE-INF"];
        /ip firewall mangle disable [find comment="LTE"];
        /ip firewall mangle disable [find comment="LTE-IP"];
        /ip firewall raw disable [find comment="LTE"];
    }
}
