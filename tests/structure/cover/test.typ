#import "/src/lib.typ": book

#set page(paper: "a5", footer: none)
#set text(font: ("libertinus serif", "new computer modern"))

#let doc = []
#let other = (title: "Title", authors: "Author", subtitle: "Subtitle", volume: 1,
  titlepage: none, toc: none, cfg: (two-sided: false, cover-back: false,
  cover-fonts: ("Libertinus Serif", "Libertinus Serif")))
#let book = book.with(..other, doc)


#book(cover: auto) // 1.png

// 2.png
#book(
  cover: page(fill: blue, margin: 1cm)[
    #set text(fill: white, size: 20pt)
    #block(
      width: 100%,
      height: 100%,
      stroke: 1pt + white,
      align(center + horizon)[*Title*]
    )
  ]
)

// 3.png
#book(
  cover: (meta, cfg) => {
    page(fill: purple)[
      #set text(fill: white, size: 20pt)
      #block(
        width: 100%,
        height: 100%,
        inset: 1em,
        stroke: 1pt + white,
        align(center + horizon)[*#meta.title*] +
        align(center + bottom)[#meta.authors],
      )
    ]
  }
)

#book(cover: image("cover.png")) // 4.png and 5.png