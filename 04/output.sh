#!/bin/bash

bgColors=(
'\033[49m' #default
'\033[107m' #white
'\033[101m' #red
'\033[102m' #green
'\033[106m' #blue
'\033[105m' #purple
'\033[40m' #black
)

fgColors=(
'\033[39m' #default
'\033[97m' #white
'\033[91m' #red
'\033[92m' #green
'\033[96m' #blue
'\033[95m' #purple
'\033[30m' #black
)

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
# column1_font_color=1
# column2_background=2
# column2_font_color=4

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

BG_N=${bgColors[$column1_background]}
FG_N=${fgColors[$column1_font_color]}
BG_V=${bgColors[$column2_background]}
FG_V=${fgColors[$column2_font_color]}
NC=${fgColors[0]}
BG_NC=${bgColors[0]}


# if [ flag == 0 ]
# then
# 	column1_background=$(expr $column1_background)
# 	column1_font_color=$(expr $column1_font_color)
# 	column2_background=$(expr $column2_background)
# 	column2_font_color=$(expr $column2_font_color)
# fi

echo "Column 1 background = $column1_background (${colorNames[$column1_background]})"
echo "Column 1 font_color = $column1_font_color (${colorNames[$column1_font_color]})"
echo "Column 2 background = $column2_background (${colorNames[$column2_background]})"
echo "Column 2 font_color = $column2_font_color (${colorNames[$column2_font_color]})"

echo -e "${BG_N}${FG_N}HOSTNAME${BG_NC}${NC}=${BG_V}${FG_V}$hostname${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}TIMEZONE${BG_NC}${NC} = ${BG_V}${FG_V}$timezone${BG_NC}${NC}"
echo -e  "${BG_N}${FG_N}USER${BG_NC}${NC} = ${BG_V}${FG_V}$USER${BG_NC}${NC}"
echo -e  "${BG_N}${FG_N}OS${BG_NC}${NC} = ${BG_V}${FG_V}$os${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}DATE${BG_NC}${NC} = ${BG_V}${FG_V}$date${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}UPTIME${BG_NC}${NC} = ${BG_V}${FG_V}$uptime${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}UPTIME_SEC${BG_NC}${NC} = ${BG_V}${FG_V}$uptime_sec${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}IP${BG_NC}${NC} = ${BG_V}${FG_V}$ip${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}MASK${BG_NC}${NC} = ${BG_V}${FG_V}$netmask${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}GATEWAY${BG_NC}${NC} = ${BG_V}${FG_V}$gateway${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}AM_TOTAL${BG_NC}${NC} = ${BG_V}${FG_V}$mem${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}RAM_USED${BG_NC}${NC} = ${BG_V}${FG_V}$mem_used${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}RAM_FREE${BG_NC}${NC} = ${BG_V}${FG_V}$mem_free${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}SPACE_ROOT${BG_NC}${NC} = ${BG_V}${FG_V}$space_root${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}SPACE_ROOT_USED${BG_NC}${NC} = ${BG_V}${FG_V}$space_used${BG_NC}${NC}"
echo -e "${BG_N}${FG_N}SPACE_ROOT_FREE${BG_NC}${NC} = ${BG_V}${FG_V}$space_free${BG_NC}${NC}"

