#import "/src/commands/draft.typ": *
#import "@preview/nexus-tools:0.1.0": storage

#set par(justify: true)

#storage.add("draft", true, namespace: "min-book")

#lorem(20)
#comment[Margin comment.] #lorem(10)
#comment(type: box)[Inline comment.] #lorem(10)
#comment(type: block)[Block comment.] #lorem(10)
#comment(stroke: red + 2pt)[Red comment box.] #lorem(10)

#line()

#lorem(20)
#mark[Marked text] #lorem(10)
#mark(red)[Red marked text] #lorem(10)