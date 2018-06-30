#!/bin/sh
DRIVER_NAME="ruby"
VERSION="0.1.0"
BASE_URL="https://raw.githubusercontent.com/summonbin/ruby"


###################
#### Arguments ####
###################

INSTALL_PATH=$1
SCHEME_PATH=$2


######################
#### Build driver ####
######################

mkdir -p $INSTALL_PATH/$DRIVER_NAME
curl -L "$BASE_URL/$VERSION/scripts/setup.sh" -o "$INSTALL_PATH/$DRIVER_NAME/setup.sh"
curl -L "$BASE_URL/$VERSION/scripts/ruby.sh" -o "$INSTALL_PATH/$DRIVER_NAME/ruby.sh"
curl -L "$BASE_URL/$VERSION/scripts/run.sh" -o "$INSTALL_PATH/$DRIVER_NAME/run.sh"


######################
#### Build scheme ####
######################

mkdir -p $SCHEME_PATH/$DRIVER_NAME/rbenv
echo "$INSTALL_PATH/cache/$DRIVER_NAME/rbenv" > $SCHEME_PATH/$DRIVER_NAME/rbenv/cache
echo "v1.1.1" > $SCHEME_PATH/$DRIVER_NAME/rbenv/version

mkdir -p $SCHEME_PATH/$DRIVER_NAME/bundler
echo "$INSTALL_PATH/cache/$DRIVER_NAME/bundler" > $SCHEME_PATH/$DRIVER_NAME/bundler/cache
echo "v1.16.2" > $SCHEME_PATH/$DRIVER_NAME/bundler/version

mkdir -p $SCHEME_PATH/$DRIVER_NAME/gem
echo "$INSTALL_PATH/cache/$DRIVER_NAME/gem" > $SCHEME_PATH/$DRIVER_NAME/gem/cache
