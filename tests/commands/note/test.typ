#import "/src/lib.typ": note, book
#import "@preview/toolbox:0.1.0": storage

#set page(height: auto, width: 13.5cm, margin: 2cm, footer: none)
#set par(leading: 0.7em, spacing: 1.3em, first-line-indent: 0.0001pt)
#set text(font: ("libertinus serif", "new computer modern"))
#show raw: set text(font: ("dejavu sans mono", "libertinus serif"))

#show: book.with(
  title: "", authors: "", part: none, cover: none, titlepage: none, toc: none,
  cfg: (numbering: none, two-sided: false, cover: (back: false))
)

// Note storage representation
#page(
  context raw(
    lang: "yaml",
    yaml.encode(
      storage.final("note", namespace: "min-book")
    )
  ),
  width: auto,
  margin: 1em,
)


= Current Heading

Foo#note[Note of foo] blah blah, blah blah blah blah blah, blah blah blah.

Blah blah bar,#note[Note of bar] blah blah blah blah blah: blah blah blah.

Blah blah blah, blah blah baz#note[Note of baz] blah blah blah blah blah.

Blah qux#note[Note of qux] blah blah; blah blah quz,#note[Note of quz]
blah qward#note(numbering: "a")[Note of qward] blah.

Blah blah blah. Blah blah blah blah, blah blah corge!#note[Note of corge]

Blah blah blah blah blah blah blah blah grault,#note[Note of grault]
garply.#note[Note of garply]


// Notes of current heading appear here (before next heading)
= Next Heading

Foobar#note[Note of foobar] blah blah, blah blah blah blah, blah blah blah.


// Notes of next heading appear here (at the end of the document)