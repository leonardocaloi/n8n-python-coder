# N8N-Python-Coder: Integrated Workflow Automation and Scripting Solution

Welcome to N8N-Python-Coder, an integrated environment merging the power of n8n's workflow automation with the flexibility of Python scripting, all served within a feature-rich Coder environment. This project is designed to provide a seamless, efficient, and enriched coding experience, bringing together a variety of tools into a unified, Dockerized environment.


## Key Features

- **n8n Workflow Automation:** n8n, the heart of the setup, is a free and open-source workflow automation tool that lets you design your own data-driven applications with ease.
- **Python Support:** Extending n8n with Python allows you to utilize Python scripts in your n8n nodes.
- **Integrated Coding Environment:** The Coder environment, based on Visual Studio Code, delivers a familiar and rich coding experience.
- **Oh My Zsh Terminal:** The Coder environment comes pre-configured with Oh My Zsh, an open-source, community-driven framework for managing your Zsh configuration that comes bundled with a ton of helpful functions, helpers, plugins, and themes.
- **Dracula Theme:** The elegant Dracula theme is preinstalled for both coding and terminal interface, ensuring eye comfort during long coding hours.
- **Python Extensions:** A set of beneficial Python extensions are included, enhancing your productivity by providing syntax highlighting, linting, formatting, and more.
- **Shared Volume:** A Docker volume shared between the n8n and Coder services ensures instantaneous availability of scripts written in the Coder for execution in n8n.
- **Persistent PostgreSQL Database:** The included PostgreSQL service provides a robust database solution, ensuring your data is safely persisted across sessions.


## Getting Started

### This project requires a **Linux-based** system with **Docker** and **Docker-compose** installed.

### Installation

**1. Configure Environment Variables:** An `.env` file is provided to define essential variables for the project. You need to update this file with your desired settings. Notably, you must correctly configure the N8N_WEBHOOK_URL variable.

> *⚠ I **strongly recommend** that you **do not** change the following variables that can cause serious problems in the deployment: `CODER_USER`, `CODER_PUID`, `CODER_PGID`, and `N8N_LOG_LEVEL` variables*

\
**2. Grant Execution Permissions:** The installation script install.sh must have proper execution permissions. This can be done with the following command:

```bash
chmod +x install.sh
```
\
**3. Run the Installation [Script](install.sh):** With the environment variables set, start the installation process by executing the script:

```bash
./install.sh
```
\
This script orchestrates the setup by performing the following tasks:

- Stops any existing Docker services related to the project.
- Builds the Docker images based on the Dockerfile and docker-compose configurations.
- Starts the Docker containers, initializing the n8n, PostgreSQL, and Coder services.
- Copies Python scripts and setup files into the code-server container.
- Executes the python_env.sh script inside the code-server container to install the Dracula theme, Python extensions, Oh My Zsh terminal, and set up the Python environment.


## Python Libraries Management

All Python libraries required for your scripts should be listed in the requirements.txt file inside the python directory. These libraries are installed into the n8n-python and Coder environments during the initial setup.

### To add a new library:

1. Update the `requirements.txt` [file](python/requirements.txt) with the library's name.

Install the library using the **"Execute Command"** node in **n8n** and the **terminal in the Coder** environment with the following command:

```bash
pip install -r requirements.txt
```

This process ensures that the required libraries are immediately available for your scripts, without the need to rebuild the Docker image. Since the volumes used in this setup are persistent, all installed libraries will be available even after a system restart.

### Using the Environment

Once the setup is complete, you can access the Coder environment, write Python scripts, and run them directly within the code-server. The Python scripts become immediately accessible within the n8n nodes, courtesy of the shared Docker volume.
