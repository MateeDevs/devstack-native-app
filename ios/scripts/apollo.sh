#!/bin/bash

cd "$(dirname "$0")"
cd ../DataLayer/Providers/GraphQLProvider

# RocketToolkit
swift package --disable-sandbox --allow-writing-to-package-directory apollo-fetch-schema --path "../../Toolkits/RocketToolkit/apollo-codegen-config.json"
swift package --disable-sandbox --allow-writing-to-package-directory apollo-generate --path "../../Toolkits/RocketToolkit/apollo-codegen-config.json"
find ../../Toolkits/RocketToolkit/Sources/RocketToolkitMocks -type f -exec sed -i '' -e "s/rocket/Rocket/g" {} +
