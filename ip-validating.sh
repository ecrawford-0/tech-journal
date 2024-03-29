#!/bin/bash
# This script was taken in its entirely from this website: https://www.linuxjournal.com/content/validating-ip-address-bash-script 

# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

# If run directly, execute some tests.
if [[ "$(basename $0 .sh)" == 'valid_ip' ]]; then
    ips='
        4.2.2.2
        a.b.c.d
        192.168.1.1
        0.0.0.0
        255.255.255.255
        255.255.255.256
        192.168.0.1
        192.168.0
        1234.123.123.123
        '
    for ip in $ips
    do
        if valid_ip $ip; then stat='good'; else stat='bad'; fi
        printf "%-20s: %s\n" "$ip" "$stat"
    done
fi
