#!/bin/bash
red="\033[31m"
green="\033[0;32m"
nocolor="\033[0m"
echo -e "${green}Deploying updates to GitHub...${nocolor}"

# Defines commit message.
if [ $# -eq 1 ]
then
 msg="$1"
else
  echo -e "${red}Error: commit message cannot be null.${nocolor}"
  exit 1
fi

# Builds the project.
hugo

# Commits source files.
echo -e "${green}Committing source files...${nocolor}"
git add .
git commit -m "${msg}"
git push origin main 


# Go To Public folder.
cd public

# Commits public folder
echo -e "${green}Committing public folder...${nocolor}"
git add .
git commit -m "${msg}"
git push origin main 

# Come Back up to the Project Root
cd ..
echo -e "${green}Done!${nocolor}" 