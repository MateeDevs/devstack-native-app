#!/bin/zsh -l

cd ..
./gradlew buildXCFramework -PXCODE_CONFIGURATION=${CONFIGURATION}
