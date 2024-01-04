#!/bin/bash

fgColors=(
'\033[0;0m'
'\033[0;37m'
'\033[0;31m'
'\033[0;32m'
'\033[0;34m'
'\033[0;35m'
'\033[0;30m'
)

bgColors=(
'\033[0;0m'
'\033[40m'
'\033[41m'
'\033[42m'
'\033[44m'
'\033[45m'
'\033[47m'
)

BG_N=${bgColors[$1]}
FG_N=${fgColors[$2]}
BG_V=${bgColors[$3]}
FG_V=${fgColors[$4]}

hostname="$(hostname)"
timezone="$(timedatectl | grep 'Time zone' | awk '{print $3 $4 $5}')"
os="$(cat /etc/issue | awk '{print $1 " " $2 " " $3}')"
date="$(date '+ %d %b %Y %T')"
uptime_sec="$(awk '{print $1}' /proc/uptime)" 
ip="$(hostname -i | awk '{print $1}')"
netmask="$(ifconfig | grep netmask | awk '{print $4}')"
gateway="$(ip route | grep default | awk '{print $3}')"
mem="$(free -m | grep "Mem" | awk '{printf "%.3f Gb\n", $2/1024}')"
mem_used="$(free -m | grep "Mem" | awk '{printf "%.3f Gb\n", $3/1024}')"
mem_free="$(free -m | grep "Mem" | awk '{printf "%.3f Gb\n", $4/1024}')"
space_root="$(df | grep "/$" | awk '{printf "%.2f Mb\n", $2}')"
space_used="$(df | grep "/$" | awk '{printf "%.2f Mb\n", $3}')"
space_free="$(df | grep "/$" | awk '{printf "%.2f Mb\n", $4}')"

echo "${BG_N} ${FG_N}HOSTNAME${NC} = $hostname"
echo "TIMEZONE = $timezone"
echo "USER = $USER"
echo "OS = $os"
echo "DATE = $date"
echo "UPTIME = "
echo "UPTIME_SEC = $uptime_sec"
echo "IP = $ip"
echo "MASK = $netmask"
echo "GATEWAY = $gateway"
echo "RAM_TOTAL = $mem"
echo "RAM_USED = $mem_used"
echo "RAM_FREE = $mem_free"
echo "SPACE_ROOT = $space_root"
echo "SPACE_ROOT_USED = $space_used"
echo "SPACE_ROOT_FREE = $space_free"
