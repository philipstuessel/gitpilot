if command -v sshpass &> /dev/null && command -v jq &> /dev/null; then
    echo ""
else
    if ! command -v jq &> /dev/null; then
        brew install jq
    fi
    if ! command -v sshpass &> /dev/null; then
        brew install hudochenkov/sshpass/sshpass
    fi
fi

source ~/.zshrc
fetch ~/jap/plugins/packages/ ~/jap/plugins/packages/gitpilot.zsh https://raw.githubusercontent.com/philipstuessel/gitpilot/main/gitpilot.zsh
echo "${CYAN}GitPilot is installed${NC}"