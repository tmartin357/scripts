#!/usr/bin/env bash

#set -x

curl -X POST -H "Content-Type: application/json" \ #-d '{"value1":"'"$1"'"}' \
https://maker.ifttt.com/trigger/xubuntu/with/key/fsLLrdn0HJHgXNjWl1_Nuz2q4OEiFvrzj0O5POBFS_k

echo ""
