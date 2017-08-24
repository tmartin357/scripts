#!/usr/bin/env bash

#set -x

function check {
  if [[ ! $(file "$1") == *"Matroska"* ]]; then
    #>&2 echo -e  "\e[93m$1 : not a regular file\e[0m"
    return
  fi

  OUTP=$(mkvinfo "$1")

  if [[ ! $? -eq 0 ]]; then
    #>&2 echo -e  "$OUTP"
    #>&2 echo -e  ""
    >&2 echo -e  "\e[93m$1 : mkvinfo did not return zero.\e[0m"
    return
  fi

  grep "High 10\|Main 10" <<< $OUTP 2>&1 1>/dev/null

  case $? in
    0 )
      echo -e "\e[31m$1 : 10bit\e[0m"
      ;;
    1 )
      echo -e  "\e[32m$1 : Not 10bit\e[0m"
      ;;
    * )
      >&2 echo -e  "\e[93m$1 : ERROR\e[0m"
  esac
}

for i in "$@"; do
  check "$i"
done