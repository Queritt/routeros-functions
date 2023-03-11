# Recovery
# 0.2
# 2022/10/24
:if [/system script job find script=Reset] do={
    /system script job remove [find script=Reset];
    /ip firewall filter remove [find comment="Recovery: allow all"];
    /ip firewall raw remove [find comment="Recovery: allow all"];
    /user remove USER;
    /log warning "Reset canceled.";
} else={
    # Firewall
    /ip firewall filter;
    add action=accept chain=input comment="Recovery: allow all" place-before=0;
    add action=accept chain=forward comment="Recovery: allow all" place-before=0;
    /ip firewall raw add action=accept chain=prerouting comment="Recovery: allow all" place-before=0;
    # WinBox 
    /ip service set winbox port="8291";
    /ip service enable winbox;
    # SSH 
    /ip service set ssh port="22";
    /ip service enable ssh;
    # Interfaces
    /interface enable ether1;
    /interface enable ether2;
    /interface enable bridge-lan;
    # User
    /user add name=USER group=full password="PASSWORD";
    /system script run Reset;
    /log warning "Recovery activated! Reset starts in 5 minutes!";
}
