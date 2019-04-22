#!/bin/sh
DRIVER_NAME="ruby"
VERSION="0.1.3"
BASE_URL="https://raw.githubusercontent.com/summonbin/ruby"


###################
#### Arguments ####
###################

INSTALL_PATH=$1
SCHEME_PATH=$2
DEFAULT_CACHE_PATH=$3


######################
#### Build driver ####
######################

mkdir -p "$INSTALL_PATH/$DRIVER_NAME"
curl -L "$BASE_URL/$VERSION/scripts/setup.sh" -o "$INSTALL_PATH/$DRIVER_NAME/setup.sh"
curl -L "$BASE_URL/$VERSION/scripts/ruby.sh" -o "$INSTALL_PATH/$DRIVER_NAME/ruby.sh"
curl -L "$BASE_URL/$VERSION/scripts/run.sh" -o "$INSTALL_PATH/$DRIVER_NAME/run.sh"


######################
#### Build scheme ####
######################

mkdir -p "$SCHEME_PATH/$DRIVER_NAME/rbenv"
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/rbenv/cache" ]
then
  echo "$DEFAULT_CACHE_PATH/$DRIVER_NAME/rbenv" > "$SCHEME_PATH/$DRIVER_NAME/rbenv/cache"
fi
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/rbenv/version" ]
then
  echo "v1.1.2" > "$SCHEME_PATH/$DRIVER_NAME/rbenv/version"
fi

mkdir -p "$SCHEME_PATH/$DRIVER_NAME/bundler"
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/bundler/cache" ]
then
  echo "$DEFAULT_CACHE_PATH/$DRIVER_NAME/bundler" > "$SCHEME_PATH/$DRIVER_NAME/bundler/cache"
fi
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/bundler/version" ]
then
  echo "v2.0.1" > "$SCHEME_PATH/$DRIVER_NAME/bundler/version"
fi

mkdir -p "$SCHEME_PATH/$DRIVER_NAME/gem"
if [ ! -f "$SCHEME_PATH/$DRIVER_NAME/gem/cache" ]
then
  echo "$DEFAULT_CACHE_PATH/$DRIVER_NAME/gem" > "$SCHEME_PATH/$DRIVER_NAME/gem/cache"
fi
