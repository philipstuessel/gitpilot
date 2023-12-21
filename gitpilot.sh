#!/bin/zsh
gitpilot() {
    if [[ "$1" == "v" ]]; then
        echo "${CYAN}GitPilot${NC}"
        echo "${BOLD}v0.2.0${NC}"
        echo "${YELLOW}JAP plugin${NC}"
    fi
    
    if [[ "$1" == "deploying" || "$1" == "dep" ]]; then
        commit_hash=$(git rev-parse HEAD)

        target_folder="/Users/$USER/gitpilot/$2/"
        temp_directory="/Users/$USER/gitpilot/$2/temp/"

        if [ -d $target_folder ]; then
            rm -r $target_folder
        fi

        mkdir -p "$temp_directory"
        git checkout -b temp_branch "$commit_hash"
        changed_files=$(git diff --name-only HEAD^)

        echo "$changed_files" | tar czf "$temp_directory.tar.gz" --files-from -
        tar xzf "$temp_directory.tar.gz" -C "$temp_directory"

        cp -r "$temp_directory" "$target_folder"
        rm -rf "$temp_directory" "$temp_directory.tar.gz"
        git checkout - 
        git branch -D temp_branch 

        echo "${GREEN}Everything was provided${NC}"
    fi
        if [[ "$1" == "deploying-all" || "$1" == "dep-all" ]]; then
        commit_hash=$(git rev-parse HEAD)

        target_folder="/Users/$USER/gitpilot/$2/"
        temp_directory="/Users/$USER/gitpilot/$2/temp/"
        
        if [ -d $target_folder ]; then
            rm -r $target_folder
        fi

        mkdir -p "$temp_directory"
        git archive --format zip --output "$temp_directory.zip" "$commit_hash"
        unzip "$temp_directory.zip" -d "$temp_directory"
        cp -r "$temp_directory" "$target_folder"
        rm -rf "$temp_directory" "$temp_directory.zip"
        echo "${GREEN}Everything was provided${NC}"
    fi

    if [[ "$1" == "push" || "$1" == "push-all" ]]; then
        if [[ "$1" == "push-all" ]]; then
            gitpilot dep-all "$2"
        else
            gitpilot dep "$2"

        fi
        echo "${BLUE}reading gp.json${NC}"

        local_folder="/Users/$USER/gitpilot/$2/"
        username=$(cat "$(pwd)/.gitpilot/gp.json" | grep '"username"' | awk -F ': *' '{print $2}' | tr -d '," ')
        server_ip=$(cat "$(pwd)/.gitpilot/gp.json" | grep '"server_ip"' | awk -F ': *' '{print $2}' | tr -d '," ')
        target_directory_on_server=$(cat "$(pwd)/.gitpilot/gp.json" | grep '"target_directory_on_server"' | awk -F ': *' '{print $2}' | tr -d '," ')
        ssh_password=$(cat "$(pwd)/.gitpilot/gp.json" | grep '"ssh_password"' | awk -F ': *' '{print $2}' | tr -d '," ')

        echo "${BOLD}push on server ...${NC}"
        sshpass -p "$ssh_password" scp -r "$local_folder"* "$username"@"$server_ip":"$target_directory_on_server"
        echo "${BLUE}####################################${NC}"
        echo "${CYAN}GitPilot${NC}${BLUE} has finished its work${NC}"
        echo "${GREEN}Done${NC}"
    fi
}