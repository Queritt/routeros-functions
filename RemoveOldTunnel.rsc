:global RemoveOldTunnel do={
    ## Value required: $1(address);
    :local remAddress $1; :local srcAddress; :local dstAddress;
    :do {
        :foreach n in=[/ip firewall connection find] do={
            :set srcAddress [/ip firewall connection get $n src-address];
            :set dstAddress [/ip firewall connection get $n dst-address];
            :if [:find $srcAddress ":"] do={:set srcAddress [:pick $srcAddress 0 [:find $srcAddress ":"]];};
            :if [:find $dstAddress ":"] do={:set dstAddress [:pick $dstAddress 0 [:find $dstAddress ":"]];};
            :if ($remAddress~"$srcAddress" or $remAddress~"$dstAddress") do={[/ip firewall connection remove $n]};
        }
    } on-error={:return []};
}
