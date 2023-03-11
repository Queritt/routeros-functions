:delay 300;
/system reset-configuration keep-users=yes no-defaults=yes run-after-reset=[/file get [find name~"-cfg-"] name];
