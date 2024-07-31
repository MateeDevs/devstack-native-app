#!/bin/zsh -l

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

cd ../..

echo "Generating Localizable files for error messages in specified languages"
./gradlew generateErrorsTwine

echo "Generating MR resources from .xml files"
./gradlew :shared:base:generateMRcommonMain