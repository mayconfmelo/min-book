#import "/src/lib.typ": book

#set text(font: ("libertinus serif", "new computer modern"))

#let doc = []
#let other = (
  title: "Title", authors: "Author", subtitle: "Subtitle", volume: 1,
  edition: 2, cover: none, toc: none, cfg: (two-sided: false)
)
#let book = book.with(..other, doc)


#book(titlepage: auto)

#book(titlepage: align(center + horizon, text(size: 20pt)[*Title*]))

// TODO: function value for #book(titlepage)