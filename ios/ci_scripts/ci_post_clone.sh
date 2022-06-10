#!/bin/zsh -l

cd ..

brew install openjdk@11
export JAVA_HOME=$(/Users/local/Homebrew/opt/openjdk@11/libexec/java_home -v 11)

./scripts/setup.sh
./scripts/build-kmp.sh
