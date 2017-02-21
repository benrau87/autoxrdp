#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

apt-get install xrdp -y
apt-get install mate-core mate-desktop-environment mate-notification-daemon -y

sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh

# Set keyboard layout in xrdp sessions 
cd /etc/xrdp 
test=$(setxkbmap -query | awk -F":" '/layout/ {print $2}') 
echo "your current keyboard layout is.." $test
setxkbmap -layout $test 
sudo cp /etc/xrdp/km-0409.ini /etc/xrdp/km-0409.ini.bak 
sudo xrdp-genkeymap km-0409.ini
