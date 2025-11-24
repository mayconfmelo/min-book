#import "/src/lib.typ": book

#set outline(depth: 4, indent: 1.5em)
#set text(lang: "pt", region: "BR", font: ("libertinus serif", "new computer modern"))

#let other = (title: "", authors: "", cover: none, titlepage: none, chapter: none)


#show: book.with(
  cfg: (
    numbering: ("{1:1}.\n", "{1:1}.{2:a}.", "{1:1}.{2:a}.{3:i}."),
    transl: (
      en-US: read("en-US.ftl"),
      pt-BR: read("pt-BR.ftl"),
    ),
    typst-defaults: true,
    std-toc: true,
    chapter-continuous: false,
    two-sided: false,
    paper-friendly: false,
  ),
  ..other,
)

= Heading
== Heading
=== Heading
==== Heading
#link("https://example.com")[This is a default, non paper-friendly link.]

= Heading
== Heading
=== Heading
==== Heading