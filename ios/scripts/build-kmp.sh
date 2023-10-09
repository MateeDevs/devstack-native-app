#!/bin/zsh -l

#
# First argument  - XCODE_CONFIGURATION: debug / release
# Second argument - X86: true / false
# Third argument  - ARM64: true / false
# Fourth argument - ARM64SIM: true / false
#
# Example:
# ./scripts/build-kmp.sh debug false true true      -> debug configuration with arm64 + arm64sim architectures (local builds) - default
# ./scripts/build-kmp.sh debug true false false     -> debug configuration with x86 architecture (tests on Intel based CI)
# ./scripts/build-kmp.sh release false true false   -> release configuration with arm64 architecture (TestFlight/AppStore builds)
#

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

# Read input arguments
configuration=${1:-debug}
x86=${2:-false}
arm64=${3:-true}
arm64sim=${4:-true}

# Build and copy XCFramework
cd ../..
./gradlew :shared:buildXCFramework -PXCODE_CONFIGURATION=${configuration} -PX86=${x86} -PARM64=${arm64} -PARM64SIM=${arm64sim}
./gradlew :shared:copyXCFramework -PXCODE_CONFIGURATION=${configuration} -PX86=${x86} -PARM64=${arm64} -PARM64SIM=${arm64sim}
