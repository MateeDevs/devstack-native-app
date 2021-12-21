#!/bin/bash

cd "$(dirname "$0")"
cd ..

echo "Building project in order to obtain xcodebuild.log"
xcodebuild -workspace DevStack.xcworkspace -scheme DevStack_Alpha > xcodebuild.log

echo "Running SwiftLint Static Analyzer"
mint run swiftlint analyze --config .swiftlint.yml --compiler-log-path xcodebuild.log
