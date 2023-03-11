:global HostPing do={
    ## Value required: host; count; [interface]
    :global Ping; :global Resolve; :local res 0;
    :foreach k in=$host do={:set res ($res + [$Ping [$Resolve $k] count=$count interface=$interface]);};
    :return $res;
}
