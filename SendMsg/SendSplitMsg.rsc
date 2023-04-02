:local SendMsg do={
    :if ([:len $1] != 0) do={
        :local nameID [/system identity get name;];
        :local outMsg $1;
        :local outMsgSplit;
        :local logPart
        :local tmpChar;
        :local maxLength (4096 - [:len ("/$nameID ")] - [:len ("(message 99 of 99):"."%0A")]);
        :local foundChar;
        :local counter;
        :if ([:len ("/$nameID:"."%0A"."$outMsg")] > 4096) do={
            :while ([:len $outMsg] > 0) do={
                :if ([:len $outMsg] > $maxLength) do={
                    :set foundChar -1;
                    :set counter ($maxLength -3);
                    :while ($foundChar = -1 and $counter > -1) do={
                        :set tmpChar [:pick $outMsg $counter ($counter +3)];
                        :if ($tmpChar = "%0A") do={:set foundChar $counter;};
                        :set counter ($counter -1);
                    }
                    :if ($foundChar > -1) do={
                        :set outMsgSplit ($outMsgSplit, [:pick $outMsg 0 ($foundChar +3)]);
                        :set $outMsg [:pick $outMsg ($foundChar +3) [:len $outMsg]];
                    } else={
                        :set outMsgSplit ($outMsgSplit, [:pick $outMsg 0 $maxLength]);
                        :set $outMsg [:pick $outMsg $maxLength [:len $outMsg]];
                    }
                } else={:set outMsgSplit ($outMsgSplit, $outMsg); :set $outMsg "";};
            }
        } else={:set outMsgSplit {$outMsg}};
        :set logPart [:len $outMsgSplit];
        :for n from=0 to=([:len $outMsgSplit] -1) do={
            [[:parse [/system script get TG source]] \
            Text=("/$nameID "."(message ".($n+1)." of $logPart):"."%0A".[:pick $outMsgSplit $n])]; delay 2s;};
    }
}
