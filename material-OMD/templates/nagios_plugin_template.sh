#!/bin/bash

# Das ist ein einfaches Template für einen nagios Check
# auf bash-Basis. 
# Quelle: http://mathias-kettner.de/checkmk_localchecks.html

dir="/var/log"

count=$(ls $dir | wc --lines)

if [ $count -lt 50 ] ; then
    status=0
    statustxt=OK
elif [ $count -lt 100 ] ; then
    status=1
    statustxt=WARNING
else
    status=2
    statustxt=CRITICAL
fi

echo "$statustxt - $count files in $dir|count=$count"
exit $status
