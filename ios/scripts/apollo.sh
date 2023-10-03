#!/bin/bash

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

cd ../DataLayer/Providers/GraphQLProvider

echo "⚙️  GraphQLProvider - Installing Codegen CLI"
swift package --allow-writing-to-package-directory apollo-cli-install

echo "⚙️  RocketToolkit - Downloading GraphQL schema and generating code from queries"
./apollo-ios-cli fetch-schema --path "../../Toolkits/RocketToolkit/apollo-codegen-config.json"
./apollo-ios-cli generate --path "../../Toolkits/RocketToolkit/apollo-codegen-config.json"

cd ../../..
