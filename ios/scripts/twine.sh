#!/bin/zsh -l

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

echo "⚙️  Generating Localizable files for specified languages"
mkdir ${DERIVED_SOURCES_DIR}/Base.lproj
twine generate-localization-file ../../twine/strings.txt ${DERIVED_SOURCES_DIR}/Base.lproj/Localizable.strings --lang en
mkdir ${DERIVED_SOURCES_DIR}/cs.lproj
twine generate-localization-file ../../twine/strings.txt ${DERIVED_SOURCES_DIR}/cs.lproj/Localizable.strings --lang cs
mkdir ${DERIVED_SOURCES_DIR}/sk.lproj
twine generate-localization-file ../../twine/strings.txt ${DERIVED_SOURCES_DIR}/sk.lproj/Localizable.strings --lang sk
mkdir ${DERIVED_SOURCES_DIR}/en.lproj
twine generate-localization-file ../../twine/strings.txt ${DERIVED_SOURCES_DIR}/en.lproj/Localizable.strings --lang en
