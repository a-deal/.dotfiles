#!/usr/bin/env bash

languages=`echo "typescript javascript bash python" | tr " " "\n"`
core_utils=`echo "find xargs sed awk" | tr " " "\n"`
selected=`echo -e "$languages\n$core_utils" | fzf`

read -p "Query: " query

if echo "$languages" | grep -qs $selected; then
    tmux split-window -h -p 33 bash -c "curl cht.sh/$selected/`echo "$query" | tr " " "+"` | less"
else
    tmux split-window -h -p 33 bash -c "curl cht.sh/$selected~$query | less"
fi

