#!/bin/bash

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

echo "⚙️  RocketToolkit - Downloading GraphQL schema and generating code from queries"
swift package --disable-sandbox --allow-writing-to-package-directory apollo-fetch-schema --path "../DataLayer/Toolkits/RocketToolkit/apollo-codegen-config.json"
swift package --disable-sandbox --allow-writing-to-package-directory apollo-generate --path "../DataLayer/Toolkits/RocketToolkit/apollo-codegen-config.json"
