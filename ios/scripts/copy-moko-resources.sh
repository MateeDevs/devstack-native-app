#!/bin/zsh -l

configurationWordCount=$(echo "$CONFIGURATION" | wc -w)
if (( configurationWordCount > 1 ))
then
  buildType=$(echo "$CONFIGURATION" | awk '{print $2}')
else
  buildType="$CONFIGURATION"
fi

# This is required step for DevstackKmpShared framework
# https://github.com/icerockdev/moko-resources#creating-xcframework-with-resources
"$SRCROOT/../gradlew" -p "$SRCROOT/../" :shared:copyResourcesDevstackKmpShared${buildType}XCFrameworkToApp \
    -Pmoko.resources.BUILT_PRODUCTS_DIR=$BUILT_PRODUCTS_DIR \
    -Pmoko.resources.CONTENTS_FOLDER_PATH=$CONTENTS_FOLDER_PATH \
    -PXCODE_CONFIGURATION="$CONFIGURATION"