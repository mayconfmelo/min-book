# 0.0.0

## 0.1.0

- Cover (optional)
  - Image
  - Typst code
- Title page (optional)
  - Automatic generation
  - Typst code
- Default values for non-essential `#book` arguments
- Parts (optional book divisions)
  - Level 1 headings
- Chapters (optional main sections)
  - Level 2 headings when _parts_ are used
  - Level 1 headings when _parts_ are not used
- Extended numbering
  - Typst numbering strings
  - Numbly numbering arrays
- Additional `#note` command
- Additional `#horizontalrule` command (alias `#hr`)
- Additional `#blockquote` command

### 0.1.1

- Added: Automatic cover generation
- Added: `#appendices` command
- Added: `#annexes` command
- Added: Support for unnumbered _part/chapter_ with `#book(numbering-style: none)`
- Updated: `#book(titlepage)` defaults to `false`
- Updated: `#book(paper)` can be a a string or dictionary
- Fixed: No part name was shown when `#book(toc: false)`
- Fixed: Broken `@ref` to headings with `\n` in its numbering

# 1.0.0

- Added: Default _part, chapter, appendix_ and _annex_ titles in `#lang.text` language
- Added: Custom TOML translation file with `#book(lang-data)`
- Added: Documentation retrieval from special comments
- Added: `#note(numbering-style)` set the numbering of the next `#note` commands also
- Added: `#book(page-cfg)` act as `#set page(..page-cfg)`
- Added: `#book(date)` can be a `(year, month, day)` dictionary
- Added: `#book(volume)` for book series volume
- Added: `#book(edition)` for book publication edition
- Added: `#book(catalog)` to generate a _cataloging in publication_ page
- Added: `#book(errata)` for correction of errors from previous editions
- Added: `#book(dedication)` for dedication page
- Added: `#book(acknowledgments)` for acknowledgments page
- Added: `#book(epigraph)` for epigraph page
- Added: `#book(cfg)` for advanced configuration
- Added: `#book(cfg.font-mono)` to set monospaced text font
- Updated: Reorganized internal structure
- Updated: All advanced configuration options moved to `#book(cfg)`
- Updated: `#book(paper)` &rarr; `#book(page-cfg)`
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

- Added: `#book(cfg)` options
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
  - `cfg.toc-indent` &rarr; `#set outline(indent)`
  - `cfg.font` &rarr; `#set text(font)`
  - `cfg.font-math` &rarr; `#show math.equation: set text(font)`
  - `cfg.font-mono` &rarr; `#show raw: set text(font)`
  - `cfg.font-size` &rarr; `set text(size)`
- Added: `#annexes(cfg.toc-stdindent)` enables standard TOC
- Added: Translation with [transl:0.1.0](https://typst.app/universe/package/transl/0.1.0) package (Fluent)
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


## 1.4.0

- Internal re-design
- Added: Defaults changeable by `#set` rules
- Added: Support for themes
- Added: Default themes 
  - _stylish_ (default)
  - _coffee_
  - _elegance_
- Added: `#book(transl)` support to multiple languages (Fluent YAML database)
- Updated: `#book(transl)` using _transl:0.2.0_
- Updated:  `#book(cfg)` options
  - `cfg.justify` &rarr; `#set par(justify)`
  - `cfg.line-space` &rarr; `#set par(leading)`
  - `cfg.line-indentfirst` &rarr; `#set par(first-line-indent)`
  - `cfg.par-margin` &rarr; `#set par(spacing)`
  - `cfg.margin` &rarr; `#set page(margin)`
  - `cfg.heading-weight` &rarr; `#show heading: set text(weight)`
  - `cfg.toc-stdindent` &rarr; `#outline(indent)`
  - `cfg.cover-bgcolor` &rarr; `cfg.cover.page`
  - `cfg.cover-txtcolor` &rarr; `cfg.cover.text`
  - `cfg.cover-fonts` &rarr; `cfg.cover`
  - `cfg.use-fontdefaults` &rarr; `cfg.styling.reset`
  - `cfg.toc-bold` &rarr; `cfg.std-toc`
  - `cfg.chapter-numrestart` &rarr; `cfg.chapter-continuous`
  - `cfg.paper-links` &rarr; `cfg.paper-friendly`
  - `cfg.notes-page` set notes in new pages
  - `cfg.theme` set theme
  - `cfg.styling` set theme styling
  - `cfg.cover` set theme cover
  - `cfg.part` set theme part