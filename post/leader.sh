#!/usr/bin/bash
cat - | sed -r "s|^[A-Z_]* =||" | sed -r -f leader.sed  | sed -r ":loop;N;$!b loop;s|/\n|/|g" | sed -r "s|/$|\n|"
