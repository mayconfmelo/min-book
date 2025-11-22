#import "/src/lib.typ": book

#set text(font: ("libertinus serif", "new computer modern"))

#let doc = []
#let other = (
  title: "Title", authors: "Author", titlepage: none, cover: none, toc: none,
  cfg: (two-sided: false)
)
#let book = book.with(..other, doc)


#book(
  errata: [
    The information in page 99 is wrong; you cannot actually eat sugar cane
    while wristle.
  ]
)