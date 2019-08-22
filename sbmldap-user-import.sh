#!/bin/bash

if [ $# -eq 0 ]; then echo "Není zadán vstupní soubor v prvním parametru!"; exit; fi

radek=1
celkem=$(wc -l $1 | cut -d " " -f1)

while [ $radek -le $celkem ]
do
    zpracuj=$(sed -n "$radek"p $1)

    prijmeni=$(echo $zpracuj | cut -d "," -f1)
    jmeno=$(echo $zpracuj | cut -d "," -f2)
    ulogin=$(echo $zpracuj | cut -d "," -f3)
    heslo=$(echo $zpracuj | cut -d "," -f4)

    echo "Zpracovávám uživatele s loginem: $ulogin"
    smbldap-useradd -a -m -G "kabinety","ucitele-wifi" -N $jmeno -S $prijmeni $ulogin
    smbldap-passwd -p $heslo $ulogin

    radek=$(($radek+1))
done

echo "Zpracováno $(($radek-1)) uživatelů"
echo ">>> HOTOVO <<<"
