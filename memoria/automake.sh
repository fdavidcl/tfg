#!/bin/bash

while true; do
    inotifywait -e close_write,moved_to,create chapters
     
    make
done