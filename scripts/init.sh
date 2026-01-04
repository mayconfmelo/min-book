#!/usr/bin/env bash
# Initialize Typst template project.
# Usage: init [TARGET]

TARGET="$1"

# Get package name from typst.toml
NAME=$(
  perl \
    -ne "print \$1 if /^\s*name\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
    "typst.toml"
)
VERSION=$(
  perl \
    -ne "print \$1 if /^\s*version\s*=\s*[\"']?([^\"]*)[\"']?.*/g" \
    "typst.toml"
)

rm -r "dev/${NAME}" 2>/dev/null
mkdir "dev" 2>/dev/null
typst init "@${TARGET}/${NAME}:${VERSION}" "dev/${NAME}"
