#!/bin/bash

#
# change configuration to yourself
#
# 'You have to login your git account already, for security!'
#
ROLLING_FILE=temp.log

# this command only working in you git repository
GIT_REPOSITORY=`git config --get remote.origin.url`

# checkout
git checkout * 
git pull

# change and push
touch $ROLLING_FILE
echo $(date +%Y-%m-%d_%H:%M:%S) > $ROLLING_FILE
git add $ROLLING_FILE
git commit -m 'auto commit'
git push


exit 0