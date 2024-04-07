#!/bin/bash

source "$UTILITIES_DIR/get_allowed_branch_types.sh"
ALLOWED_BRANCH_TYPES=(${ALLOWED_BRANCH_TYPES[@]})

# Detect current working branch and current sprint
current_branch=$(git rev-parse --abbrev-ref HEAD)
current_sprint=$("$UTILITIES_DIR/get_current_sprint.sh")

# Prompt user for confirmation
read -p "
Creating pull request - 
Working Branch : $current_branch
Target Branch  : $current_sprint

Continue? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Nn]$ ]] 
then
    echo "Aborted."
    echo ""
    exit 0
fi

read -p "
Is '$current_branch' up-to-date with '$current_sprint'? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Nn]$ ]]
then
    echo "
Run the following commands and resolve any merge conflicts

> git pull $TARGET_REMOTE $current_sprint
> git merge $current_branch $current_sprint 
# (Resolve merge conflicts as needed)
> releaseweaver.pr_submit
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

# Get the latest commit for $current_sprint
latest_commit=$(git log --format=%H -n1 "$TARGET_REMOTE_NAME/$current_sprint")

# Push $current_branch upstream
git push --set-upstream $TARGET_REMOTE_NAME $current_branch

# Create pull request
echo ""
git request-pull "${latest_commit}" $TARGET_REMOTE_NAME $current_sprint
echo ""

echo "Pull request created successfully."
