#!/bin/bash

green='\033[32m'
cyan='\033[36m'
orange='\033[33m'
white='\033[37m'
blue='\033[34m'
red='\033[31m'
black='\033[30m'

lightgreenbg='\033[102m'
darkgraybg='\033[100m'

os="$(grep PRETTY_NAME /etc/os-release | awk -F = '{ print $2 }' | sed -e 's/\"//g')"
whothisis="$USER@$(hostname)"
uptimestr="$(uptime)"
upt="$(echo $uptimestr | awk -F, '{ print $1 }' | awk '{ for (i=3; i<=NF; i++) printf "%s ",$i }')"

kernel="$(uname -r)"

machinevendor="$(cat /sys/devices/virtual/dmi/id/sys_vendor)"
case $machinevendor in
	*Dell*)
		machinecolor=$blue ;;
	*[lL][eE][nN][oO][vV][oO]*)
		machinecolor=$red ;;
	*[hH][pP]*)
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

#os="Pop!_OS"
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
                             $white Kernel: $orange$kernel\n
$white\n" ;;
	
	*[fF]edora*)
		printf  \
"\n$blue    FFFFFF                 $cyan $whothisis
$blue  FFFF${white}FFF${blue}FFF           $white OS: $blue$os
$blue FFFFF${white}F${blue}FFFFFF      $white Uptime: $orange$upt
$blue FFF${white}FFFFF${blue}FFFF     $white Machine: $machine
$blue FFFFF${white}F${blue}FFFFFF    $white RAM used: $ram
$blue FFF${white}FFF${blue}FFFFF    $white Disk used: $disk
$blue FFFFFFFFF         $white Kernel: $orange$kernel
$white\n" ;;

	*[pP]op*[oO][sS]*)
		printf "
$cyan       PPPPPPPPPPPPPPPP                $blue $whothisis
$cyan      PPP${white}PPP${cyan}PPPPPPP${white}PP${cyan}PPP           $white OS: $cyan$os
$cyan     PPPPP${white}P${cyan}P${white}P${cyan}PPPPP${white}PP${cyan}PPPPP      $white Uptime: $orange$upt
$cyan    PPPPPPP${white}PPP${cyan}PPP${white}PP${cyan}PPPPPPP    $white Machine: $machine
$cyan    PPPPPPPP${white}P${cyan}PPP${white}PP${cyan}PPPPPPPP   $white RAM used: $ram
$cyan     PPPPPPPP${white}P${cyan}P${white}()${cyan}PPPPPPPP   $white Disk used: $disk
$cyan      PPPP${white}CEEEEEEEED${cyan}PPPP       $white Kernel: $orange$kernel
$cyan       PPPPPPPPPPPPPPPP
\n";;

	*)
		printf \
"\nDo you know which OS this is? I sure don't know what it looks like!\nHere's your information anyway:\n
$cyan            $whothisis
$white        OS: $orange$os
$white    Uptime: $orange$upt
$white   Machine: $machine
$white  RAM used: $ram
$white Disk used: $disk
$white    Kernel: $orange$kernel\n\n" ;;
esac
printf "$white"
