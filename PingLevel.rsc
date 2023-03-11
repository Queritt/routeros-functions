:local PingLevel do={
	## Value required: $1(address);
	:local suitePing 70;
	:local res;
	:local tmp;
	:local tmpSym;
	:local tmpStr;
	:for i from=1 to=3 do={
		:set tmpStr "";
		:set tmp ([:ping $1 count=1 as-value]->"time");
		:if ([:typeof $tmp] = "nothing") do={:return false};
		:for n from=0 to=([:len $tmp] -1) do={
			:set tmpSym [:pick $tmp $n];
			:if ($tmpSym~"[0-9]") do={:set tmpStr ($tmpStr.$tmpSym)};
		}
		:set res ($res + ([:tonum $tmpStr] / 1000));
	}
	:put ($res / 3);
	:if (($res / 3) > $suitePing) do={:return false}; :return true;
}
