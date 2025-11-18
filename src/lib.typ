// NAME: Minimal Books
// TODO: Implement ePub output when available
// TODO: Implement themes
// TODO: Implement #toolbox
// TODO: Implement #toolbox.default

#import "additional/notes.typ": note
#import "additional/ambient.typ": appendices, annexes
#import "additional/horizontalrule.typ": horizontalrule, hr
#import "additional/blockquote.typ": blockquote

/**#v(1fr)#outline()#v(1.2fr)#pagebreak()
= Quick Start

```typ
#import "@preview/min-book:1.3.1": book
#show: book.with(
  title: "Book Title",
  subtitle: "Book subtitle, not more than two lines long",
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

These are all the options and its defaults used by _min-book_:

:show.with book:
**/
#let book(
  title: none, /// <- string | content <required>
    /// Main title. |
  subtitle: none, /// <- string | content | none
    /// Subtitle, generally two lines long or less. |
  edition: 0, /// <- integer
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
    /// Cataloging-in-publication board, used for library data (see "@catalog"). |
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
  import "@preview/toolbox:0.1.0": storage, get, default
  import "@preview/transl:0.2.0": transl
  import "utils.typ"
  
  // Required arguments
  assert.ne(title, none, message: "#book(title) required")
  assert.ne(authors, none, message: "#book(authors) required")
  
  let lang-id = text.lang + if text.region != none {"-" + text.region}
  let h2-count = counter("min-book-h2-count")
  let cfg = get.auto-val(cfg, (:))
  let font-size = text.size
  let transl-db = utils.std-langs()
  let date = get.date(date)
  let chapter = chapter
  let part = part
  let break-to
  let std-cfg
  let indent
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
  let part-pattern = (
    "{1:I}:\n",
    "{2:I}.\n",
    "{2:I}.{3:1}.\n",
    "{2:I}.{3:1}.{4:1}.\n",
    "{2:I}.{3:1}.{4:1}.{5:1}.\n",
    "{2:I}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  )
  let no-part-pattern = (
    "{1:I}.\n",
    "{1:I}.{2:1}.\n",
    "{1:I}.{2:1}.{3:1}.\n",
    "{1:I}.{2:1}.{3:1}.{4:1}.\n",
    "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.\n",
    "{1:I}.{2:1}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  )
  /**
  = Advanced Configuration <adv-config>
  :std-cfg: "let" => cfg: <capt>
  
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
    cover-bgcolor: rgb("#3E210B"), /// <- color
       /// Cover background color when `#book(cover: auto)`. |
    cover-txtcolor: luma(200), /// <- color
       /// Cover text color when `#book(cover: auto)`. |
    cover-fonts: ("Cinzel", "Alice"), /// <- array of strings
      /** `(title, text)`\
          Cover font for main title and other texts when `#book(cover: auto)`. |**/
    cover-back: true, /// <- boolean
       /// Generate a back cover at the end of the document when `#book(cover: auto)` |
    std-toc: false, /// <- boolean
      /// Clean special TOC formatting (restore default `#outline` visual). |
    chapter-continuous: true, /// <- boolean
      /// Continue chapter (level 2) numbering even after a book part (level 1). |
    two-sided: true, /// <- boolean
      /// Optimizes to print content on both sides of the paper. |
    paper-friendly: true, /// <- boolean
      /// Use links attached to URL footnotes. |
  )
  let additional = cfg.keys().filter( i => not std-cfg.keys().contains(i) )
  
  // Check if the cfg options received are valid
  if additional != () {
    panic(repr(additional) + " does not exist as #book(cfg)")
  }
  cfg = std-cfg + cfg
  
  indent = default(
    when: par.first-line-indent == (amount: 0pt, all: false),
    value: 1em,
    otherwise: par.first-line-indent.amount,
    cfg.typst-defaults,
  )
  break-to = if cfg.two-sided {"odd"} else {none}
  
  storage.add("break-to", break-to, namespace: "min-book")
  
  // Insert #cfg.transl into #transl-db
  if type(cfg.transl) == str {transl-db.insert(lang-id, cfg.transl)}
  else {transl-db += get.auto-val(cfg.transl, (:))}
  
  transl(data: transl-db, lang: lang-id)
  
  transl = transl.with(data: transl-db, to: lang-id)
  chapter = get.auto-val(chapter, transl("chapter"))
  part = get.auto-val(part, transl("part"))
  
  set document(
    title: title + if subtitle != none {" - " + subtitle},
    author: authors,
    date: date,
  )
  set page(
    ..default(
      when: page.margin == auto,
      value: (margin: (x: 15%, y: 14%)),
      cfg.typst-defaults,
    ),
    ..default(
      when: repr(page.width) == "595.28pt" and repr(page.height) == "841.89pt",
      value: (paper: "a5"),
      cfg.typst-defaults,
    ),
  )
  set par(
    ..default(
      when: par.justify == false,
      value: (justify: true),
      cfg.typst-defaults,
    ),
    ..default(
      when: par.leading == 0.65em,
      value: (leading: 0.5em),
      cfg.typst-defaults,
    ),
    ..default(
      when: par.spacing == 1.2em,
      value: (spacing: 0.65em),
      cfg.typst-defaults,
    ),
    first-line-indent: indent,
  )
  set text(
    ..default(
      when: text.font == "libertinus serif",
      value: ( font: ("TeX Gyre Pagella", "Book Antiqua") ),
      cfg.typst-defaults,
    ),
  )
  set terms(
    ..default(
      when: terms.separator == h(0.6em, weak: true),
      value: (separator: ": "),
      cfg.typst-defaults,
    ),
    ..default(
      when: terms.hanging-indent == 2em,
      value: (hanging-indent: 1em),
      cfg.typst-defaults,
    ),
  )
  set list(
    ..default(
      when: list.marker == ([•], [‣], [–]),
      value: ( marker: ([•], [–]) ),
      cfg.typst-defaults,
    ),
  )
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
  set heading(
    numbering: utils.numbering(
      patterns: (
        cfg.numbering,
        part-pattern,
        no-part-pattern,
      ),
      scope: (
        h1: part,
        h2: chapter
      )
    ),
    hanging-indent: 0pt,
    supplement: it => context {
      if part != none and it.depth == 1 {part}
      else if chapter != none {chapter}
      else {auto}
    }
  )
  
  show heading: it => {
    set align(center)
    set par(justify: false)
    set text(
      hyphenate: false,
      ..default(
        when: text.weight == "bold" and it.level < 6,
        value: (weight: "regular"),
        cfg.typst-defaults
      )
    )
    
    it
  }
  show heading.where(level: 1, outlined: true): it => {
    // Create part page, if any:
    if part != none {
      // Set page background
      let part-bg = if cover == auto {
        let m = page.margin
        let frame = image("assets/frame-gray.svg", width: 93%)
          
        if type(m) != dictionary {
          m = (
            top: m,
            bottom: m,
            left: m,
            right: m
          )
        }
        
        v(m.top * 0.25)
        align(center + top, frame)
        
        align(center + bottom,
          rotate(180deg, frame)
        )
        v(m.bottom * 0.25)
      } else {
        none
      }
        
      if counter(page).get().at(0) != 1 {pagebreak(to: break-to)}
      
      set page(background: part-bg)
      set par(justify: false)
      
      align(center + horizon, it)
      
      set page(background: none)
      pagebreak(to: break-to, weak: true)
      
      // Continue numbering of chapters (level 2) even after parts (level 1)
      if cfg.chapter-continuous == true {
        let h = h2-count.get() // level 2 heading count
        
        counter(heading).update((h1, ..n) => (h1, ..h))
      }
    }
    else {it}
  }
  show heading.where(level: 2): it => {
    if it.numbering != none {h2-count.step()} // count level 2 headings
    
    it
  }
  show heading.where(level: 1): set text(size: font-size * 2)
  show heading.where(level: 2): set text(size: font-size * 1.6)
  show heading.where(level: 3): set text(size: font-size * 1.4)
  show heading.where(level: 4): set text(size: font-size * 1.3)
  show heading.where(level: 5): set text(size: font-size * 1.2)
  show heading.where(level: 6): set text(size: font-size * 1.1)
  show quote.where(block: true): set pad(x: indent)
  show raw: it => {
    set text(
      size: font-size,
      ..default(
        when: text.font == "dejavu sans mono",
        value: (font: "Inconsolata"),
        cfg.typst-defaults
      ),
    )
    
    it
  }
  show raw.where(block: true): it => pad(left: indent, it)
  show math.equation: it => {
    set text(
      ..default(
        when: text.font == "new computer modern math",
        value: ( font: ("Asana Math", "New Computer Modern Math") ),
        cfg.typst-defaults
      )
    )
    
    it
  }
  show selector.or(
      terms, enum, list, table, figure, math.equation.where(block: true),
      quote.where(block: true), raw.where(block: true)
    ): set block(above: font-size, below: font-size)
  show ref: it => context {
    let el = it.element
    
    // When referencing headings in "normal" form
    if el != none and el.func() == heading and it.form == "normal" {
      let number
      let patterns = get.auto-val(
        cfg.numbering,
        if part != none {part-pattern} else {no-part-pattern}
      )
      
      // Remove \n and trim full stops
      if patterns != none and part != "" {
        import "@preview/numbly:0.1.0": numbly

        patterns = patterns.map( i => i.replace("\n", "").trim(regex("[.:]")) )
        number = numbly(..patterns)(..counter(heading).at(el.location()))
        
        // New reference without \n
        link(el.location())[#el.supplement #number]
      }
      else {link(it.target, el.body)}
    }
    else {it}
  }
  show link: it => {
    // FIXME: Accept content it.body
    if cfg.paper-friendly and type(it.dest) == str and it.dest != it.body.text {
      it
      footnote(it.dest)
    }
    else {it}
  }
  
  // Insert notes of a section at its end, before next heading:
  import "additional/notes.typ"
  let body = notes.insert(body)
  
  if titlepage == none and catalog != none and cfg.two-sided {
    // Automatic blank titlepage when generating catalog
    titlepage = []
  }

  if cover != none {
    import "components/cover.typ": new
    
    /**
    = Book cover
    
    By default, _min-book_ automatically generates a book cover if `#book(cover)`
    is not set, it's also possible to set a custom cover image or create one
    using Typst code — the default automatic cover (see
    `/src/components/cover.typ`) can be a good start as a base to create a
    custom version. Cover can be a function, in which case it will be invoked with
    the `title`, `subtitle`, `date`, `authors`, `volume` and `cfg` of the book.
    **/
    new(cover, title, subtitle, date, authors, volume, cfg)
    pagebreak(to: break-to)
  }

  if titlepage != none {
    import "components/titlepage.typ": new
    
    new(titlepage, title, subtitle, authors, date, volume, edition)
    if catalog != none {pagebreak()}
    else {pagebreak(to: break-to, weak: true)}
  }

  if catalog != none {
    /**
    = Cataloging in Publication <catalog>
    
    :arg catalog: "let"
    
    These `#book(catalog)` options set the data used to create the
    "cataloging in publication" board. Other needed information are
    automatically retrieved from the book data, but at least one of these
    options must be explicitly set to generate the board; otherwise it will
    be just ignored.
    **/
    // FIXME: accept content #catalog(title)
    let catalog = (
      id: none, /// <- string | content
        /** A #url("http://www.cutternumber.com/")[Cutter-Sanborn identification code,]
        used to identify the book author. |**/
      place: none, /// <- string | content
        /// The city or region where the book was published. |
      publisher: none, /// <- string | content
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
    ) + catalog
    
    import "components/catalog.typ": new
    
    new(catalog, title, subtitle, authors, date, volume, edition)
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
    show outline.entry: it => {
      let entry = it.indented(it.prefix(), it.inner(), gap: 0em)
      
      // Emphasize parts in TOC:
      if cfg.std-toc == false and it.level == 1 and part != none {
        v(font-size, weak: true)
        strong(entry)
      }
      else {entry}
    }
    
    pagebreak(to: break-to, weak: true)
    outline(
      ..default(
        when: outline.indent == auto,
        value: (indent: lvl => { if lvl > 0 {1.5em} else {0em} }),
        cfg.typst-defaults
      ),
      ..default(
        when: cfg.numbering == none,
        value: (depth: 2),
        cfg.typst-defaults
      ),
    )
    pagebreak(weak: true)
  }
  else if type(toc) == content {toc}
  
  // <outline> anchor allows different numbering styles in TOC and in the actual text.
  [#metadata("Marker for situating titles after/before outline") <outline>]
  
  // Start page numbering at the next even page:
  if part != none {pagebreak(weak: true, to: break-to)}
  set page(numbering: "1")
  counter(page).update(1)
  
  body
  
  if cover == auto and cfg.cover-back {
    let cover-bg = context {
          let m = page.margin
          let frame = image(
              width: 93%,
              "assets/frame.svg"
            )
            
          if type(m) != dictionary {
            m = (
              top: m,
              bottom: m,
              left: m,
              right: m
            )
          }
          
          v(m.top * 0.25)
          align(center + top, frame)
          
          align(center + bottom,
            rotate(180deg, frame)
          )
          v(m.bottom * 0.25)
        }
    
    pagebreak(weak: true, to: break-to)
    page(
      footer: none,
      background: cover-bg,
      fill: cfg.cover-bgcolor,
      []
    )
  }
}

/**
= Additional Commands

These commands are provided as a way to access some fancy book features that
cannot be implemented by re-working and adapting existing Typst elements. They
are completely optional, and is perfectly possible to write an entire book without
using them.
**/