**GitPilot**

GitPilot is a powerful script designed to simplify the deployment process for Git projects, providing developers with a streamlined workflow. It leverages Git for version control and integrates secure copy (SCP) for efficient code transfer to a remote server.

**Features:**
1. **Version Display:** Check the version of GitPilot using the command `gitpilot v`.

2. **Deployment:** Deploy your Git project to a remote server seamlessly with the command `gitpilot deploying [project_name]` or `gitpilot dep [project_name]`. This command archives the latest Git commit, transfers it to the server, and extracts it into the specified target directory.

3. **Push to Server:** The `gitpilot push [project_name]` command automates the entire deployment process. It executes the deployment steps and pushes the code to the server, making the deployment process a single, efficient operation.

**Usage:**
- Check GitPilot version: `gitpilot v`
- Deploy project: `gitpilot deploying [project_name]` or `gitpilot dep [project_name]`
- Push to server: `gitpilot push [project_name]`

**Configuration File (`/gitpilot/gp.json`):**
- `username`: Username for the server.
- `server_ip`: IP address of the remote server.
- `target_directory_on_server`: Target directory on the server to deploy the code.
- `ssh_password`: SSH password for secure copy (SCP) authentication.

**Example:**
```zsh
# Display GitPilot version
gitpilot v

# Deploy project to the server
gitpilot deploying my_project

# Push code to the server
gitpilot push my_project
```

GitPilot streamlines the deployment and pushing process, providing developers with an efficient and hassle-free experience. Deploy your Git projects with confidence using GitPilot's comprehensive functionality.
