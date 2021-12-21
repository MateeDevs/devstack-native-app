#!/bin/bash

cd "$(dirname "$0")"

echo "Creating files for Twine and SwiftGen"
find ../PresentationLayer/Sources/PresentationLayer/Resources/Localizable/*.lproj -type d -exec sh -c 'touch $0/Localizable.strings' {} \;
touch ../PresentationLayer/Sources/PresentationLayer/Resources/Constants/Assets.swift
touch ../PresentationLayer/Sources/PresentationLayer/Resources/Constants/Localizable.swift
touch ../PresentationLayer/Sources/PresentationLayer/Resources/Constants/Storyboards.swift

echo "Checking file header"
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

echo "Checking whether Homebrew is installed"
if command -v brew &> /dev/null; then
  echo "✅ Homebrew is installed"
else
  echo "❌ Homebrew is not installed"
  echo "Please visit https://brew.sh for more info"
  exit
fi

echo "Checking whether Twine is installed"
if command -v twine &> /dev/null; then
  echo "✅ Twine is installed"
else
  echo "❌ Twine is not installed - installing now"
  gem install twine
fi

echo "Checking whether Mint is installed"
if command -v mint &> /dev/null; then
  echo "✅ Mint is installed"
else
  echo "❌ Mint is not installed - installing now"
  brew install mint
fi

echo "Bootstraping Mint dependencies"
cd ..
mint bootstrap
