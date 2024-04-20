
if ! command -v sshpass &> /dev/null; then
    brew install hudochenkov/sshpass/sshpass
fi

source ~/.zshrc
fetch2 ${JAP_FOLDER}plugins/packages/gitpilot/ https://raw.githubusercontent.com/philipstuessel/gitpilot/main/gitpilot.zsh
echo "${CYAN}GitPilot is installed${NC}"