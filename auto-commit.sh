#!/bin/bash

#
# change configuration to yourself
#
# 'You have to login your git account already, for security!'
#
GIT_REPOSITORY=https://github.com/1194117884/auto-commit.git

# cron configuration
CRON='*/1 * * * *'

# temp
TEMP_FOLDER=/tmp/git-repository-temp
TEMP_FILE=temp.log
	

# git
if [ `command -v git | wc -l` = 0 ];
then
  echo 'command "git" not found!';
  exit 1; #todo: change this exit to auto install 'git'
fi

#cron
if [ `command -v crontab | wc -l` = 0 ];
then
  echo 'command "crontab" not found!';
  exit 1; #todo: change this exit to auto install 'crontab'
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


# cron
crontab -l > /tmp/old.cron
echo "${CRON} sh ${TEMP_FOLDER}/auto-commit.sh" >> /tmp/old.cron
crontab /tmp/old.cron
rm -rf /tmp/old.cron

exit 0