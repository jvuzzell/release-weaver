#!/bin/bash

echo ""
# Prompt user for branch type
read -p "Enter the branch type (hotfix, bugfix, feature): " branch_type

# Check if branch type is allowed
if [[ ! " ${ALLOWED_BRANCH_TYPES[@]} " =~ " $branch_type " ]]; then
    echo "Invalid branch type. Please choose one of the following: hotfix, bugfix, feature"
    echo ""
    exit 1
fi

# Prompt user for JIRA task number
read -p "Enter the JIRA task number (1-10 digits): " jira_task_number

# Validate JIRA task number
if ! [[ "$jira_task_number" =~ ^[0-9]{1,10}$ ]]; then
    echo "Invalid JIRA task number. Please enter a numeric string with 1-10 digits."
    echo ""
    exit 1
fi

# Concatenate branch name
branch_name="$branch_type/$JIRA_BOARD_ID-$jira_task_number"

# Check out default branch and create new branch
echo ""
git checkout $DEFAULT_BRANCH && git checkout -b $branch_name
echo ""
echo ""

# Push changes to the remote repository
git push --set-upstream $TARGET_REMOTE_NAME "$branch_name"

echo ""