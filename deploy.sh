#!/bin/bash

set -e

if [ $# -eq 0 ]; then
    echo "Error: provide a commit message"
    exit 1
fi

if ! git diff-index --quiet HEAD; then
   echo "Error: local changes not committed"
   exit 1
fi

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

hugo

cd public

if git diff-index --quiet HEAD; then
    printf "\033[0;32mNo changes\033[0m\n"
else
    git add .
    git commit -m "$*"
    git push origin master
    printf "\033[0;32mDone\033[0m\n"
fi
