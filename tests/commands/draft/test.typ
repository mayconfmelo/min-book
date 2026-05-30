#import "/src/commands/draft.typ": *
#import "@preview/nexus-tools:0.1.0": storage
#import "@preview/transl:0.2.0": transl

#set par(justify: true)
#set page(width: 14cm, height: auto, margin: (right: 4cm, rest: 1cm))
#set text(lang: "en")

#transl(data: read("/src/l10n/en.ftl"), lang: "en")
#storage.add("draft", true, namespace: "min-book")


#lorem(20)
#comment[Margin comment.] #lorem(10)
#comment(type: box)[Inline comment.] #lorem(10)
#comment(type: block)[Block comment.] #lorem(10)
#comment(stroke: red + 2pt)[Red comment.] #lorem(10)


#line()

#lorem(20)
#mark[Marked text] #lorem(10)
#mark(red)[Red marked text] #lorem(10)


#line()

#event(date: datetime(year: 2027, month: 05, day: 01))[Event]

#lorem(20)

#event(date: datetime(year: 2026, month: 05, day: 29))[Event]

#lorem(20)

#event(alt: "September 29, 3021 TA", date: 330210929)[Fictional Event]


#line()

#scene(
  location: "Rivendel",
  mood: "Solemn",
  characters: "Aragorn, Boromir"
)

#lorem(20)

#scene(
  pov: "Gimly",
  location: "Lórien",
  mood: "Lovely",
  characters: "Galadriel, Gimly"
)


#pagebreak()

#set page(margin: 1cm)

#comment-list()
#event-timeline()
#scene-list()