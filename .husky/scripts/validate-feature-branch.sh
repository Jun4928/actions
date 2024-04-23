#!/usr/bin/env bash
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"

if [[ ! $BRANCH_NAME == "feature-"* ]]; then
    exit 0
fi

valid_length=25
valid_branch_regex='^((feature)\-[a-z0-9\-]+)$'

invalid_length="[$BRANCH_NAME]: feature branch length must be less than $valid_length, the length is ${#BRANCH_NAME}"
invalid_message="[$BRANCH_NAME]: feature branch accepts only lower case and numbers"

if [[ ${#BRANCH_NAME} -ge valid_length ]]; then
    echo "$invalid_length"
    exit 1
fi

if [[ ! $BRANCH_NAME =~ $valid_branch_regex ]]; then
    echo "$invalid_message"
    exit 1
fi

echo "$BRANCH_NAME is ready to go 🤘"
exit 0