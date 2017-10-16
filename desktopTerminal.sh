#!/usr/bin/env bash

#https://www.reddit.com/r/mylittlelinux/comments/3s616r/embedded_terminal_shown_working_instructions_in/

# xfce4-terminal --hide-borders --hide-toolbar --hide-menubar --title=desktopconsole --geometry=130x44+0+0 &

if ! wmctrl -a desktopconsole ; then
  xfce4-terminal --hide-borders --hide-toolbar --hide-menubar --title=desktopconsole --fullscreen &
  sleep 1
  wmctrl -r desktopconsole -b add,below,sticky
  wmctrl -r desktopconsole -b add,skip_taskbar,skip_pager
else 
  #it is already running
  wmctrl -r desktopconsole -b toggle,below
  wmctrl -r desktopconsole -b toggle,skip_taskbar,skip_pager
  wmctrl -a desktopconsole
fi
