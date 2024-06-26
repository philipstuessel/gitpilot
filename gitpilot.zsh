#!/bin/zsh
gitpilot_check() {
    if [ ! -d "$(pwd)/.git" ]; then
        echo "${RED}.git folder not found${NC}"
        return 1
    fi
    if [ ! -f "$(pwd)/.gitpilot/gp.json" ]; then
        echo "${RED}gp.json file not found in .gitpilot folder${NC}"
        return 1
    fi
    return 0
}

gitpilot() {
    local_folder="/Users/$USER/gitpilot/$2/"
    
    if [[ "$1" == "v" || "$1" == "-v" ]]; then
        echo "${CYAN}GitPilot${NC}"
        echo "${BOLD}v.0.2.5${NC}"
        echo "${YELLOW}JAP plugin${NC}"
    fi
    
    if [[ "$1" == "deploying" || "$1" == "dep" ]]; then
        commit_hash=$(git rev-parse HEAD)

        target_folder="/Users/$USER/gitpilot/$2/"
        temp_directory="/Users/$USER/gitpilot/$2/temp/"
        GP="$(pwd)/.gitpilot/gp.json"

        if [ -d $target_folder ]; then
            rm -r $target_folder
        fi

        mkdir -p "$temp_directory"
        git checkout -b temp_branch "$commit_hash" > /dev/null 2>&1
        changed_files=$(git diff --name-only HEAD^)
        
        echo "Changed files:"
        echo "${changed_files}"

        if [ -f "$GP" ]; then
            ignore_list=$(jq -r '.ignore[]' "$GP" | xargs)
            for ignore_item in $ignore_list; do
                changed_files=$(echo "$changed_files" | grep -v "$ignore_item")
            done
            
            extra_list=$(jq -r '.extra[]' "$GP" | xargs)
            current_path="$(pwd)"
            if [[ ! $extra_list == "" ]]; then
            for extra_item in $extra_list; do
                relative_path="${extra_item#$current_path/}"
                destination_folder="${local_folder}${relative_path%/*}"
                mkdir -p "$destination_folder"
                cp -r "$extra_item" "$destination_folder"
                echo "- e $extra_item";
            done
            fi
        fi

        echo "$changed_files" | tar czf "$temp_directory.tar.gz" --files-from -
        tar xzf "$temp_directory.tar.gz" -C "$temp_directory" > /dev/null 2>&1

        cp -r "$temp_directory" "$target_folder"
        rm -rf "$temp_directory" "$temp_directory.tar.gz"
        git checkout - > /dev/null 2>&1
        git branch -D temp_branch > /dev/null 2>&1

        echo "${GREEN}Everything was provided${NC}"
    fi
        if [[ "$1" == "deploying-all" || "$1" == "dep-all" ]]; then
        commit_hash=$(git rev-parse HEAD)

        target_folder="/Users/$USER/gitpilot/$2/"
        temp_directory="/Users/$USER/gitpilot/$2/temp/"
        
        if [ -d $target_folder ]; then
            rm -r $target_folder
        fi
        
        extra_list=$(jq -r '.extra[]' "$GP" | xargs)
        current_path="$(pwd)"
        echo $extra_list
        echo "---"
        if [[ ! $extra_item == "" ]]; then
            for extra_item in $extra_list; do
                relative_path="${extra_item#$current_path/}"
                destination_folder="${local_folder}${relative_path%/*}"
                mkdir -p "$destination_folder"
                cp -r "$extra_item" "$destination_folder"
                echo "- e $extra_item";
            done
        fi
        mkdir -p "$temp_directory"
        git archive --format zip --output "$temp_directory.zip" "$commit_hash"
        unzip "$temp_directory.zip" -d "$temp_directory"
        cp -r "$temp_directory" "$target_folder"
        rm -rf "$temp_directory" "$temp_directory.zip"
        echo "${GREEN}Everything was provided${NC}"

    fi
    if [[ "$1" == "push" || "$1" == "push-all" ]]; then
        if ! gitpilot_check; then
            return 1
        fi
        echo "push date: $(date +"%Y-%m-%d %H:%M:%S")"

        if [[ "$1" == "push-all" ]]; then
            gitpilot dep-all "$2"
        else
            gitpilot dep "$2"
        fi

        echo "${BLUE}reading gp.json${NC}"
        
        username=$(jq -r '.username' "$(pwd)/.gitpilot/gp.json")
        server_ip=$(jq -r '.server_ip' "$(pwd)/.gitpilot/gp.json")
        target_directory_on_server=$(jq -r '.target_directory_on_server' "$(pwd)/.gitpilot/gp.json")
        ssh_password=$(jq -r '.ssh_password' "$(pwd)/.gitpilot/gp.json")

        echo "${BOLD}push on server ...${NC}"
        sshpass -p "$ssh_password" scp -r "$local_folder"* "$username"@"$server_ip":"$target_directory_on_server"
        echo "${BLUE}####################################${NC}"
        echo "${CYAN}GitPilot${NC}${BLUE} has finished its work${NC}"
        echo "${GREEN}Done${NC}"
    fi
}