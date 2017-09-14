#!/usr/bin/env bash

#https://www.reddit.com/r/mylittlelinux/comments/3s616r/embedded_terminal_shown_working_instructions_in/

# xfce4-terminal --hide-borders --hide-toolbar --hide-menubar --title=desktopconsole --geometry=130x44+0+0 &
xfce4-terminal --hide-borders --hide-toolbar --hide-menubar --title=desktopconsole --fullscreen &
sleep 3
wmctrl -r desktopconsole -b add,below,sticky
wmctrl -r desktopconsole -b add,skip_taskbar,skip_pager

