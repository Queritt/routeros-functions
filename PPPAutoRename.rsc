# PPPAutoRename
# ver 0.2
# modified 2022/06/16

:local secretName;
:local secretComment;
:local secretRemoteAddress;
:local infComment;
:local tempService;
:local netwatchHost;
:local netwatchComment;

:foreach i in=[/ppp secret find] do={
    :local secretName          [ /ppp secret get $i name ];
    :local secretComment       [ /ppp secret get $i comment ];
    :local secretRemoteAddress [ /ppp secret get $i remote-address ];

  #---Interface
    :if ([/interface find name=$secretName]) do={
      :local infComment [/interface get [ find name=$secretName ] comment ];
      :if ($secretComment != $infComment) do={
        /interface set $secretName comment=$secretComment;
      }
    } else={
      :local tempService [ /ppp secret get $i service ];
        :if ($tempService = "l2tp") do={
            /interface l2tp-server add name=$secretName user=$secretName comment=$secretComment;
        } else={
            :if ($tempService = "ovpn") do={
                /interface ovpn-server add name=$secretName user=$secretName comment=$secretComment;
            } else={
                :if ($tempService = "sstp") do={
                    /interface sstp-server add name=$secretName user=$secretName comment=$secretComment;
                } else={
                    /interface pptp-server add name=$secretName user=$secretName comment=$secretComment;
                }   
            }
        }
    }

    #---NAT
    :foreach i in=[/ip firewall nat find] do={
        :if ( [/ip firewall nat get $i to-addresses] = $secretRemoteAddress) do={
            :if ( [/ip firewall nat get $i comment] != $secretComment) do={
                /ip firewall nat set $i comment=$secretComment;
            }
        } 
    }

    #---Netwatch
    :if [/tool netwatch find host=$secretRemoteAddress] do={

        #---Netwatch comment
        :set netwatchHost [ /tool netwatch find host=$secretRemoteAddress ];
        :local netwatchComment [ /tool netwatch get $netwatchHost comment ];
        :if ($netwatchComment != $secretComment) do={
            /tool netwatch set $netwatchHost comment=$secretComment;
        }

        #---Netwatch status
        # :if ([/ppp secret find comment=$secretComment disabled=no]) do={
        #     :if ([/tool netwatch find comment=$secretComment disabled=yes]) do={
        #         /tool netwatch enable $netwatchHost;
        #     }
        # } else={
        #     :if ([/tool netwatch find comment=$secretComment disabled=no]) do={
        #         /tool netwatch disable $netwatchHost;
        #     }
        # }
    }
}
