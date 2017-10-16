#!/usr/bin/env bash

if [ $# -eq 0 ]
  then
    echo "$0:" '"Original" "Edited" "Output"'
    exit 1
fi

#/usr/bin/mkvmerge --ui-language en_US --output '/home/hatz/Videos/[HorribleSubs] Boku no Hero Academia - 35 [1080p].mkv' --no-audio --language 0:und '(' '/home/hatz/Videos/[HorribleSubs] Boku no Hero Academia - 35 [1080p].m4v' ')' --no-video --no-subtitles --no-attachments --language 1:jpn --default-track 1:yes '(' '/home/hatz/Downloads/inbound/Boku no Hero Academia/[HorribleSubs] Boku no Hero Academia - 35 [1080p].mkv' ')' --track-order 0:0,1:1

if [ $# -eq 2 ]
  then
    set -x
    /usr/bin/mkvmerge --ui-language en_US --output "`basename "$1"`" --no-audio  '(' "$2" ')' --no-video --no-subtitles --no-attachments '(' "$1" ')'
    exit $?
fi

/usr/bin/mkvmerge --ui-language en_US --output "$3" --no-audio  '(' "$2" ')' --no-video --no-subtitles --no-attachments '(' "$1" ')'
