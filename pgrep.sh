#!/bin/sh
alive=1
clear

echo "               ========= Fulltextový PDF vyhledávač ========="
echo -n "> Adresář: "
read kde

while [ $alive -eq 1 ]
do
	echo -n "\n\n> Hledaný text: "
	read co
	pdfgrep -HiR "$co" $kde
	echo "Hledal se text: $co"
done


