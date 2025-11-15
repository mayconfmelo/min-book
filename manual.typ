// NAME: Manual for min-book

#import "@preview/min-manual:0.2.2": manual, arg, univ, url

#show: manual.with(
  title: "Minimal Books",
  logo: image("docs/assets/manual-logo.png"),
  manifest: toml("typst.toml"),
  from-comments:
    read("src/lib.typ") +
    read("src/additional/notes.typ") +
    read("src/additional/ambient.typ") +
    read("src/additional/horizontalrule.typ") +
    read("src/additional/blockquote.typ")
)


= Translation

Currently, _min-book_ supports automatic translation for all languages
represented by a file in `/src/l10n/` directory. When using other languages,
just create a custom Fluent translation file and set it as `#book(cfg.transl)`.
If no translation file is found or set for the language used, _min-book_ will
`#panic`.

Also consider contributing to the _min-book_ project by submitting a translation
pull request or even opening an issue — since most of the
supported languages were originally translated by IA and may contain errors.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.