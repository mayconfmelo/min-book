#import "@preview/transl:0.2.0": transl
#import "/src/lib.typ": horizontalrule
#import "/src/themes.typ"
#transl(data: read("/src/l10n/en.ftl"), lang: "en")

#set text(font: ("libertinus serif", "new computer modern"), size: 12pt)
#set outline(indent: 2em)

#let theme = themes.stylish

#let meta = (
  title: lorem(12),
  subtitle: lorem(30),
  date: datetime.today(),
  authors: ("Main Author", "Collaborator", "Collaborator"),
  volume: transl("volume", n: 1),
  edition: transl("edition", n: 3),
  part: "Pt.",
  chapter: "Chapt.",
  cover: auto,
  numbering: "I.i.i.i.i.a ",
)


#show: body => context {
  let body = theme.styling(meta, (:), body)
  body
}

#context theme.cover-page(meta, (:)) // 1.png

#context theme.title-page(meta, (:)) // 2.png

#context theme.part(meta, (:), heading[Part Heading]) // 3.png

#context theme.horizontalrule(meta, (:))


#lorem(50)

#quote(lorem(25), attribution: [Lipsum], block: true)

#lorem(50)

#horizontalrule(spacing: 2em)

#lorem(50)


#outline()
#metadata("TOC inserted") <toc:inserted> // internal

= Heading #context {text.size}
== Heading #context {text.size}
=== Heading #context {text.size}
==== Heading #context {text.size}
===== Heading #context {text.size}
====== Heading #context {text.size}