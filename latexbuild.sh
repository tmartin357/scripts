#!/usr/bin/env bash

aspell check $1
pdflatex $1
evince ${1/".tex"/".pdf"} 2>/dev/null &
