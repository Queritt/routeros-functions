:local FindMacAddr do={
    :if ($1~"[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]:[0-F][0-F]") do={
        :foreach idx in=[/ip dhcp-server lease find disabled=no] do={
            :local mac [/ip dhcp-server lease get $idx mac-address];
            :if ($1~"$mac") do={:return ("$1 [$[/ip dhcp-server lease get $idx address]/$[/ip dhcp-server lease get $idx comment]].")};
        }
        :foreach idx in=[/interface bridge host find] do={
            :local mac [/interface bridge host get $idx mac-address];
            :if ($1~"$mac") do={:return ("$1 [$[/interface bridge host get $idx on-interface]].")};
        }
    }
    :return ($1);
}
