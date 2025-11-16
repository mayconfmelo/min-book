#import "/src/lib.typ": note, book
#import "@preview/toolbox:0.1.0": storage
#set page(height: auto)

// Show storage representation
#page(
  width: auto,
  height: auto,
  margin: 1em,
  context raw(
    lang: "yaml",
    yaml.encode( storage.final("note", namespace: "min-book") )
  )
)

// Additional book data
#show: book.with(
  title: "",
  authors: "",
  cover: none,
  titlepage: none,
  toc: none,
  cfg: (
    two-sided: false,
    cover-back: false,
    font-usedefaults: true,
  )
)


#lorem(25)#note[Foo]
#lorem(25)#note[Bar]

#lorem(50)#note[Baz]

#lorem(50)#note[Qux]

#lorem(50)#note[Quz]

#lorem(50)#note[Quuz]