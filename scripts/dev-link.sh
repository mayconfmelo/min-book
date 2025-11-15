#!/usr/local/env bash
# DESC: Symlink Typst project in ../ to DATA-DIR/typst/package/local/
# USAGE: dev-link [PROJECT-ROOT]

# Find system data dir
if [[ "$OSTYPE" == "linux"* ]]; then
  DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  DATA_DIR="$HOME/Library/Application Support"
else
  DATA_DIR="${APPDATA}"
fi

PROJECT_ROOT="${1:-$PWD}"
DEL=${2:-true}
TARGET=${3:-preview}
NAME=`grep '^name' "${PROJECT_ROOT}/typst.toml" | cut -d'"' -f2`
VERSION="0.0.0"
DIR="${DATA_DIR}/typst/packages/${TARGET}/${NAME}"
TYP_FILES=( `find . -type f -iname "*.typ"` )


# Check project root
if [[ -d "${PROJECT_ROOT}" ]]; then
  cd "${PROJECT_ROOT}"
else
  echo "Directory not found: \"${PROJECT_ROOT}\""
  exit 1
fi


if [[ -d "$DIR/$VERSION" ]]; then
  # Disable removal
  if [[ $DEL != true ]]; then
    exit 0
  fi
  
  echo "Deleting \"@$TARGET/$NAME:$VERSION\" symlink..."
  rm "$DIR/$VERSION" 2>/dev/null || true
  perl -i -pe 's/^(\s*version\s*=\s*).*?#(.*)/$1$2/' typst.toml
  echo "Finished \"@$TARGET/$NAME:$VERSION\" removal."
  
  VERSION=`grep '^version' "$PROJECT_ROOT/typst.toml" | cut -d'"' -f2`
else
  echo "Creating \"@$TARGET/$NAME:$VERSION\" symlink..."
  mkdir "$DIR" 2>/dev/null || true
  ln -s "$PROJECT_ROOT" "$DIR/$VERSION"
  perl -i -pe 's/^(\s*version\s*=\s*)(.*)/$1"0.0.0" #$2/' typst.toml
  echo "Symlink creation finished"
fi


if [[ ${TYP_FILES[@]} != 0 ]]; then
  echo "Updating version number in Typst files..."
  for file in ${TYP_FILES[@]}; do
    sed -i "s/$NAME:[0-9.]\+/$NAME:$VERSION/" "$file"
  done
fi