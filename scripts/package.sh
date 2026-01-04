#!/usr/bin/env bash
# Install or remove Typst package in TARGET namespace, or check if it is already installed.
# Usage: package [ACTION] [TARGET] [PROJECT-ROOT]

# Find system data dir
if [[ "$OSTYPE" == "linux"* ]]; then
  DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  DATA_DIR="$HOME/Library/Application Support"
else
  DATA_DIR="${APPDATA}"
fi

ACTION="$1"
TARGET="$2"
PROJECT_ROOT="${3:-..}"
NAME=`grep '^name' "${PROJECT_ROOT}/typst.toml" | cut -d'"' -f2`
VERSION=`grep '^version' "${PROJECT_ROOT}/typst.toml" | cut -d'"' -f2`


# Disable dev-link "0.0.0" version"
if [[ "${VERSION}" == "0.0.0" ]]; then
  echo "Development link activated. Removing it..."
  bash "${PROJECT_ROOT}/scripts/dev-link.sh"
  
  VERSION=`grep '^version' "${PROJECT_ROOT}/typst.toml" | cut -d'"' -f2`
fi


# Target fallback and check
case "$TARGET" in
  "local"|"preview"|"pkg") ;;
  "") TARGET="preview" ;;
  *)
    echo "Invalid target: \"$1\""
    echo "USAGE: $0 [ACTION] [TARGET] [PROJECT-ROOT]"
    exit 1
    ;;
esac


# Action "check" for preview installation
if [[ "${ACTION}" == "check" ]]; then
  # Check if package is installed in "preview" namespace
  if [[ -d "${DATA_DIR}/typst/packages/${TARGET}/${NAME}" ]]; then
    echo "Package \"@${TARGET}/${NAME}:${VERSION}\" already installed."
    exit 0
  else
    bash $0 install "${TARGET}" "${PROJECT_ROOT}"
    exit $?
  fi
fi


# Root directory check
if [[ ! -d "${PROJECT_ROOT}" ]]; then
  echo "Directory not found: \"${PROJECT_ROOT}\""
fi


# Installation path
LIB_DIR="${DATA_DIR}/typst/packages/${TARGET}/${NAME}"


# Install or remove package:
case "${ACTION}" in
  "install")
    echo "Installing \"@${TARGET}/${NAME}:${VERSION}\" package..."
    mkdir -p "${LIB_DIR}" 2>/dev/null
    rm -r "${LIB_DIR}/${VERSION}" 2>/dev/null
    # Copy all package files to its path:
    cp -r "${PROJECT_ROOT}" "${LIB_DIR}/${VERSION}"
    [[ $? != 0 ]] && exit $?
    
    EXCLUDES=()
    IFS=$'\n'
    
    while read -r linha; do
        EXCLUDES+=("$linha")
    done < <(
      perl -00 -ne \
        'if (/\s*exclude\s*=\s*\[(.*?)\]/s) {
          my @values = $1 =~ /"([^"]+)"/g;
          print "$_\n" for @values
        }' \
        "${PROJECT_ROOT}/typst.toml"
    )
    
    # Remove files and directories excluded in typst.toml:
    if [[ ${#EXCLUDES[@]} -ne 0 ]]; then
      echo "Removing excluded paths:"
      cd "${LIB_DIR}/${VERSION}"

      for EXCLUDE in ${EXCLUDES[@]}; do
        if [[ -e "${EXCLUDE}" ]]; then
          rm -r "${EXCLUDE}"
          echo " - Removed: ${EXCLUDE}"
        else
          echo " - Does not exist: ${EXCLUDE}"
        fi
      done
    fi
    
    # Move installed package to project
    if [[ "${TARGET}" == "pkg" ]]; then
      echo "Moving files to: \"dev/pkg\""
      rm -r  "${PROJECT_ROOT}/dev/pkg"
      mkdir -p "${PROJECT_ROOT}/dev/pkg"
      mv "${DATA_DIR}/typst/packages/pkg/" "${PROJECT_ROOT}/dev/"
      
      if [[ $? == 0 ]]; then
        echo "Package available in \"dev/pkg\""
      else
        echo "Could not move files. Aborting..."
        exit $?
      fi
    fi
    ;;
    
  "remove")
    echo "Removing \"@${TARGET}/${NAME}\" package (all versions)..."
    # Remove package directory:
    rm -r "${LIB_DIR}" 2>/dev/null
    if [[ $? == 0 ]]; then
      echo "Package \"@${TARGET}/${NAME}\" removed."
    else
      echo "Package \"@${TARGET}/${NAME}\" not found"
    fi
    ;;
    
  *)
    echo "Invalid action: \"${ACTION}\""
    echo "USAGE: $0 [ACTION] [TARGET] [PROJECT-ROOT]"
    exit 1
    ;;
    
esac
