#!/bin/zsh -l

# Don't run this during index builds
if [ $ACTION = "indexbuild" ]; then exit 0; fi

# Go to the build root and search up the chain to find the Derived Data Path where the source packages are checked out.
DERIVED_DATA_CANDIDATE="${BUILD_ROOT}"

while ! [ -d "${DERIVED_DATA_CANDIDATE}/SourcePackages" ]; do
  if [ "${DERIVED_DATA_CANDIDATE}" = / ]; then
    echo >&2 "error: Unable to locate SourcePackages directory from BUILD_ROOT: '${BUILD_ROOT}'"
    exit 1
  fi

  DERIVED_DATA_CANDIDATE="$(dirname "${DERIVED_DATA_CANDIDATE}")"
done

# Grab a reference to the directory where scripts are checked out
SCRIPT_PATH="${DERIVED_DATA_CANDIDATE}/SourcePackages/checkouts/apollo-ios/scripts"

if [ -z "${SCRIPT_PATH}" ]; then
    echo >&2 "error: Couldn't find the CLI script in your checked out SPM packages; make sure to add the framework to your project."
    exit 1
fi

cd "${SRCROOT}"

# Download GraphQL schema
#"${SCRIPT_PATH}"/run-bundled-codegen.sh schema:download --endpoint="https://apollo-fullstack-tutorial.herokuapp.com/graphql" "./DataLayer/schema.json"

# Generate code from queries
"${SCRIPT_PATH}"/run-bundled-codegen.sh codegen:generate --target=swift --includes="./DataLayer/Toolkits/RocketToolkit/Sources/RocketToolkit/NetworkQueries/*.graphql" --localSchemaFile="./DataLayer/schema.json" "./DataLayer/Toolkits/RocketToolkit/Sources/RocketToolkit/NetworkModels/NETModels.generated.swift"
