#import "/src/lib.typ": book

#set page(width: auto, height: auto, margin: 2cm, footer: none)
#set text(font: ("libertinus serif", "new computer modern"))

#let doc = [
  = Level One
  == Level Two
  #lorem(5)
]
#let other = (
  title: "", authors: "", cover: none, titlepage: none, toc: none,
  cfg: (two-sided: false),
)
#let book = book.with(..other, doc)

#book(part: "", chapter: none,)  // 1.png and 2.png
#book(part: none) // 3.png
#book(part: none, chapter: none) // 4.png