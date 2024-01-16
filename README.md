# GitPilot

GitPilot is a powerful script designed to simplify the deployment process for Git projects, providing developers with a streamlined workflow. It leverages Git for version control and integrates secure copy (SCP) for efficient code transfer to a remote server.

**Features:**

**Version Display:** Check the version of GitPilot using the command `gitpilot v`.

**Push to Server:** The `gitpilot push [project_name]` command automates the entire deployment process. It executes the deployment steps and pushes the code to the server, making the deployment process a single, efficient operation.
`gitpilot push-all [project_name]`: push all files from the last commit.

**Usage:**
- Check GitPilot version: `gitpilot v`
- Push to server: `gitpilot push [project_name]`

**Configuration File (`/.gitpilot/gp.json`):**
- `username`: Username for the server.
- `server_ip`: IP address of the remote server.
- `target_directory_on_server`: Target directory on the server to deploy the code.
- `ssh_password`: SSH password for secure copy (SCP) authentication.
- `ignore`: ignore files or directory

**Example:**
```zsh
# Push code to the server
gitpilot push my_project
```

GitPilot streamlines the deployment and pushing process, providing developers with an efficient and hassle-free experience. Deploy your Git projects with confidence using GitPilot's comprehensive functionality.
