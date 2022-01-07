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
        printf "${BLUE}"
        printf " • $1 "

        if [[ $2 == "no" ]]; then
            printf "${PLAIN}[yes | ${GREEN_BOLD}no${PLAIN}] "
            read -e ans
            if [[ -z "$ans" ]]; then
                ans="no"
            fi
        else
            printf "${PLAIN}[${GREEN_BOLD}yes${PLAIN} | no] "
            read -e ans
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
    printf "${PLAIN} • ${BLUE}$2 "

    printf "${PLAIN}[${GREEN_BOLD}$3${PLAIN}] "

    read -e ans
    if [[ -z "$ans" ]]; then
        ans="$3"
    fi

    eval "$1='"$ans"'"
}
