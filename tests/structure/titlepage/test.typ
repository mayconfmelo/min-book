#import "/src/lib.typ": book

#set page(paper: "a5", footer: none)
#set text(font: ("libertinus serif", "new computer modern"))

#let doc = []
#let other = (
  title: "Title", authors: "Author", subtitle: "Subtitle", volume: 1,
  edition: 2, cover: none, toc: none, cfg: (two-sided: false)
)
#let book = book.with(..other, doc)


#book(titlepage: auto)

#book(titlepage: align(center + horizon, text(size: 23pt)[*Title*]))

#book(titlepage: (meta, cfg) => {
  align(center + horizon, text(size: 23pt)[*#meta.title*])
  align(center + bottom, text(size: 14pt, meta.authors))
})