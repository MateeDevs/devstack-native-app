#!/bin/bash

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

echo "⚙️  Checking file header"
if [ ! -f ../DevStack.xcworkspace/xcuserdata/`whoami`.xcuserdatad/IDETemplateMacros.plist ]; then
  echo "❌ File header is not set - setting now"
  echo -n "Enter your full name: "
  read fullname
  mkdir -p ../DevStack.xcworkspace/xcuserdata/`whoami`.xcuserdatad
  cp IDETemplateMacros.plist ../DevStack.xcworkspace/xcuserdata/`whoami`.xcuserdatad/
  sed -i "" -e "s/___FULLNAME___/$fullname/g" ../DevStack.xcworkspace/xcuserdata/`whoami`.xcuserdatad/IDETemplateMacros.plist
else
  echo "✅ File header is properly set"
fi

if [ ! -f ../../shared/core/src/commonMain/resources/MR/base/strings.xml ]; then
  echo "⚙️  Building Moko error strings for the first time"
  ./generate-error-messages.sh
fi

if [ ! -d ../DomainLayer/KMPShared.xcframework ]; then
  echo "⚙️  Building KMP for the first time"
  ./build-kmp.sh
fi

echo "⚙️  Downloading GraphQL schemas and generating code from queries"
./apollo.sh

echo "⚙️  Checking whether Twine is installed"
if command -v twine &> /dev/null; then
  echo "✅ Twine is installed"
else
  echo "❌ Twine is not installed"
  echo "Check https://github.com/MateeDevs/wiki/blob/master/tooling/ruby.md for more info"
fi
