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


= Translation

Currently, _min-book_ supports automatic translation for all languages
represented by a file in `/src/l10n/` directory. When using other languages,
just create a custom Fluent translation file and set it as `#book(cfg.transl)`.
If no translation file is found or set for the language used, _min-book_ will
`#panic`.

Also consider contributing to the _min-book_ project by submitting a translation
pull request or even opening an issue — since most of the
supported languages were originally translated by IA and may contain errors.


= Themes

#show raw: set block(breakable: false)

Built-in themes are provided under the `themes` module for quick customization
of project appearance. To apply a theme, import it as a module and set its option:
```typ
#import "@preview/min-manual:1.4.0": book, themes
#show: book.with(
  cfg: (theme: themes.default)
)
```

It is also possible to create custom themes to suit your project needs. For more
information about built-in and custom themes, please check the 
#url("https://github.com/mayconfmelo/min-book/blob/main/docs/themes.md",
`docs/themes.md`) file.


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software: you are free to change and redistribute
it.  There is NO WARRANTY, to the extent permitted by law.

The logo was obtained from #link("https://flaticon.com")[Flaticon] website.