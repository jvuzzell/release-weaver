#!/bin/bash

echo ""
# Check if git is initialized in the current directory
if ! git rev-parse --is-inside-work-tree &>/dev/null;then
    echo "Git is not initialized in this directory. Please initialize git first."
    echo ""
    exit 1
fi

# Prompt user for current sprint number
read -p "Enter the number of the current sprint: " sprint_number

# Create branch name
branch_name="release/sprint_$sprint_number"
git checkout $DEFAULT_BRANCH && git checkout -b $branch_name
echo ""

# Save branch name to current_sprint.txt
echo "$branch_name" > "$RELEASE_DIR/current_sprint.txt"

# Push changes to the remote repository
remote_repo=$(git remote get-url origin)

# Make sure branch exists in remote repository
if git ls-remote --exit-code --heads "$remote_repo" "$branch_name" &>/dev/null;then
    echo "Branch $branch_name already exists in the remote repository."
    echo ""
else
    echo "Creating and pushing branch $branch_name to the remote repository..."
    echo ""
    git push --set-upstream $TARGET_REMOTE_NAME "$branch_name"
    echo ""
    echo "Sprint $sprint_number has begun. Happy coding!!!"
fi

echo ""