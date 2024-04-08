# .bashrc
# This file is executed by bash for non-login shells.

# Source the global definitions (if any)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export ENV_CONFIG_PATH="./env_config.json"

# Check if the JSON configuration file exists
if [ ! -f "$ENV_CONFIG_PATH" ]; then
    echo "Configuration file not found: $ENV_CONFIG_PATH"
    exit 1
fi

current_dir=`pwd`
export LIBRARY_DIR="$current_dir/library"
export UTILITIES_DIR="$LIBRARY_DIR/utilities"
export COMMAND_DIR="$LIBRARY_DIR/commands"
export RELEASE_DIR="$current_dir/releases"
export RC_DIR="$RELEASE_DIR/release-candidates"
export SPRINT_DIR="$RELEASE_DIR/sprints"

# Check if the set_environment.sh file exists
if [ -f $UTILITIES_DIR/set_environment.sh ]; then
    # Terraform Deployment Environment Setup
    source $UTILITIES_DIR/set_environment.sh
    echo "Environment variables configured."
    echo "----"
fi

# Aliases for Terraform Deployment Scripts
alias start_sprint="$COMMAND_DIR/start_sprint.sh"
alias start_task="$COMMAND_DIR/start_task.sh"
alias pr_submit="$COMMAND_DIR/pr_submit.sh"
alias pr_update="$COMMAND_DIR/pr_update.sh"
alias rc_configure="$COMMAND_DIR/rc_configure.sh"
alias rc_build="$COMMAND_DIR/rc_build.sh"
alias rc_release="$COMMAND_DIR/rc_release.sh"
alias release_note_compile="$COMMAND_DIR/release_note_compile.sh"
alias release_note_publish="$COMMAND_DIR/release_note_publish.sh"
alias cleanup_released_branches_remote="$COMMAND_DIR/cleanup_released_branches_remote.sh"
alias cleanup_released_branches_local="$COMMAND_DIR/cleanup_released_branches_local.sh"
alias current_sprint="$COMMAND_DIR/current_sprint.sh" 
alias get_current_sprint="$COMMAND_DIR/get_current_sprint.sh"

# Utilities 
releaseweaver.help(){
  echo ""
  declare -F | grep 'releaseweaver' | awk '{printf "> %s\n" , $3}'
  echo ""
} 

alias releaseweaver=releaseweaver.help

# Environment Variables
releaseweaver.env_config(){
    echo""
    echo "PROJECT_TITLE        : $PROJECT_TITLE"
    echo "TARGET_REPOSITORY    : $TARGET_REPOSITORY"
    echo "TARGET_REMOTE_NAME   : $TARGET_REMOTE_NAME"
    echo "DEFAULT_BRANCH       : $DEFAULT_BRANCH"
    echo "JIRA_BOARD_ID        : $JIRA_BOARD_ID"
    echo "ALLOWED_BRANCH_TYPES : ${ALLOWED_BRANCH_TYPES}"
    echo ""
}

releaseweaver.start_sprint() {
    start_sprint
}
 
releaseweaver.start_task() { 
    start_task
} 

releaseweaver.current_sprint() {
    current_sprint
}
 
releaseweaver.pr_submit() { 
    pr_submit
}

releaseweaver.pr_update() { 
    pr_update
}

# Display available commands
echo "
__________       .__                               
\______   \ ____ |  |   ____ _____    ______ ____  
 |       __/ __ \|  | _/ __ \\\__  \  /  ____/ __ \ 
 |    |   \  ___/|  |_\  ___/ / __ \_\___ \\\  ___/ 
 |____|_  /\___  |____/\___  (____  /____  >\___  >
 __     \__    \/          \/     \/     \/     \/ 
/  \    /  \ ____ _____ ___  __ ___________        
\   \/\/   _/ __ \\\__  \\\  \/ _/ __ \_  __ \       
 \        /\  ___/ / __ \\\   /\  ___/|  | \/       
  \__/\  /  \___  (____  /\_/  \___  |__|          
       \/       \/     \/          \/         
"
echo ""
echo "Release Weaver is loaded into your terminal."
echo "The following commands are available:"
                                    
releaseweaver
releaseweaver.env_config