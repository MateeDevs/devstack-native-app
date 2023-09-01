#!/bin/zsh -l

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

echo "⚙️  Generating Localizable files for specified languages"
twine generate-localization-file ../../twine/strings.txt ../PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Localizable/Base.lproj/Localizable.strings --lang en
twine generate-localization-file ../../twine/strings.txt ../PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Localizable/cs.lproj/Localizable.strings --lang cs
twine generate-localization-file ../../twine/strings.txt ../PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Localizable/sk.lproj/Localizable.strings --lang sk
twine generate-localization-file ../../twine/strings.txt ../PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Localizable/en.lproj/Localizable.strings --lang en
