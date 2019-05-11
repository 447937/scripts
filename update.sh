#!/bin/bash
clear
echo "			>>> AKTUALIZAČNÍ SKRIPT <<<"
echo -e "\n=== Dojde k aktualizaci repozitářů ===\n"
notify-send 'Aktualizační skript' 'Dojde k aktualizaci a úklidu.'
sudo apt update

echo -e "\n=== Dojde k aktualizaci nainstalovaných programů ===\n"
sudo apt upgrade -y

echo -e "\n=== Dojde k odstarnění nepotřebných závislostí ===\n"
sudo apt autoremove -y
sudo apt autoclean -y
notify-send 'Aktualizační skript' 'HOTOVO'
