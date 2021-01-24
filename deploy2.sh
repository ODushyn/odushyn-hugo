#!/bin/sh

@echo off
echo "Deploying updates to GitHub..."

if [[ "$1" != "" ]]; then
    msg="$1"
else
    msg="Message for commit: "
fi

# Build the project.
# if using a theme, replace by `hugo -t <yourtheme>`
hugo

# Go To Public folder
cd public
# Add changes to git.
git add -A

# Commit changes.
git commit -m "%msg%"

# Push source and build repos.
git push -u origin master

# Come Back
cd..