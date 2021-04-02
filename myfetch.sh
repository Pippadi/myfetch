#!/bin/bash

green='\033[32m'
cyan='\033[36m'
orange='\033[33m'
white='\033[37m'
blue='\033[34m'
red='\033[31m'

lightgreenbg='\033[102m'
darkgraybg='\033[100m'

os="$(cat /etc/*-release | grep PRETTY_NAME | awk -F = '{ print $2 }' | sed -e 's/\"//g')"
whothisis="$USER@$(hostname)"
upt="$(uptime | awk '{ print $3 }' | sed 's/,//')"

machinevendor="$(cat /sys/devices/virtual/dmi/id/sys_vendor)"
case $machinevendor in
	*Dell*)
		machinecolor=$blue ;;
	*Lenovo*)
		machinecolor=$red ;;
	*HP*)
		machinecolor=$blue ;;
	*)
		machinecolor=$orange ;;
esac
machine="$machinecolor$machinevendor $(cat /sys/devices/virtual/dmi/id/product_name)"

freeop="$(free -h | grep Mem)"
usedram="$(echo $freeop | awk '{ print $3 }')"
totalram="$(echo $freeop | awk '{ print $2 }')"
ramcolors=( $green $orange $red )
ram="$orange$usedram / $totalram"

dfop="$(df -h / | grep /dev)"
totaldisk="$(echo $dfop | awk '{ print $2 }')"
useddisk="$(echo $dfop | awk '{ print $3 }')"
disk="$orange$useddisk / $totaldisk"

case $os in
	*[oO]penS[uU]SE*[tT]umbleweed*)
		printf \
"$green    _______    _______
$green   / _____ \\  / _____ \\              $cyan $whothisis
$green  / /     \\ \\/ /     \\ \\         $white OS: $green$os
$green / /       \\/ /       \\ \\    $white Uptime: $orange$upt
$green \\ \\       / /\\       / /   $white Machine: $machine
$green  \\ \\_____/ /\\ \\_____/ /   $white RAM used: $ram
$green   \\_______/  \\_______/   $white Disk used: $disk
\n" ;;
	
	*[fF]edora*)
		printf  \
"\n$blue    FFFFFF                 $cyan $whothisis
$blue  FFFF${white}FFF${blue}FFF           $white OS: $blue$os
$blue FFFFF${white}F${blue}FFFFFF      $white Uptime: $orange$upt
$blue FFF${white}FFFFF${blue}FFFF     $white Machine: $machine
$blue FFFFF${white}F${blue}FFFFFF    $white RAM used: $ram
$blue FFF${white}FFF${blue}FFFFF    $white Disk used: $disk
$blue FFFFFFFFF
\n" ;;

	*)
		printf \
"$white What OS are you on? I sure don't know!\n" ;;

esac
printf "$white"
