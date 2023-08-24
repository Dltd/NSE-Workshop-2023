#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    printf "You need root privileges to run this script.\nPlease try again, this time using 'sudo'."
    exit 1
fi

#create a temporary directory for install files and cd into it
mkdir /tmp/setup && cd /tmp/setup

# Kill Nessus
systemctl stop nessusd.service
systemctl disable nessusd.service

# Install Lua and Alien
printf "\n[+] Installing Lua and Alien\n\n"
apt update
apt -y install lua5.3 alien
printf "\n[+] Lua and Alien installed\n\n"
lua -v && alien -V

# Install VS Code
printf "\n[+] Installing VS Code\n\n"
curl -L https://go.microsoft.com/fwlink/?LinkID=760868 -o code.deb && apt -y install ./code.deb
code -v
printf "\n[+] VS Code installed.\n\n"

#Install Nmap 7.94-1
printf "\n[+] Installing Nmap 7.94\n\n"
curl -O https://nmap.org/dist/nmap-7.94-1.x86_64.rpm && alien nmap-7.94-1.x86_64.rpm && apt -y install ./nmap_7.94-2_amd64.deb
nmap -V
printf "\n[+] Nmap 7.94 installed.\n\n"

# A series of checks to validation each installation.
# The first say what they are checking, then run the check, then let the user know if it passed or failed.
printf "\n[+] Checking Lua installation\n\n"
if [ -f /usr/bin/lua5.3 ]; then
    printf "Lua installed\n\n"
else
    printf "Lua not installed\n\n"
fi