#!/usr/local/env bash
# DESC: Add a version Git tag to the project
# USAGE: version [VERSION] [PROJECT-ROOT]

VERSION="$1"
PROJECT_ROOT="${2:-..}"
NAME=$(
  perl \
    -ne "print \$1 if /^\s*name\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
    "${PROJECT_ROOT}/typst.toml"
)
TYP_VERSION=$(
  perl \
    -ne "print \$1 if /^\s*version\s*=\s*[\"']?([^\"]*)[\"']?.*/g" \
    "${PROJECT_ROOT}/typst.toml"
)

if [[ "${VERSION}" != "${TYP_VERSION}" ]]; then
  echo "Version mismatch: ${TYP_VERSION} in typst.toml"
  exit 1
fi

# Check if version is SemVer:
if [[ ! "${VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version: ${VERSION}."
  echo "Must be a semantic version"
  exit 2
fi

# Check if tag already exists
if git rev-parse -q --verify "refs/tags/${VERSION}" >/dev/null; then
  echo "Error: The ${VERSION} tag already exists"
  exit 3
fi

cd "${PROJECT_ROOT}"

echo "Releasing version \"${VERSION}\""

echo "Updating links in \"README.md\"..."
sed -i "s/tags\/[0-9.]\+/tags\/${VERSION}/" "README.md"
sed -i "s/blob\/[0-9.]\+/blob\/${VERSION}/" "README.md"

SRC_CODE=(
  $(find . -type f -iname "*.typ" -o -iname "*.md")
)

echo "Checking version in Typst files..."
for file in ${SRC_CODE[@]}; do
  echo "   ${file}"
  sed -i "s/${NAME}:[0-9.]\+/${NAME}:${VERSION}/" "${file}"
done