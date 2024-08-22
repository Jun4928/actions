#!/bin/bash

# Step 1: List all branches matching '*release*', sorted by committer date
echo "Step 1: Listing all branches matching '*release*', sorted by committer date"
step1_output=$(git branch --list '*release*' --sort=-committerdate -av)
echo "$step1_output"

# Step 2: Exclude the first four branches, only show the rest
echo "Step 2: Exclude the first four branches, show the rest"
step2_output=$(echo "$step1_output" | tail -n +5)
echo "$step2_output"

# Step 3: Print the first column (branch name) from the result
echo "Step 3: Extracting the branch names"
step3_output=$(echo "$step2_output" | awk '{print $1}')
echo "$step3_output"

# Step 4: Remove 'remotes/origin/' prefix from branch names
echo "Step 4: Removing 'remotes/origin/' prefix from branch names"
step4_output=$(echo "$step3_output" | sed 's/remotes\/origin\///')
echo "$step4_output"

# # Step 5: Delete each branch on the remote
# echo "Step 5: Deleting the branches on remote"
# echo "$step4_output" | xargs -L1 -I {} bash -c 'echo "Deleting branch {}"; git push origin --delete {} --no-verify'
