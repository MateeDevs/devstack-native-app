#!/bin/zsh -l

echo "Generating identifiers for Colors and Images"
mint run swiftgen run xcassets "PresentationLayer/Sources/PresentationLayer/Resources/Colors.xcassets" "PresentationLayer/Sources/PresentationLayer/Resources/Images.xcassets" -p "scripts/swiftgen-xcassets.stencil" --param publicAccess --output "PresentationLayer/Sources/PresentationLayer/Resources/Constants/Assets.swift"

echo "Generating identifiers for Localizable"
mint run swiftgen run strings "PresentationLayer/Sources/PresentationLayer/Resources/Localizable/Base.lproj/Localizable.strings" -p "scripts/swiftgen-strings.stencil" --param publicAccess --output "PresentationLayer/Sources/PresentationLayer/Resources/Constants/Localizable.swift"

echo "Generating identifiers for Storyboards"
mint run swiftgen run ib "PresentationLayer" -p "scripts/swiftgen-ib.stencil" --output "PresentationLayer/Sources/PresentationLayer/Resources/Constants/Storyboards.swift"
