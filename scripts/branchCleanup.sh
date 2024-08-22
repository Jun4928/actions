#!/bin/bash

echo "Step 1: Listing all branches matching '*release*', sorted by committer date"
step1_output=$(git branch --list '*release*' --sort=-committerdate -av)
echo "$step1_output"

echo "Step 2: Exclude the first four branches, show the rest"
step2_output=$(echo "$step1_output" | tail -n +5)
echo "$step2_output"

echo "Step 3: Extracting the branch names"
step3_output=$(echo "$step2_output" | awk '{print $1}')
echo "$step3_output"

echo "Step 4: Removing 'remotes/origin/' prefix from branch names"
step4_output=$(echo "$step3_output" | sed 's/remotes\/origin\///')
echo "$step4_output"

echo "Step 5: Deleting the branches on remote"
for branch in $step4_output; do
  echo "Deleting branch $branch"
  git push origin --delete "$branch" --no-verify
done

