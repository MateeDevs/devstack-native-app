#!/bin/bash

# This ensures that relative paths are correct no matter where the script is executed
cd "$(dirname "$0")"

echo "⚙️  SharedDomain - Generating mocks for UseCases and Repositories"
cd ../DomainLayer/SharedDomain
swift package --disable-sandbox --allow-writing-to-package-directory sourcery-command --sources "../DomainLayer/SharedDomain"
cd ../..
