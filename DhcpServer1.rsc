# 0.1
# 2022/05
:local t [/system clock get time];
:local d [/system clock get date];
:foreach i in=[/ip dhcp-server lease find] do={
  :if ([/ip dhcp-server lease get $i status]="bound" && [/ip dhcp-server lease get $i comment]="" && [/ip dhcp-server lease get $i server]="server1") do={
    :local address [/ip dhcp-server lease get $i active-address];
    :local host [/ip dhcp-server lease get $i host-name];
    :local g [("LAN" . "-" . $d . "-" . $t)]
    /ip dhcp-server lease set $i comment=$g;
    # /ip firewall address-list add address=[/ip dhcp-server lease get $i address] list="Drop" timeout=1d
    # [[:parse [/system script get TG source]] Text=("server1 bound: "."$host - "."$address")];
    /log warning "server1 bound: $host - $address";
  }
}    
