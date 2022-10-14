#!/bin/bash

cd "$(dirname "$0")"
cd ../DataLayer/Providers/GraphQLProvider

echo "⚙️  RocketToolkit - Downloading GraphQL schema and generating code from queries"
swift package --disable-sandbox --allow-writing-to-package-directory apollo-fetch-schema --path "../../Toolkits/RocketToolkit/apollo-codegen-config.json"
swift package --disable-sandbox --allow-writing-to-package-directory apollo-generate --path "../../Toolkits/RocketToolkit/apollo-codegen-config.json"
