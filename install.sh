if command -v sshpass &> /dev/null; then
    echo ""
else
    brew install hudochenkov/sshpass/sshpass
fi

echo $(mkdir -p ~/jap/plugins/packages/ && curl -o ~/jap/plugins/packages/gitpilot.sh https://raw.githubusercontent.com/philipstuessel/gitpilot/main/gitpilot.sh)
echo "--GitPilot is installed--"