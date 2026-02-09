#import "/src/lib.typ": book

#set page(paper: "a5", footer: none)

#let doc = []
#let other = (
  title: "A", authors: "", part: none, cover: none, toc: none,
  cfg: (two-sided: false, styling: (reset: true)), titlepage: none,
)
#let book = book.with(..other, doc)


#book(acknowledgements: align(center + horizon)[_Thank you everyone!_])