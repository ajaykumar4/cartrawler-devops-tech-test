#!/usr/bin/env bash

# A wrapper script to manage the local development environment using Ansible.
#
# Usage:
#   ./infrastructure.sh setup       - Installs tools, provisions Minikube, and deploys the app.
#   ./infrastructure.sh destroy     - Tears down the app, deletes the Minikube cluster, and uninstalls tools.
#

set -e  # Exit immediately if a command exits with a non-zero status.

# --- ANSI Color Codes for beautiful output ---
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Helper function for script usage ---
show_usage() {
    echo -e "${YELLOW}Usage: $0 {setup|destroy}${NC}"
    echo "  setup    : Build the full local Kubernetes environment."
    echo "  destroy  : Tear down the environment and uninstall tools."
    exit 1
}

# --- Function to run the setup process ---
run_setup() {
    echo -e "\n${GREEN}▶️  Starting Full Environment Setup...${NC}"
    echo "This will install tools (if missing) and provision your Minikube cluster."
    echo "You will be prompted for your sudo password for tasks that require it."

    # Run the master setup playbook, passing the -K flag
    ansible-playbook iac/minikube_setup.yml -K

    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}✅ Setup completed successfully!${NC}"
    else
        echo -e "\n${RED}❌ Setup failed.${NC}"
        exit 1
    fi
}

# --- Function to run the destroy process ---
run_destroy() {
    echo -e "\n${YELLOW}▶️  Starting Full Environment Teardown...${NC}"
    
    # Critical step: Ask for confirmation before destroying everything.
    read -p "This action is destructive. It will delete the Minikube cluster and uninstall tools. Are you sure? (y/n) " -n 1 -r
    echo # Move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ Teardown aborted by user.${NC}"
        exit 1
    fi

    echo "Proceeding with teardown. You will be prompted for your sudo password."

    # Run the master cleanup playbook, passing the -K flag
    ansible-playbook iac/minikube_cleanup.yml -K

    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}✅ Teardown completed successfully!${NC}"
    else
        echo -e "\n${RED}❌ Teardown failed.${NC}"
        exit 1
    fi
}

# --- Main script logic ---
# Check if an argument was provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: No command provided.${NC}"
    show_usage
fi

# Case statement to handle the user's command
case "$1" in
    setup)
        run_setup
        ;;
    destroy)
        run_destroy
        ;;
    *)
        echo -e "${RED}Error: Invalid command '$1'${NC}"
        show_usage
        ;;
esac

exit 0