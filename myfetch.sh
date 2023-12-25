#!/bin/bash

green='\033[32m'
cyan='\033[36m'
orange='\033[33m'
white='\033[37m'
blue='\033[34m'
red='\033[31m'
black='\033[30m'
purple='\033[35m'

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
	*[aA]pple*)
		machinecolor=$white ;;
    *[aA][sS][uU][sS]* )
        machinevendor="ASUS"
        machinecolor=$red ;;
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
\n" ;;

	*[zZ]orin*)
		printf "
$blue         /ZZZZZZZZZZZZ\\               $cyan $whothisis
$blue        ___________    _          $white OS: $blue$os
$blue       /ZZZZZZZZZZ/   /Z\\     $white Uptime: $orange$upt
$blue      /ZZZZZZZZ/   /ZZZZZ\\   $white Machine: $machine
$blue      \\ZZZZZ/   /ZZZZZZZZ/  $white RAM used: $ram
$blue       \\Z/   /ZZZZZZZZZZ/  $white Disk used: $disk
$blue          _____________       $white Kernel: $orange$kernel
$blue          \\ZZZZZZZZZZZ/
\n" ;;

	*[uU]buntu*)
		printf "
$orange                ____
$orange       ________/    \\                  $cyan $whothisis
$orange      / _______      )            $white OS: $orange$os
$orange     / /       \\__  /         $white Uptime: $green$upt
$orange  __/ /           \\ \\        $white Machine: $machine
$orange /    \\            \\ \\      $white RAM used: $ram
$orange(      )            ) )    $white Disk used: $disk
$orange \\__  /            / /        $white Kernel: $red$kernel
$orange    \\ \\         __/ /
$orange     \\ \\_______/    \\
$orange      \\________      )
$orange               \\____/
\n" ;;

    *[gG]entoo*)
        printf "
$purple          _____                    $white $whothisis
$purple         /     \\               $white OS: $purple$os
$purple        (       \\          $white Uptime: $cyan$upt
$purple         \\   /\\  \\        $white Machine: $machine
$purple          \\  \\/   \\      $white RAM used: $ram
$purple          /       /     $white Disk used: $disk
$purple         /      _/         $white Kernel: $cyan$kernel
$purple        /     _/
$purple       (   __/
$purple        \\_/
\n" ;;

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
