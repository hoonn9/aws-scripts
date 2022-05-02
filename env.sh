#!/bin/bash

function load_envs() {
  local envFile=${1:-.env}
  local isComment='^[[:space:]]*#'
  local isBlank='^[[:space:]]*$'

  echo "Load enviroment variables..."
  while IFS= read -r line; 
  do

    [[ $line =~ $isComment ]] && continue
    [[ $line =~ $isBlank ]] && continue

    echo ${line}


    key=$(echo "$line" | cut -d '=' -f 1)
    value=$(echo "$line" | cut -d '=' -f 2-)
    eval "${key}=\"$(echo \${value})\""
 
  done < <( cat "$envFile"; echo; )

  echo "Load enviroment variables successful"
}
