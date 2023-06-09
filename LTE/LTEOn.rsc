## LTE On
## 0.22
## 2023/03/14
## Change reset connection to ALL
:if ([/ip route get $lteId distance] = 1) do={
    # /system scheduler enable ISPStatus; 
    /system scheduler disable ISPFailover; 
    /log warning "LTE ON | LTE gate is already enabled. ISPFailover disabled";
} else={
    /system scheduler disable ISPFailover;
    # /system scheduler disable ISPStatus;
    /queue tree disable [find comment="ISP-100"];
    /queue tree enable [find comment="LTE"];
    /ip firewall raw enable [find comment="WEB-LTE"];
    /ip route set [find comment="LTE"] distance=1;
    /ip firewall connection remove [find];
    /interface disable l2tp-out1;
    /interface disable l2tp-out2;
    # /interface disable l2tp-out3;
    :delay 2s;
    /interface enable l2tp-out1;
    /interface enable l2tp-out2;
    # /interface enable l2tp-out3;
    /log warning "LTE ON | LTE gate enabled as default.";
}
