// TODO: Implement ePub output when available

#import "commands/notes.typ": note
#import "commands/ambients.typ": appendices, annexes
#import "commands/horizontalrule.typ": horizontalrule, hr
#import "commands/blockquote.typ": blockquote
#import "themes.typ"

/**#v(1fr) #outline() #v(1.2fr) #pagebreak()
= Quick Start

```typ
#import "@preview/min-book:1.4.0": book
#show: book.with(
  title: "Book Title",
  subtitle: "Book subtitle",
  authors: "Book Author",
)
```

= Description

Generate complete and complex books, without any annoying new commands or
syntax, just good old pure Typst. This package manipulates the standard Typst
elements as much as possible, adapting them to the needs of a book structure
in a way that there's no need to learn a whole new semantic just because of
_min-book_.

For some fancy book features there is no existing compatible Typst element to
re-work and adapt; in those cases, this package do provide additional commands
that are completely optional, for the sake of completeness.

This package comes with some thoughful ready-to-use defaults but also allows
you to play with highly customizable options if you need them, so it's really
up to you: customize it your way or ride along the defaults — both ways are
possible and encouraged.

= Options
:show.with book:
**/
#let book(
  title: none, /// <- string | content <required>
    /// Main title. |
  subtitle: none, /// <- string | content | none
    /// Subtitle, generally two lines long or less. |
  edition: 1, /// <- integer
    /// Edition number (counts changes and updates between book releases). |
  volume: 0, /// <- integer
    /// Series volume number (situates the book in a book collection). |
  authors: none, /// <- string | array of strings <required>
    /// Author or authors. |
  date: datetime.today(), /// <- datetime | array | dictionary
    /// `(year, month, day)`\ Publication date. |
  cover: auto, /// <- auto | function | image | content | none
    /// Cover; when using function, takes two arguments (`meta, cfg`). |
  titlepage: auto, /// <- auto | content | none
    /// Title page (shown after cover). |
  catalog: none, /// <- dictionary | yaml | toml
    /// Cataloging-in-publication board, used for library data (see "@catalog" section). |
  errata: none, /// <- content | string
    /// Correction of errors from previous book editions. |
  dedication: none, /// <- content | string
    /// Tribute or words addressed to someone imprtant. |
  acknowledgements: none, /// <- content | string
    /// Expression of gratitude to those who contributed to the work. |
  epigraph: none, /// <- quote | content
    /// Brief quotation that foreshadows the book’s theme, tone, or central reflection. |
  toc: true, /// <- boolean
    /// Table of contents. |
  part: auto, /// <- string | none | auto
    /// Custom name of the book's main divisions (parts). |
  chapter: auto, /// <- string | none
    /// Custom name of sections of the book (chapters). |
  cfg: auto, /// <- dictionary
    /// Set advanced configurations (see "@adv-config"). |
  body /// <- content
    /// The book content. |
) = context {
  import "@preview/toolbox:0.1.0": storage, get, default, content2str
  import "@preview/transl:0.2.0": transl
  import "commands/notes.typ"
  import "utils.typ"
  
  assert.ne(title, none, message: "#book(title) required")
  assert.ne(authors, none, message: "#book(authors) required")
  
  /**
  = Advanced Numbering
  
  The book headings can be numbered two ways: using a
  #url("https://typst.app/docs/reference/model/numbering/")[standard]
  numbering string or a #univ("numbly") numbering array. Strings are more
  simple and easy to use, while arrays are more complete and customizable.
  
  By default, _min-book_ uses slightly different numbering when `#book(part)`
  is enabled or disabled, that's why _parts_ and _chapters_ appear to have
  independent numbering when used. The `#book(cfg.numbering)` option
  allow to set a custom numbering used whether `#book(part)` is enabled or
  disabled.
  **/
  let cfg = get.auto-val(cfg, (:))
  /**
  = Advanced Configuration <adv-config>
  :std-cfg: typc "let" => cfg: <capt>
  
  These `#book(cfg)` configurations allows to modify certain aspects of the
  book and manage its appearance and structure. Built with some thoughful
  ready-to-use defaults that make its use optional, so that beginners and
  casual writers can safely ignore it and _just write_.
  **/
  let std-cfg = (
    numbering: auto, /// <- string | array of strings | none
      /// Heading numbering (uses #univ("numbly") package). |
    transl: auto, /// <- string | dictionary
      /// `"file"  (lang: "file")`\ Set #univ("transl") Fluent database. |
    typst-defaults: false, /// <- boolean
       /// Use Typst defaults instead of min-book defaults. |
    std-toc: false, /// <- boolean
      /// Clean special TOC formatting (restore default `#outline` visual). |
    chapter-continuous: true, /// <- boolean
      /// Continue chapter (level 2) numbering even after a book part (level 1). |
    two-sided: true, /// <- boolean
      /// Optimizes to print content on both sides of the paper. |
    paper-friendly: true, /// <- boolean
      /// Use links attached to URL footnotes. |
    notes-page: false, /// <- boolean
      /// Forces `#note` data to always appear in a separate new page. |
    theme: themes.stylish, /// <- module
      /// Set book theme. |
    styling: (:), /// <- dictionary
      /// Theme-dependent styling configurations. |
    cover: (:), /// <- dictionary
      /// Theme-dependent cover/title page configurations. |
    part: (:), /// <- dictionary
      /// Theme-depend part configurations. |
  )
  let not-cfg = cfg.keys().filter( i => not std-cfg.keys().contains(i) )
  let lang-id = text.lang + if text.region != none {"-" + text.region}
  let transl-db = utils.std-langs()
  let date = get.date(date)
  let font-size = text.size
  /**
  = Book Parts
  
  ```typ
  #show: book.with(
    part: "Act",
  )
  = This is a part!  // Act 1
  ```
  
  Some larger books are internally divided into multiple _parts_. This
  structure allows to better organize and understand a text with multiple
  sequential plots, or tales, or time jumps, or anything that internally
  differentiate parts of the story. Each book can set different names for
  them, like parts, subjects, books, acts, units, modules, etc;
  by default, _min-book_ tries to get the word for "Part" in book language as
  its name.
  
  When a value is set, all level 1 headings become _parts_: they occupy the
  entire page and are aligned at its middle; some decorative frame also
  appear when `#book(cover: auto)`.
  
  = Book Chapters
  
  #grid(columns: (auto, auto),
    ```typ
    #show: book.with(
      chapter: "Scene",
    )
    
    == This is a chapter!  // Scene 1 
    ```,
    grid.vline(stroke: gray.lighten(60%)),
    ```typ
    #show: book.with(
      part: none,
      chapter: "Scene",
    )
    = This is a chapter!  // Scene 1
    ```
  )
  
  In most cases, books are divided into smaller sections called chapters.
  Generally, each chapter contains a single minor story, or event, or scene,
  or any type of subtle plot change. Each book can set different names for
  them, like chapters, sections, articles, scenes, etc; by default, _min-book_
  tries to get the word for "Chapter" in book language as its name.
  
  Chapters are smart: when a value is set, if `#book(parts: none)` all level
  1 headings become chapters; otherwise, all level 2 headings become chapters
  — since the level 1 ones are parts.
  **/
  let part = part
  let chapter = chapter
  let body = body
  let break-to
  let meta 
  
  // Check if the cfg options received are valid
  if not-cfg != () {
    panic("Invalid #book(cfg) options: " + not-cfg.join(", "))
  }
  cfg = std-cfg + cfg
  
  // Insert #cfg.transl into #transl-db
  if type(cfg.transl) == str {transl-db.insert(lang-id, cfg.transl)}
  else {transl-db += get.auto-val(cfg.transl, (:))}
  
  transl(data: transl-db, lang: lang-id)
  
  transl = transl.with(data: transl-db, to: lang-id)
  chapter = get.auto-val(chapter, transl("chapter"))
  part = get.auto-val(part, transl("part"))
  break-to = if cfg.two-sided {"odd"} else {none}
  meta = (
    title: title,
    subtitle: subtitle,
    date: date,
    authors: authors,
    volume: if volume != 0 {transl("volume", n: volume)} else {""},
    edition: if edition != 0 {transl("edition", n: edition)} else {""},
    part: part,
    chapter: chapter,
    cover: cover,
  )
  
  storage.add("break-to", break-to, namespace: "min-book")
  storage.add("part", part, namespace: "min-book")
  
  show: cfg.theme.styling.with(meta, cfg)
  show heading.where(level: 1, outlined: true): it => {
    if part != none {it = cfg.theme.part(meta, cfg, it)}
    it
  }
  show <horizontalrule:insert>: it => {
    if dictionary(cfg.theme).keys().contains("horizontalrule") {
      cfg.theme.horizontalrule(meta, cfg)
    }
    else {align(center, line(length: 80%))}
  }
  
  body = notes.insert(body, new-page: part != none or cfg.notes-page)
  
  if titlepage == none and catalog != none and cfg.two-sided {
    // Automatic blank titlepage when generating catalog
    titlepage = []
  }
  
  if cover != none {
    let cfg = cfg
    let generate-cover
    
    cfg.cover += (back: false)
    
    if cover == auto {generate-cover = cfg.theme.cover-page}
    else if type(cover) == content {
      generate-cover = (_,_) => {
        if cover.func() == image {
          set image(
            fit: "stretch",
            width: 100%,
            height: 100%
          )
          
          page(background: cover)[]
        }
        else {cover}
      }
    }
    else if type(cover) == function {generate-cover = cover}
    else {panic("Invalid #book(page) value: " + cover)}
    
    /**
    = Book cover
    
    By default, _min-book_ automatically generates a book cover if `#book(cover)`
    is not set, it's also possible to set a custom cover image or create one
    using Typst code — the default automatic cover (see
    `/src/components/cover.typ`) can be a good start as a base to create a
    custom version. Cover can be a function, in which case it will be invoked with
    the `title`, `subtitle`, `date`, `authors`, `volume` and `cfg` of the book.
    **/
    generate-cover(meta, cfg.cover)
    pagebreak(to: break-to, weak: true)
  }
  
  if titlepage != none {
    //import "components/titlepage.typ": new
    
    //new(titlepage, title, subtitle, authors, date, volume, edition)
    
    let generate-titlepage
    
    if titlepage == auto {generate-titlepage = cfg.theme.title-page}
    else if type(titlepage) == content {
      generate-titlepage = (_,_) => {
        if titlepage == none {page[]}
        else if titlepage.func() == image {
          set image(
            fit: "stretch",
            width: 100%,
            height: 100%
          )
          
          page(background: titlepage)[]
        }
        else {titlepage}
      }
    }
    else if type(titlepage) == function {generate-titlepage = titlepage}
    else {panic("Invalid #book(titlepage) value: " + repr(titlepage))}
    
    generate-titlepage(meta, cfg.cover)
    pagebreak(weak: true)
  }
  
  if catalog != none {
    import "catalog.typ" as cataloging
    
    /**
    = Cataloging in Publication <catalog>
    
    :arg catalog: "let"
    
    These `#book(catalog)` options set the data used to create the
    "cataloging in publication" board. Other needed information are
    automatically retrieved from the book data, but at least one of these
    options must be explicitly set to generate the board; otherwise it will
    be just ignored.
    **/
    let catalog = (
      id: none, /// <- string | content
        /** A #url("http://www.cutternumber.com/")[Cutter-Sanborn identification code,]
        used to identify the book author. |**/
      place: none, /// <- string
        /// The city or region where the book was published. |
      publisher: none, /// <- string
        /// The organization or person responsible for releasing the book. |
      isbn: none, /// <- string | content
        /// The _International Standard Book Number_, used to identify the book. |
      subjects: (), /// <- array of strings
        /// A list of subjects related to the book. |
      access: (), /// <- array of strings
        /** A list of access points used to find the book in catalogues, like by
        `"Title"` or `"Series"`. |**/
      ddc: none, /// <- string | content
        /** A #url("https://www.oclc.org/content/dam/oclc/dewey/ddc23-summaries.pdf")[Dewey Decimal Classification]
        number, which corresponds to the specific category of the book. |**/
      udc: none, /// <- string | content
        /** An #url("https://udcsummary.info/php/index.php")[Universal Decimal Classification]
        number, which corresponds to the specific category if the book. |**/
      before: none, /// <- content
        /** Content showed before (above) the cataloging in publication board;
        generally shows editorial data like publisher, editors, reviewers,
        copyrights, etc. |**/
      after: none, /// <- content
        /** Content showed after (below) the cataloging in publication board;
        generally shows additional information that complements the board data. |**/
      bib-style: "chicago-notes", /// <- string
        /// Bibliographic reference style of the book data. |
    ) + catalog
    
    if meta.volume != "" {meta.volume = volume}
    if meta.edition != "" {meta.edition = edition}
    if meta.subtitle != none {meta.subtitle = content2str(meta.subtitle)}
    
    meta.title = content2str(meta.title)
    
    cataloging.insert(catalog, meta)
  }
  
  if errata != none {
    pagebreak(to: break-to, weak: true)
    heading(
      transl("errata"),
      numbering: none,
      outlined: false,
    )
    errata
    pagebreak(to: break-to)
  }
  
  if dedication != none {
    set text(size: font-size - 2pt)
    
    pagebreak(to: break-to, weak: true)
    align(center + horizon, dedication)
    pagebreak(to: break-to)
  }
  
  if acknowledgements != none {
    set par(justify: true)
    
    pagebreak(to: break-to, weak: true)
    // INFO: Acknowledgements without title for now, seems cleaner
    // heading(
    //   transl("thanks"),
    //   numbering: none,
    //   outlined: false,
    // )
    acknowledgements
    pagebreak(to: break-to)
  }
  
  if epigraph != none {
    set align(right + bottom)
    set quote(block: true)
    set text(
      size: font-size - 2pt,
      style: "italic",
    )
    
    pagebreak(to: break-to, weak: true)
    pad(
      epigraph,
      left: 1cm,
    )
    pagebreak(to: break-to)
  }
  
  if toc == true {
    pagebreak(to: break-to, weak: true)
    outline(
      ..default(
        when: outline.indent == auto and not cfg.std-toc,
        value: (indent: lvl => { if lvl > 0 {1.5em} else {0em} }),
        cfg.typst-defaults
      ),
      ..default(
        when: cfg.numbering == none and not cfg.std-toc,
        value: (depth: 2),
        cfg.typst-defaults
      ),
    )
    pagebreak(weak: true)
  }
  
  [#metadata("Situates headings before/after outline") <toc:inserted>]
  
  // Start page numbering at the next even page:
  if part != none {pagebreak(weak: true, to: break-to)}
  set page(numbering: "1")
  counter(page).update(1)
  
  body
  
  cfg.cover.back = cfg.cover.at("back", default: true)
  
  if cover == auto and cfg.cover.back  { cfg.theme.cover-page(meta, cfg.cover) }
}

/**
= Additional Commands

These commands are provided as a way to access some fancy book features that
cannot be implemented by re-working and adapting existing Typst elements. They
are completely optional, and is perfectly possible to write an entire book without
using them.
**/