#!/bin/zsh -l

cd "$SRCROOT/.."
./gradlew buildXCFramework -PXCODE_CONFIGURATION=${CONFIGURATION}
