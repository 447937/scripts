#!/bin/bash

if [ $# -eq 0 ]; then echo "Není zadán vstupní soubor v prvním parametru!"; exit; fi

echo ">>> START <<<"
radek=1
celkem=$(wc -l $1 | cut -d " " -f1)

function ChangePasswd()
{
	/usr/bin/expect <<EOF
	spawn smbldap-passwd $ulogin
	expect "New password: "
	send -- "$heslo\r"
	expect "Retype new password: "
	send -- "$heslo\r"
	expect eof
	EOF
}

while [ $radek -le $celkem ]
do
    zpracuj=$(sed -n "$radek"p $1)

    prijmeni=$(echo $zpracuj | cut -d "," -f1)
    jmeno=$(echo $zpracuj | cut -d "," -f2)
    ulogin=$(echo $zpracuj | cut -d "," -f3)
    heslo=$(echo $zpracuj | cut -d "," -f4)

    echo "Zpracovávám uživatele s loginem: $ulogin"
    smbldap-useradd -a -m -G "GROUP1","GROUP2" -N $jmeno -S $prijmeni $ulogin #create user and add grand him membership in GROUP1 and GROUP2
	ChangePasswd
    radek=$(($radek+1))
done

echo "Zpracováno $(($radek-1)) uživatelů"
echo ">>> HOTOVO <<<"

#Expecter row formating in csv file:
#lastname,firstname,user_name,password
