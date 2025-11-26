#import "@preview/transl:0.2.0": transl
#import "/src/lib.typ": book, themes, horizontalrule

#let theme = themes.coffee
#let args = (
  title: lorem(12),
  subtitle: lorem(30),
  date: datetime.today(),
  authors: ("Main Author", "Collaborator", "Collaborator"),
  volume: 1,
  edition: 3,
  part: "Pt.",
  chapter: "Chapt.",
  cfg: (
    theme: theme,
    two-sided: false,
  )
)

#show: book.with(..args)

= Heading #context text.size
#lorem(8)
== Heading #context text.size
#lorem(8)
=== Heading #context text.size
#lorem(8)
==== Heading #context text.size
#lorem(8)
===== Heading #context text.size
#lorem(8)
====== Heading #context text.size
#lorem(16)

#pagebreak()

== Heading

#lorem(25)

#quote(lorem(15), attribution: [Lipsum], block: true)

#lorem(25)

#horizontalrule(spacing: 2em)

#lorem(25)

```typ
#show: book.with(options)
```
