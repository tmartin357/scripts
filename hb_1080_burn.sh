#!/usr/bin/env bash

#set -x

function convert_video {
  if ! [[ ${1: -4} == ".mkv" || ${1: -4} == ".mp4" ]]; then
    return
  fi

  mkdir -p ~/Videos/auto/

  #ARGS="-e x264 -q 18.0 -a 1,2,3 -E copy -s 1,2,3 "

  echo -e "\e[93mConverting "$(basename "$1")"...\e[0m"

  IN="$1"

  NEWN=$(echo $(basename "$1") | perl -pe 's/\[[a-f,A-F,0-9]{8}\]/\[8bit\]/g')
  OUT=$HOME"/Videos/auto/"$NEWN

  HandBrakeCLI -e x264 -q 18.0 -a 1,2,3 -E copy -s 1,2,3 --subtitle-burned -i "$IN" -o "$OUT"

  #notify -t "Converted $(basename "$1")"
  /home/hatz/scripts/ifttt-trigger.sh "Converted: $NEWN"

}

for i in "$@"; do
  convert_video "$i"
done