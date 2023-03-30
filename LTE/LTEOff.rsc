## LTE Off
## 0.21
## 2023/03/14
## Disable connection reset
/queue tree disable [find comment="LTE"];
/queue tree enable [find comment="ISP-100"];
/ip route set [find comment="LTE"] distance=4;
/ip firewall raw disable [find comment="WEB-LTE"]; 
# /ip firewall connection remove [find];
# /interface disable l2tp-out1;
# /interface disable l2tp-out2;
# /interface disable l2tp-out3;
# :delay 2s;
# /interface enable l2tp-out1;
# /interface enable l2tp-out2;
# /interface enable l2tp-out3;
# /system scheduler enable ISPStatus; 
/system scheduler enable ISPFailover; 
/log warning "LTE OFF | LTE gate disabled as default.";
