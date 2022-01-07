init_colors() {

	if [[ $USE_COLORS == "false" ]]; then
		RED=""
		GREEN=""
		BLUE=""
		YELLOW=""
		PLAIN=""

		RED_BOLD=""
		GREEN_BOLD=""
		BLUE_BOLD=""
		YELLOW_BOLD=""
		PLAIN_BOLD=""
	else
		RED='\033[0;31m'
		GREEN='\033[0;32m'
		BLUE='\033[0;34m'
		YELLOW='\033[0;33m'
		PLAIN='\033[0m'

		RED_BOLD='\033[1;31m'
		GREEN_BOLD='\033[1;32m'
		BLUE_BOLD='\033[1;34m'
		YELLOW_BOLD='\033[1;33m'
		PLAIN_BOLD='\033[1;37m'
	fi

}
