root := justfile_directory()
name := `grep '^name' typst.toml | cut -d'"' -f2`
version := `grep '^version' typst.toml | cut -d'"' -f2`
example := "template/main.typ"
doc := "manual.typ"

[private]
default:
	@just --list --unsorted

# install package.
install target="preview":
  bash scripts/package.sh install "{{target}}" "{{root}}"
  
# remove package.
remove target="preview":
  bash scripts/package.sh remove "{{target}}" "{{root}}"
  
# run package tests.
test which="":
  tt run {{which}}
  
# compile the example file.
example:
  rm -r dev/example/ 2>/dev/null || true
  mkdir -p dev/example/
  typst compile {{example}} dev/example/doc.pdf
  typst compile {{example}} dev/example/page-{0p}.png

# compile the manual.
doc:
  rm -r dev/manual/ 2>/dev/null || true
  mkdir -p dev/manual/
  typst compile {{doc}} dev/manual/doc.pdf
  typst compile {{doc}} dev/manual/page-{0p}.png

# remove all dev files.
clean:
  rm -r dev/manual/  2>/dev/null || true
  rm -r dev/example/ 2>/dev/null || true
  rm -r dev/pkg/     2>/dev/null || true
  rm -r dev/{{name}} 2>/dev/null || true
  tt util clean
  
# enables @local/0.0.0.
symlink:
  bash scripts/dev-link.sh "{{root}}"

# run spell check.
spell correct="no":
  #!/usr/bin/env bash
  arg=""
  if [[ {{correct}} != "no" ]]; then
    arg="--interactive 3 --write-changes"
  fi
  codespell $arg \
    --skip "*.pdf,./dev/*,.git/*,./docs/assets/manual-pt.typ,./template/*" \
    --ignore-words-list "nd,heros"

# init template in dev/
init:
  typst init '@preview/{{name}}:{{version}}' dev/{{name}}


# useful dev commands.
[private]
dev:
  @just test
  bash scripts/dev-link.sh "{{root}}" false
  typst watch {{example}} dev/example/page-{0p}.png
  
# release a new package version.
[private]
release:
  git tag
  bash scripts/version.sh "{{version}}" "{{root}}"
  just install
  typst compile {{example}} docs/example.pdf
  typst compile {{doc}} docs/manual.pdf
  git add .
  git commit -m "VERSION: {{version}} released" || true
  git push origin main --force
  git tag "{{version}}"
  git push origin "{{version}}"
  
# install and build it (used in CI).
[private]
build:
  @just install preview
  @just example
  
# deploy to the Typst Universe repo in ../packages.
[private]
deploy:
  #!/usr/bin/env bash
  bash scripts/version.sh "{{version}}" "{{root}}"
  
  cd ../packages
  git checkout -b main
  just update
  git checkout -b {{name}}
  just delete {{name}} {{version}}
  just bring {{name}}
  git add . --sparse
  git status --short
  git commit -m "{{name}}:{{version}}"
  git push origin {{name}}
  git checkout main
  git branch -D {{name}}
  
# Update log files fir just recipes in dev/
[private]
log recipe:
  #!/usr/bin/env bash
  mkdir -p dev/
  date +"time: %Y-%m-%d (%H:%M)" >> dev/{{recipe}}.log
  just {{recipe}} 2> >(tee -a dev/{{recipe}}.log)
  echo "" >> dev/{{recipe}}.log
  echo "" >> dev/{{recipe}}.log