:local fsLowStr do={
    :local fsLowerChar do={
        :local "fs_lower" "0123456789abcdefghijklmnopqrstuvwxyz";
        :local "fs_upper" "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        :local pos [:find $"fs_upper" $1]
            :if ($pos > -1) do={:return [:pick $"fs_lower" $pos];}
            :return $1}
:local result ""; :local in $1
    :for i from=0 to=([:len $in] - 1) do={
        :set result ($result . [$fsLowerChar [:pick $in $i]])}
        :return $result;
}
