#!/bin/bash
hostname="$(hostname)"
timezone="$(timedatectl | grep 'Time zone' | awk '{print $3 $4 $5}')"
os="$(lsb_release -s -d)"
date="$(date '+%d %b %Y %T')"
uptime="$(uptime -p)"
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

flag=0

#Colors array
colorNames=("default" "white" "red" "green" "blue" "magenta" "black")

#Default colors
column1_font_color=1
column2_background=2
column2_font_color=4

if [[ -f ./settings.conf ]]
then
 	. ./settings.conf

	#Checking exitsting parameters
	if [ -z $column1_background ]
	then
		column1_background=6
		echo "Column 1 background = default $column1_background (${colorNames[$column1_background]})"
	else
		column1_background=$(expr $column1_background)
		echo "Column 1 background = $column1_background (${colorNames[$column1_background]})"
	fi

	if [ -z $column1_font_color ]
	then
		column1_font_color=1
		echo "Column 1 font color = default $column1_font_color (${colorNames[$column1_font_color]})"
	else
		column1_font_color=$(expr $column1_font_color)
		echo "Column 1 font color = $column1_font_color (${colorNames[$column1_font_color]})"
	fi

	if [ -z $column2_background ]
	then
		column2_background=2
		echo "Column 2 background = default $column2_background (${colorNames[$column2_background]})"
	else
		column2_background=$(expr $column2_background)
		echo "Column 2 background = $column2_background (${colorNames[$column2_background]})"
	fi

	if [ -z $column2_font_color ]
	then
		column2_font_color=4
		echo "Column 2 font color = default $column2_font_color (${colorNames[$column2_font_color]})"
	else
		column2_font_color=$(expr $column2_font_color)
		echo "Column 2 font color = $column2_font_color (${colorNames[$column2_font_color]})"
	fi

else
	echo "Configuration file doesn't exist"
	flag=1
fi

if [ flag == 0 ]
then
	column1_background=$(expr $column1_background)
	column1_font_color=$(expr $column1_font_color)
	column2_background=$(expr $column2_background)
	column2_font_color=$(expr $column2_font_color)
fi

echo "Column 1 background = $column1_background (${colorNames[$column1_background]})"
echo "Column 1 font_color = $column1_font_color (${colorNames[$column1_font_color]})"
echo "Column 2 background = $column2_background (${colorNames[$column2_background]})"
echo "Column 2 font_color = $column2_font_color (${colorNames[$column2_font_color]})"

echo "HOSTNAME = $hostname"
echo "TIMEZONE = $timezone"
echo "USER = $USER"
echo "OS = $os"
echo "DATE = $date"
echo "UPTIME = $uptime"
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
