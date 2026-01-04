#import "@preview/min-manual:0.3.0": manual, url

#show: manual.with(
  title: "Minimal Books",
  logo: image("docs/assets/manual-logo.png"),
  manifest: toml("typst.toml"),
  from-comments:
    read("src/lib.typ") +
    read("src/commands/notes.typ") +
    read("src/commands/ambients.typ") +
    read("src/commands/horizontalrule.typ") +
    read("src/commands/blockquote.typ")
)


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.