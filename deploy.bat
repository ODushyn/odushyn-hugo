@echo off
echo "Deploying updates to GitHub..."

set /p msg="Message for commit: "

:: Build the project.
:: if using a theme, replace by `hugo -t <yourtheme>`
:: call d:\hugo\bin\hugo
call hugo

:: Go To Public folder
cd public
:: Add changes to git.
call git add -A

:: Commit changes.
if not defined msg (
  set msg="rebuilding site %date%"
)
  
call git commit -m "%msg%"

:: Push source and build repos.
call git push -u origin master

:: Come Back
cd..