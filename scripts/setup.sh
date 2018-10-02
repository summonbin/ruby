#!/bin/sh
####################
#### Dependency ####
####################
RBENV_REPO_URL="https://github.com/rbenv/rbenv"
RUBY_BUILD_REPO_URL="https://github.com/rbenv/ruby-build"
BUNDLER_REPO_URL="https://github.com/bundler/bundler"


###################
#### Arguments ####
###################

CONFIG_DIR=$1
TARGET_RUBY_VERSION=$2


#####################
#### Read config ####
#####################

RBENV_CACHE_DIR=$(<"$CONFIG_DIR/rbenv/cache")
RBENV_VERSION=$(<"$CONFIG_DIR/rbenv/version")
BUNDLER_CACHE_DIR=$(<"$CONFIG_DIR/bundler/cache")
BUNDLER_VERSION=$(<"$CONFIG_DIR/bundler/version")
GEM_CACHE_DIR=$(<"$CONFIG_DIR/gem/cache")


##############################
#### Check version system ####
##############################

if [ "$TARGET_RUBY_VERSION" = "system" ]
then
  return
fi


####################
#### Setup rbenv ###
####################

RBENV_DIR="$RBENV_CACHE_DIR/$RBENV_VERSION"
RBENV_BIN="$RBENV_DIR/bin"

# Clone rbenv
if [ ! -d "$RBENV_BIN" ]
then
  rm -rf "$RBENV_DIR"
  git clone "$RBENV_REPO_URL" "$RBENV_DIR" -b "$RBENV_VERSION" --single-branch --depth 1
fi

RUBY_BUILD_DIR="$RBENV_DIR/plugins/ruby-build"
RUBY_BUILD_BIN="$RUBY_BUILD_DIR/bin"

# Clone ruby-build
if [ ! -d "$RUBY_BUILD_BIN" ]
then
  rm -rf "$RUBY_BUILD_DIR"
  git clone "$RUBY_BUILD_REPO_URL" "$RUBY_BUILD_DIR" --single-branch --depth 1
fi

# Setup env
export PATH="$RBENV_BIN:$PATH"
export PATH="$RBENV_BIN/rbenv/shims:$PATH"
export PATH="$RBENV_DIR/plugins/ruby-build/bin:$PATH"
export RBENV_ROOT="$RBENV_DIR"
eval "$(rbenv init -)"

# Set Ruby version
if ! [ -d "$RBENV_DIR/versions/$TARGET_RUBY_VERSION" ]
then
  rbenv install "$TARGET_RUBY_VERSION"
fi
export RBENV_VERSION="$TARGET_RUBY_VERSION"


#######################
#### Setup Bundler ####
#######################

BUNDLER_DIR="$BUNDLER_CACHE_DIR/$BUNDLER_VERSION"
BUNDLER_BIN="$BUNDLER_DIR/bin"

# Clone bundler
if [ ! -d "$BUNDLER_BIN" ]
then
  rm -rf "$BUNDLER_DIR"
  git clone "$BUNDLER_REPO_URL" "$BUNDLER_DIR" --single-branch --depth 1
fi

# Setup bundler
mkdir -p "$GEM_CACHE_DIR"
export PATH="$BUNDLER_BIN:$PATH"
export GEM_HOME="$GEM_CACHE_DIR"
export GEM_PATH="$GEM_CACHE_DIR"
export BUNDLE_PATH="$GEM_CACHE_DIR"
