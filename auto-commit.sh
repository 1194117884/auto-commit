#!/bin/bash

#
# change configuration to yourself
#
# 'You have to login your git account already, for security!'
#
GIT_REPOSITORY=https://github.com/1194117884/auto-commit.git

# temp
TEMP_FOLDER=/tmp/git-repository-temp
TEMP_FILE=temp.log
	

# git
if [ `command -v git | wc -l` = 0 ];
then
  echo 'command "git" not found!';
  exit 1; #todo: change this exit to auto install 'git'
fi

# clone
git clone $GIT_REPOSITORY $TEMP_FOLDER> /dev/null || echo 'repository exists! goto next step!'
cd $TEMP_FOLDER

# checkout
git checkout * 
git pull

# change and push
touch $TEMP_FILE
echo $(date +%Y-%m-%d_%H:%M:%S) >> $TEMP_FILE
git add $TEMP_FILE
git commit -m 'auto commit'
git push

# clear temp
rm -rf $TEMP_FOLDER

exit 0