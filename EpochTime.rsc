:local EpochTime do={
    :local ds $1;
    :local ts $2;
    :local curDate [/system clock get date];
    :local curYear [:pick $curDate 8 ([:len $curDate]-1)];
    :if ([:len $1]>19) do={:set ds "$[:pick $1 0 11]"; :set ts [:pick $1 12 20]};
    :if ([:len $1]>8 && [:len $1]<20) do={:set ds "$[:pick $1 0 6]/$curYear"; :set ts [:pick $1 7 15]};
    :local yesterday false;
    :if ([:len $1]=8) do={
        :if ([:totime $1]>ts) do={:set yesterday (true)};
        :set ds $curDate;
        :set ts $1;
    }
    :local months;
    :if ((([:pick $ds 9 11]-1)/4)!=(([:pick $ds 9 11])/4)) do={
        :set months {"an"=0;"eb"=31;"ar"=60;"pr"=91;"ay"=121;"un"=152;"ul"=182;"ug"=213;"ep"=244;"ct"=274;"ov"=305;"ec"=335};
    } else={
        :set months {"an"=0;"eb"=31;"ar"=59;"pr"=90;"ay"=120;"un"=151;"ul"=181;"ug"=212;"ep"=243;"ct"=273;"ov"=304;"ec"=334};
    }
    :set ds (([:pick $ds 9 11]*365)+(([:pick $ds 9 11]-1)/4)+($months->[:pick $ds 1 3])+[:pick $ds 4 6]);
    :set ts (([:pick $ts 0 2]*3600)+([:pick $ts 3 5]*60)+[:pick $ts 6 8]);
    :if (yesterday) do={:set ds ($ds-1)};
    :return ($ds*86400+$ts+946684800-[/system clock get gmt-offset]);
} 
