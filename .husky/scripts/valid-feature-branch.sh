#!/usr/bin/env bash
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"

if [[ ! $BRANCH_NAME = "asd" ]]; then
    exit 0
fi

valid_length=20
valid_branch_regex='^((feature)\-[a-z0-9\-]+)$'

invalid_length="[$BRANCH_NAME]: length must be less than $valid_length, the length is ${#BRANCH_NAME}"
invalid_message="[$BRANCH_NAME]: accepts only lower case and numbers"

if [[ ${#BRANCH_NAME} -ge valid_length ]]; then
    echo "$invalid_length"
    exit 1
fi

if [[ ! $BRANCH_NAME =~ $valid_branch_regex ]]; then
    echo "$invalid_message"
    exit 1
fi

exit 0