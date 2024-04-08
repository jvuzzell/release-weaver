#!/bin/bash

source "$UTILITIES_DIR/get_allowed_branch_types.sh"
ALLOWED_BRANCH_TYPES=(${ALLOWED_BRANCH_TYPES[@]})

# Detect current working branch and current sprint
current_branch=$(git rev-parse --abbrev-ref HEAD)
current_sprint=$("$UTILITIES_DIR/get_current_sprint.sh")

# Prompt user for confirmation
read -p "
Updating pull request -

Working Branch : $current_branch
Target Branch  : $current_sprint

Is '$current_branch' up-to-date with '$current_sprint'? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Nn]$ ]]
then
    echo "
Run the following commands:
=========================================
> git pull $TARGET_REMOTE $current_sprint
> git merge $current_branch $current_sprint

# (Resolve merge conflicts as needed)

> releaseweaver.pr_update
=========================================
Aborting.
"
    exit 0
fi

# Validate current branch format

branch_valid=false
for branch_type in "${ALLOWED_BRANCH_TYPES[@]}"; do 
    if [[ "$current_branch" == "$branch_type"* ]]; then
        branch_valid=true
        break
    fi
done

if ! $branch_valid; then
    echo "
Current branch does not conform to allowed branch types (hotfix/, bugfix/, feature/).
    "
    exit 1
fi

# Push $current_branch upstream
echo ""
git push --set-upstream $TARGET_REMOTE_NAME $current_branch
echo ""

# Create pull request
echo "
=========================================

Follow this link to update your PR --->

$PULL_REQUEST_LINK$current_branch

=========================================
"
