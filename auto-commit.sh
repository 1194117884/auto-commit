#!/bin/bash

#
# change configuration to yourself
#
# 'You have to login your git account already, for security!'
#
TEMP_FOLDER=/tmp/git-repository-temp
ROLLING_FILE=temp.log

# git check
if [ `command -v git | wc -l` = 0 ];
then
  echo 'command "git" not found! try to install';

  #centos
  if [ `command -v yum | wc -l` = 1 ];
  then
  	yum -y install git
  fi

  #ubuntu
  if [ `command -v apt-get | wc -l` = 1 ];
  then
  	apt-get -y install git
  fi

  #macos
  if [ `command -v brew | wc -l` = 1 ];
  then
  	brew install -f git
  fi

fi

# this command only working in you git repository
GIT_REPOSITORY=`git remote get-url --all origin`

# clone
git clone $GIT_REPOSITORY $TEMP_FOLDER> /dev/null || echo 'repository exists! goto next step!'
cd $TEMP_FOLDER

# checkout
git checkout * 
git pull

# change and push
touch $ROLLING_FILE
echo $(date +%Y-%m-%d_%H:%M:%S) > $ROLLING_FILE
git add $ROLLING_FILE
git commit -m 'auto commit'
git push

# clear temp
rm -rf $TEMP_FOLDER

exit 0