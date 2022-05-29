#!/bin/zsh -l

echo "Generating identifiers for Colors and Images"
mint run swiftgen run xcassets "PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Colors.xcassets" "PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Images.xcassets" -p "scripts/swiftgen-xcassets.stencil" --param publicAccess --output "PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Constants/Assets.swift"

echo "Generating identifiers for Localizable"
mint run swiftgen run strings "PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Localizable/Base.lproj/Localizable.strings" -p "scripts/swiftgen-strings.stencil" --param publicAccess --output "PresentationLayer/UIToolkit/Sources/UIToolkit/Resources/Constants/Localizable.swift"
