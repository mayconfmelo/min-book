#import "/src/lib.typ": book

#set outline(depth: 4, indent: 1.5em)
#set text(lang: "pt", region: "BR")

#let other = (title: "", authors: "", cover: none, titlepage: none, chapter: none)


#show: book.with(
  cfg: (
    numbering: ("{1:1}. ", "{1:1}.{2:a}. ", "{1:1}.{2:a}.{3:i}. "),
    transl: (
      en-US: "part = Division\nchapter = Chapter",
      pt-BR: "part = Divisão\nchapter = Capítulo",
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


#set text(lang: "en", region: "US")

= Heading
== Heading
=== Heading
==== Heading