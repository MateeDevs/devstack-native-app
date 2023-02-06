#!/bin/bash

cd "$(dirname "$0")"

# SharedDomain
cd ../DomainLayer/SharedDomain
swift package --allow-writing-to-package-directory sourcery-command
cd ../..
