#!/usr/bin/env bash

set -euo pipefail

#/
#/ Refernece:
#/ https://github.com/vandot/casbab/blob/master/casbab.sh
#/
#/ Usage: 
#/ ./casbab.sh kebab [string]
#/ 

detect() {
  # Return normalized string, all lower and with spaces as separators
  arg=( "${@:-}" )
  helper=""
  if [[ ${arg[*]} == *-* ]] || [[ ${arg[*]} == *_* ]]; then
    helper="yes"
    echo "${arg[*]}" | tr '[:upper:]' '[:lower:]' | tr -s "_" ' '
  fi
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

replace() {
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
  arg=( ${arg:-$(cat -)} )

  case ${1:-} in
    kebab)
      kebab "${arg[*]:-""}"
    ;;
  esac
fi