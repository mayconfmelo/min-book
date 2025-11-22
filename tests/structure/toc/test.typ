#import "/src/lib.typ": book, blockquote

#set page(height: auto, width: 15cm, margin: 2cm)
#set text(font: ("libertinus serif", "new computer modern"))
#set outline(indent: 3em)

#let cfg = (two-sided: false, numbering: "1.")
#let other = (
  title: "", subtitle: "", authors: "", titlepage: none, cover: none, part: none
)
#let book = book.with(..other)


#show: book.with(
  toc: true,
  cfg: cfg + (std-toc: true),
)

= Level One
== Level Two
== Level Two
=== Level Three

= Level One
== Level Two
== Level Two