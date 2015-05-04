#!/bin/bash

# Das ist ein einfaches Template für einen nagios Check
# auf bash-Basis. 
# Quelle: http://mathias-kettner.de/checkmk_localchecks.html

dir="/var/log/"

while getopts 'w:c:h' OPT; do
  case $OPT in
    w)  warnlevel=$OPTARG;;
    c)  critlevel=$OPTARG;;
    h)  hlp="yes";;
    *)  unknown="yes";;
  esac
done

# usage
HELP="
    usage: $0 -w <warning> -c <critical> [ -h ] 
        <warning> < <critical>
"

if [ "$hlp" = "yes" -o $# -lt 1 ]; then
  echo "$HELP"
  exit 0
fi


count=$(ls $dir | wc --lines)

if [ $count -lt $warnlevel ] ; then
    status=0
    statustxt=OK
elif [ $count -lt $critlevel ] ; then
    status=1
    statustxt=WARNING
else
    status=2
    statustxt=CRITICAL
fi

echo "$statustxt - $count files in $dir|count=$count"
exit $status
