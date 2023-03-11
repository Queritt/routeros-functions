## 0.10
:local RemoteWoL do={
	:foreach A in=[/ip firewall address-list find] do={
		if ([/ip firewall address-list get $A list] = "RemoteWoL") do={
			/tool wol interface=bridge-lan mac=MAC
			# /log warning "RemoteWoL Activated"
		    return null
		}
	}
}
$RemoteWoL
