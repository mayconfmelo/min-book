#import "/src/commands/draft.typ": *
#import "@preview/nexus-tools:0.1.0": storage

#set par(justify: true)

#storage.add("draft", true, namespace: "min-book")

#lorem(20)
#comment[This is a comment.]
#lorem(10)

#lorem(20)
#comment(type: box)[This is a comment.]
#lorem(10)

#lorem(20)
#comment(type: block)[This is a comment.]
#lorem(10)

#line()

#lorem(20)
#mark[This is a marked text]
#lorem(10)

#lorem(20)
#mark(gray.darken(20%))[This is a marked text]
#lorem(10)