#!/usr/bin/env bash

set -euo pipefail

#/
#/ Usage: 
#/ ./casbab.sh option [string]
#/ 

detect() {
  # Return normalized string, all lower and with spaces as separators
  arg=( "${@:-}" )
  helper=""
  for i in '_' '-' ' '; do
    if [[ ${arg[*]} == *$i* ]]; then
      helper="yes"
      echo "${arg[*]}" | tr '[:upper:]' '[:lower:]' | tr -s "${i}" ' '
    fi
  done
  # If '_','-' and ' ' are not used as a separator try by case
  if [[ -z $helper ]] && [[ ${arg[0]} != '' ]]; then
    dif_case "${@:-}" | tr '[:upper:]' '[:lower:]'
  fi
}

check_case() {
  # Check char case
  if [[ ${1:-} == [[:upper:]] ]]; then
    echo 0
  elif [[ ${1:-} == [[:lower:]] ]]; then
    echo 1
  fi
}

dif_case() {
  # Parse string char by char
  arg=( "${@:-}" )
  helper=""
  for (( i=0; i<${#arg}; i++ )); do
    if [[ $i == 0 ]]; then
      helper="${arg:$i:1}"
    elif ([[ $(check_case "${arg:$i:1}") == 0 ]] && [[ $(check_case "${arg:((i+1)):1}") == 1 ]]) || ([[ $(check_case "${arg:$i:1}") == 0 ]] && [[ $(check_case "${arg:((i-1)):1}") == 1 ]]); then
      helper="${helper} ${arg:$i:1}"
    elif [[ $i == [^a-zA-Z] ]] || [[ $(check_case "${arg:$i:1}") == $(check_case "${arg:((i-1)):1}") ]] || ([[ $(check_case "${arg:$i:1}") == 1 ]] && [[ $(check_case "${arg:((i-1)):1}") == 0 ]]);then
      helper="${helper}${arg:$i:1}"
    else
      echo "Unknown character: ${arg:$i:1}"
      exit 1
    fi
  done
  echo "${helper}"
}

first_up() {
  # Set first letter upper in a single word
  helper=${1}
  echo "$(tr '[:lower:]' '[:upper:]' <<< "${helper:0:1}")${helper:1}"
}


replace() {
  # Read from stdin and replace ' ' with $1
  cat | tr -s ' ' "${1}"
}

#/   kebab returns "camel-snake-kebab"
kebab() {
  detect "${@:-}" | replace '-'
}

#/
#/   --help: Display this help message
#/

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then

  arg=( "${@:2}" )

  if [[ -t 0 && -z ${arg[*]} ]]; then
    if [[ ${#arg[*]} -eq 1 ]]; then
      arg[0]=' '
    else
      usage
    fi 
  fi
  
  arg=( ${arg:-$(cat -)} )

  case ${1:-} in
    kebab)
      kebab "${arg[*]:-""}"
    ;;
  esac
fi