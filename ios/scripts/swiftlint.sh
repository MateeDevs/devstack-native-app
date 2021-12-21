#!/bin/zsh -l

echo "Running SwiftLint"
mint run swiftlint autocorrect --config .swiftlint.yml
mint run swiftlint --config .swiftlint.yml
