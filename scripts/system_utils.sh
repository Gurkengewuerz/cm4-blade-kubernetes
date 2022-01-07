command_exists () {
  if [ -z "$(type "$1" 2> /dev/null)" ]; then
   echo -e false
   return 1
  fi
  echo -e true
  return 0
}


package_allowed() {
    # TODO: Check if is in apt-cache show
    return 0
}

package_exists() {
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed")
    if [ "" == "$PKG_OK" ]; then
        return 1
    fi
    return 0
}

system_verify() {
    if ! package_exists $1 && ! command_exists $1; then
        printf "${PLAIN} • ${RED}$1 missing.${PLAIN} "

        if command_exists apt-get; then
            printf "Installing...  "

            if ! package_allowed $1; then
                printf "${RED}$1 Package doesn't exist for your arch. Please install it manually.${PLAIN}\n"
                exit 1
            fi

            if command_exists apt-get; then
                apt-get install -y "$1"  > /dev/null 2>&1 &
                spinner $!
                printf "\b${GREEN}Installed!${PLAIN}"

            else
                printf "${RED}Package doesn't exist for your arch. Please install it manually.\n"
            fi

        else
            printf "Please install it manually.\n"
			exit 1
        fi
    else
        printf "${PLAIN} • ${GREEN}$1 exists!${PLAIN}"
    fi
    printf "\n"
}

get_physical_interfaces() {
    IF=$(find /sys/class/net -type l -not -lname '*virtual*' -printf '%f\n')
    eval "$1='${IF}'"
}

guess_private_ip() {
    IP=""
    get_physical_interfaces INTERFACES
    for ifc in $(echo -e $INTERFACES); do
      IPV4_IF=$(ip -4 -o addr show dev ${ifc} | awk '{split($4,a,"/");print a[1]}' | head -n 1)
      if [ ! -z "$IPV4_IF" ]; then
        if [ -z "$IP" ]; then
            IP=$IPV4_IF
        else
            GREPPED=$(echo "${IPV4_IF}" | awk '/^(192\.168|10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.)/ {print $0}')
            if [ ! -z "$GREPPED" ]; then
                IP=$GREPPED
            fi
        fi
      fi
    done
    eval "$1=${IP}"
}

guess_private_interface() {
    guess_private_ip PIP
    IF=$(ip -br -4 a sh | grep $PIP | awk '{print $1}')
    eval "$1='${IF}'"
}
