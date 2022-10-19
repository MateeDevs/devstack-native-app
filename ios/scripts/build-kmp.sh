#!/bin/zsh -l

# First argument  - XCODE_CONFIGURATION : DEBUG/RELEASE
# Second argument - ARM64_ONLY : true/false
# Script with no arguments use default values - XCODE_CONFIGURATION: RELEASE, ARM64_ONLY: false
# Sample:
#       ./scripts/build-kmp.sh                -> optimised release build with arm64, x64, simulator
#       ./scripts/build-kmp.sh release true   -> optimised release build with only arm64
#       ./scripts/build-kmp.sh release false  -> optimised release build with arm64, x64, simulator
#       ./scripts/build-kmp.sh debug true     -> debug build with only arm64
#       ./scripts/build-kmp.sh debug false    -> debug build with arm64, x64, simulator

cd ..

configuration=$1
arm64only=$2

./gradlew :shared:buildXCFramework -PXCODE_CONFIGURATION=${configuration} -PARM64_ONLY=${arm64only} && ./gradlew :shared:copyXCFramework -PXCODE_CONFIGURATION=${configuration} -PARM64_ONLY=${arm64only}
