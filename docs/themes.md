<div align="center">
  <h1>Themes</h1>
</div>

_Theme support is currently experimental and in early stages of development;
therefore, any type of errors may occur._

## Stylish

![cover](assets/theme-stylish.png)

The default _min-book_ theme; no need to set it.
```typst
#import "@preview/min-book:1.3.0": book
#show: book.with(
  cfg: (
    cover: (
      page: value,
      title: value,
      text: value,
      back: value),
    styling: (
      reset: value,
      std-toc: value,
      hr: (spacing: value)),
  )
)
```

Options:

<dl>
  <dt><strong><code>cfg.cover.page:</code></strong></dt>
  <dd>Cover <code>#page</code> <em>color</em>, or a <em>dictionary</em> of options.</dd>
  
  <dt><strong><code>cfg.cover.title:</code></strong></dt>
  <dd>Cover title <code>#text</code> <em>color</em>, or a <em>dictionary</em> of options.</dd>
  
  <dt><strong><code>cfg.cover.text:</code></strong></dt>
  <dd>Cover <code>#text</code> <em>color</em>, or a <em>dictionary</em> of options.</dd>
   
  <dt><strong><code>cfg.cover.back:</code></strong></dt>
  <dd>Generate back cover from cover template (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.reset:</code></strong></dt>
  <dd>Reset back to Typst defaults (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.std-toc:</code></strong></dt>
  <dd>Reset to default <code>#outline</code> appearance (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.hr.spacing:</code></strong></dt>
  <dd>Set <em>length</em> of the spaces before and after the horizontal rule.</dd>
</dl>


## Coffee

![cover](assets/theme-coffee.png)

Confortable fonts in cozy pastel colors for creative writing.
```typst
#import "@preview/min-book:1.3.0": book, themes
#show: book.with(
  cfg: (
    theme: themes.coffee,
    cover: (
      page: value,
      text: value,
      back: value,
      flavor: value),
    styling: (
      flavor: value,
      reset: value,
      hr: (spacing: value)),
  )
)
```

Options:

<dl>
  <dt><strong><code>cfg.themes:</code></strong></dt>
  <dd>Set <em>min-book</em> theme (<em>module</em>).</dd>
  
  <dt><strong><code>cfg.cover.page:</code></strong></dt>
  <dd>Cover <code>#page</code> <em>color</em>, or a <em>dictionary</em> of options.</dd>
  
  <dt><strong><code>cfg.cover.text:</code></strong></dt>
  <dd>Cover <code>#text</code> <em>color</em>, or a <em>dictionary</em> of options.</dd>
  
  <dt><strong><code>cfg.cover.back:</code></strong></dt>
  <dd>Generate back cover from cover template (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.cover.flavor:</code></strong></dt>
  <dd>Catppuccin cover color scheme: <code>"latte"</code>, <code>"frappé"</code>,
  <code>"macchiato"</code>, <code>"mocha"</code>.</dd>
  
  <dt><strong><code>cfg.styling.flavor:</code></strong></dt>
  <dd>Catppuccin book color scheme: <code>"latte"</code>, <code>"frappé"</code>,
  <code>"macchiato"</code>, <code>"mocha"</code>.</dd>
  
  <dt><strong><code>cfg.styling.reset:</code></strong></dt>
  <dd>Reset back to Typst defaults (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.hr.spacing:</code></strong></dt>
  <dd>Set <em>length</em> of the spaces before and after the horizontal rule.</dd>
</dl>


## Elegance

![cover](assets/theme-stylish.png)


```typst
#import "@preview/min-book:1.3.0": book, themes
#show: book.with(
  theme: themes.elegance,
)
```


# Create a Theme
Creating a theme should be quite easy by just following these steps:

**1. Write Typst functions in a file:** There are four predefined functions used
for theme customization, and one function for customizing the `#horizontalrule`
command. If any of these functions are omitted, it will be necessary to inherit
them from another theme by importing it.

```typst
#import "@preview/min-book:1.3.0": themes
#import themes.styling: *  // inheritance

#let styling(meta, cfg, body) = { }

#let cover-page(meta, cfg) = { }

#let title-page(meta, cfg) = { }

#let part-page(meta, cfg, heading) = { }

#let horizontalrule(meta, cfg) = { }
```

Functions: 
<dl>
  <dt><strong><code>styling()</code></strong></dt>
  <dd>General theme formating. Receives book metadata (<code>meta</code> dictionary),
  configurations (<code>cfg</code> dictionary), and book content
  (<code>body</code>); must return book content.</dd>

  <dt><strong><code>cover-page()</code></strong></dt>
  <dd>Book cover page. Receives book metadata (<code>meta</code> dictionary) and
  cover configurations (<code>cfg</code> dictionary); must return cover content.</dd>

  <dt><strong><code>title-page()</code></strong></dt>
  <dd>Book title page. Receives book metadata (<code>meta</code> dictionary) and
  cover configurations (<code>cfg</code> dictionary); must return title page content.</dd>
  
  <dt><strong><code>part-page()</code></strong></dt>
  <dd>Book part content. Receives book metadata (<code>meta</code> dictionary),
  configurations (<code>cfg</code> dictionary), and part <code>heading</code>;
  must return the part heading content.</dd>
  
  <dt><strong><code>horizontalrule()</code></strong></dt>
  <dd>horizontal rule content. Receives book metadata (<code>meta</code> dictionary)
  and configurations (<code>cfg</code> dictionary); must return horizontal rule
  content.</dd>
</dl>

**2. Save the file:** Insert the file into a Typst project or publish it to
Typst Universe.

**3. Import and set:** Import the saved file as a module and set the whole module
as value for `#book(cfg.theme)` option.

```typst
#import "my-theme.typ"
#show: book.with(
  cfg: (
    theme: my-theme)
)
```

**4. Enjoy!** Now you have all _min-book_ features in a book with a fresh new look!

Check the default themes in `src/themes/` for more practical information.


<style>img {max-width: 100%}</style>