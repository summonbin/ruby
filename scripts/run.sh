#!/bin/sh
###################
#### Arguments ####
###################

BASE_DIR=$(dirname "$0")
CONFIG_DIR=$1
BIN_NAME=$2
TARGET_RUBY_VERSION=$3

# Arguments for bin
BIN_ARGS=("$@")
unset BIN_ARGS[0]
unset BIN_ARGS[1]
unset BIN_ARGS[2]
BIN_ARGS=${BIN_ARGS[@]}


####################
#### Setup Ruby ####
####################

source $BASE_DIR/setup.sh $CONFIG_DIR $TARGET_RUBY_VERSION


#####################
#### Execute gem ####
#####################

bundle install
if [ -t 1 ]
then
  bundle exec $BIN_NAME $BIN_ARGS < /dev/tty
else
  bundle exec $BIN_NAME $BIN_ARGS
fi
