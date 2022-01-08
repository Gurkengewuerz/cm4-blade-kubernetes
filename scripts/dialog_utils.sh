spinner() {
    local spin="\\|/-"
    local i=0
    tput civis
    while kill -0 "$1" 2>/dev/null; do
        i=$(( (i+1) %4 ))
        printf "\b%s" "${spin:$i:1}"
        sleep 0.07
    done
    tput cnorm
}

yesno() {
    while true; do
        if [[ $2 == "no" ]]; then
            TXT=$(echo -e ${BLUE}• $1 ${PLAIN}[yes/${GREEN_BOLD}no${PLAIN}])
            read -p "$TXT " -e -r ans
            if [[ -z "$ans" ]]; then
                ans="no"
            fi
        else
            TXT=$(echo -e ${BLUE}• $1 ${PLAIN}[${GREEN_BOLD}yes${PLAIN}/no])
            read -p "$TXT " -e -r ans
            if [[ -z "$ans" ]]; then
                ans="yes"
            fi
        fi

        if [[ $ans == "yes" ]] || [[ $ans == "y" ]]; then
            return 0
        elif [[ $ans == "no" ]] || [[ $ans == "n" ]]; then
            return 1
        else
            printf "   ${RED}Invalid answer. Please answer with 'yes' or 'no'.\n"
        fi
    done
}

ask() {
    read -p "$(echo -e ${PLAIN} • ${BLUE}$2 ${PLAIN}[${GREEN_BOLD}$3${PLAIN}]) " -e -r ans
    if [[ -z "$ans" ]]; then
        ans="$3"
    fi

    eval "$1='"$ans"'"
}
