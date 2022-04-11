#!bash/usr/bin/bash

shopt -s autocd
# Move a specific file(s) from subdirectories
find ./ -type f -iname "*.txt" -exec mv --backup=numbered -t . {} +
