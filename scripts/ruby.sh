#!/bin/sh
###################
#### Arguments ####
###################

BASE_DIR=$(dirname "$0")
CONFIG_DIR=$1
TARGET_RUBY_VERSION=$2

# Arguments for bin
BIN_ARGS=()

for i
do
  BIN_ARGS+=(\"${i}\")
done

unset BIN_ARGS[0]
unset BIN_ARGS[1]
BIN_ARGS=${BIN_ARGS[@]}


####################
#### Setup Ruby ####
####################

source "$BASE_DIR/setup.sh" "$CONFIG_DIR" "$TARGET_RUBY_VERSION"


######################
#### Execute ruby ####
######################

if [ -t 1 ]
then
  ruby $BIN_ARGS < /dev/tty
else
  ruby $BIN_ARGS
fi
