#import "/src/lib.typ": book, blockquote

#set text(font: ("libertinus serif", "new computer modern"))

#let doc = []
#let other = (
  title: "Title", authors: "Author", subtitle: "Subtitle", volume: 1,
  edition: 2, titlepage: none, cover: none, toc: none, cfg: (two-sided: false)
)
#let book = book.with(..other, doc)


#book(
  epigraph: blockquote(by: "Einstein")[Don't believe everything you read.]
)