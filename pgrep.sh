#!/bin/sh
clear

echo "               ========= Fulltextový PDF vyhledávač ========="
echo -n "> Adresář: "
read kde

while [ true ]
do
        echo "- Skript lze ukončit signálem přerušení Ctrl-C."
        echo -n "\n\n> Hledat text: "
        read co
        pdfgrep -HiR "$co" $kde
        echo "> Hledal se text: $co"
done
