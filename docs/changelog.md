# 0.0.0

## 0.1.0

- Optional _cover_
  - Image covers
  - Typst cover creation
- Optional _title page_
  - Automatic title page generation
  - Typst title page creation
- Default values for all non-essential `#book` arguments
- Automatic book divisions (_parts_)
  - Level 1 headings used as _parts_
- Automatic book main sections (_chapters_)
  - Level 2 headings used as _chapters_ when _parts_ are used
  - Level 1 headings used as _chapters_ when _parts_ are not used
- Extended numbering
  - Typst numbering strings
  - Numbly numbering arrays
- Additional `#note` command
- Additional `#horizontalrule` and `#hr` commands
- Additional `#blockquote` command

### 0.1.1

- Added: automatic default cover generation
- Added: `#appendices` command
- Added: `#annexes` command
- Added: Unnumbered _part_ and _chapter_ with `#book(numbering-style: none)`
- Updated: `#book(titlepage)` defaults to `false`
- Updated: `#book(paper)` can be a `"type"` or `(x: LENGTH, y: LENGTH)` size
- Fixed: no part name was shown when `#book(toc: false)`
- Fixed: broken `@ref` to headings with `\n` in its numbering

# 1.0.0

- Added: Default _part, chapter, appendix_ and _annex_ titles in `#lang.text` language
- Added: Custom TOML translation file with `#book(lang-data)`
- Added: Manual embedded on the source code with doc-comments
- Added: `#note(numbering-style)` set the numbering of all the next `#note` commands also
- Added: `#book(page-cfg)` act as `#set page(..page-cfg)`
- Added: `#book(date)` can be a `(year: YYYY, month: MM, day: DD)` dictionary
- Added: `#book(volume)` for book series volume
- Added: `#book(edition)` for book publication edition
- Added: `#book(catalog)` to generate a _cataloging in publication_ page
- Added: `#book(errata)` for correction of errors from previous editions
- Added: `#book(dedication)` for dedication page
- Added: `#book(acknowledgments)` for acknowledgments page
- Added: `#book(epigraph)` for epigraph page
- Added: `#book(cfg)` for advanced configuration
- Added: `#book(cfg.font-mono)` to set monospaced text font
- Updated: All advanced configuration options moved to `#book(cfg)`
- Updated: `#book(paper)` &rarr; `#book(page-cfg)`
- Updated: Reorganized internal structure
- Updated: `#outline(depth: 2)` when `#book(numbering-style: none)`
- Updated: `#book(part: "")` set an unnumbered and unnamed part (just heading title)
- Updated: Headings level 1–5 with regular font weight by default
- Updated: Content after _part_ start at next odd page
- Fixed: titlepage, toc, part, and content beginning moved to odd pages
- Fixed: `#book(cover: image())` works again
- Fixed: Removed blank first page that appeared in some situations

Thanks to [@iandol](https://github.com/iandol) for the thoughtful insights and
the help testing some features.

## 1.1.0

- Added: `#book(cfg)` new options
  - `cfg.cover-bg` change automatic cover background
  - `cfg.cover-txtcolor` change automatic cover text color
  - `cfg.cover-fonts` change the fonts used in automatic cover
  - `cfg.cover-back` allows generate of back cover when `#book(cover: auto)`
  - `cfg.toc-indent` sets TOC indentation
  - `cfg.toc-bold` allows bold fonts in TOC entries for parts
  - `cfg.chapter-numrestart` makes chapter numbering restart or continue after a book part
  - `cfg.two-sided` makes important elements always start at the next oddly numbered page
  - `cfg.link-readableL` allows paper-readable links (clickable links + footnote)
- Updated: `#book(numbering-style)` can be `none` or contain it in array
- Updated: `#book(cfg.page-cfg)` &rarr; `#book(cfg.page)`


## 1.2.0

- Removed: `#book(cfg)` redundant options
  - `cfg.toc-indent` was the same as `#set outline(indent)`
  - `cfg.font` was the same as `#set text(font)`
  - `cfg.font-math` was the same as `#show math.equation: set text(font)`
  - `cfg.font-mono` was the same as `#show raw: set text(font)`
  - `cfg.font-size` was the same as `set text(size)`
- Added: `#annexes(cfg.toc-stdindent)` enables standard TOC
- Added: Translation with [transl](https://typst.app/universe/package/transl) package (Fluent)
- Added: IA translations
- Added: Custom TOC creation
- Updated: `#book(cfg.lang-data)` &rarr; `#book(cfg.transl)`
- Updated: `#book(cfg.transl: read("path/file.ftl"))` set translation file
- Updated: `#panic` if no translation file is found for book language (removed fallback to English)
- Updated: `#book(cfg.numbering-style)` &rarr; `#book(cfg.numbering)`
- Updated: `#note(cfg.numbering-style)` &rarr; `#note(cfg.numbering)`
- Updated: `#appendices(cfg.numbering-style)` &rarr; `#appendices(cfg.numbering)`
- Updated: `#annexes(cfg.numbering-style)` &rarr; `#annexes(cfg.numbering)`
- Updated: `#annexes(cfg.numbering-style)` &rarr; `#annexes(cfg.numbering)`
- Updated: `#annexes(cfg.first-line-indent)` &rarr; `#annexes(cfg.line-indentfirst)`
- Updated: `#annexes(cfg.link-readable)` &rarr; `#annexes(cfg.paper-links)`
- Updated: Changed entire project structure (compartimentalization)
- Updated: Added project tests


### 1.2.1

- Fixed: Removed red background from `src/assets/frame.svg`


## 1.3.0

- Added: `#book(cover)` can be a function
- Updated: Template features a excerpt from a real book (public domain)
- Updated: Reduced font size of main title in default cover and title page
- Fixed: Compilation failed if custom math font was not found
  - Fallback to default Typst math font
- Fixed: Unnumbered headings were also counted in special continuous chapter numbering
  - Unnumbered headings ignored


## 1.3.1

- Internal re-design