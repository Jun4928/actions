#!/usr/bin/env bash
local_branch_name="$(git rev-parse --abbrev-ref HEAD)"

valid_branch_regex='^((feature)\-[a-z0-9\-]+)$'

invalid_message="feature-branch rule: length must be less than 10 and accepts only lower case and numbers"

if [[ $local_branch_name -ge 10 ]]; then
    echo "$invalid_message"
    exit 1
fi

if [[ ! $local_branch_name =~ $valid_branch_regex ]]; then
    echo "$invalid_message"
    exit 1
fi

exit 0