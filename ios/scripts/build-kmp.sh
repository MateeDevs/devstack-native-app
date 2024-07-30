#!/bin/zsh -l

set -e

#
# First argument  - XCODE_CONFIGURATION: debug / release
# Second argument - X86: true / false
# Third argument  - ARM64: true / false
# Fourth argument - ARM64SIM: true / false
#
# The last two arguments can be emitted while building with XCode. It is automatically detected
# whether the destination is a simulator or not.
#
# Example:
# ./scripts/build-kmp.sh debug false true true      -> debug configuration with arm64 + arm64sim architectures (local builds) - default
# ./scripts/build-kmp.sh debug true false false     -> debug configuration with x86 architecture (tests on Intel based CI)
# ./scripts/build-kmp.sh release false true false   -> release configuration with arm64 architecture (TestFlight/AppStore builds)
# ./scripts/build-kmp.sh release false              -> release configuration without x86 architecture and simulator or arm detected automatically
#

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

# Read input arguments
configuration=${1:-debug}
x86=${2:-false}
arm64=$3
arm64sim=$4

# Check if arm64 argument is blank
if [ -z "$arm64" ]; then
  if [ -z "$__IS_NOT_SIMULATOR" ] || [ "$__IS_NOT_SIMULATOR" = "YES" ]; then
    arm64=true
  else
    arm64=false
  fi
fi

# Check if arm64sim argument is blank
if [ -z "$arm64sim" ]; then
  if [ -z "$__IS_NOT_SIMULATOR" ] || [ "$__IS_NOT_SIMULATOR" = "NO" ]; then
    arm64sim=true
  else
    arm64sim=false
  fi
fi

# Build and copy XCFramework
cd ../..
./gradlew :shared:core:buildXCFramework -PXCODE_CONFIGURATION=${configuration} -PX86=${x86} -PARM64=${arm64} -PARM64SIM=${arm64sim}
./gradlew :shared:core:copyXCFramework -PXCODE_CONFIGURATION=${configuration} -PX86=${x86} -PARM64=${arm64} -PARM64SIM=${arm64sim}
