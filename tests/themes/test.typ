#import "@preview/transl:0.2.0": transl
#import "/src/lib.typ": book, themes, horizontalrule

#let args = (
  cfg: (
    theme: themes.elegance,
    two-sided: false,
  ),
  title: lorem(12),
  subtitle: lorem(30),
  date: datetime.today(),
  authors: ("Main Author", "Collaborator", "Collaborator"),
  volume: 1,
  edition: 3,
  part: "Pt.",
  chapter: "Chapt.",
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

#quote(lorem(30), attribution: [Lipsum], block: true)

#lorem(25)

#horizontalrule()

#lorem(25)

```typ
#show: book.with(options)
```
