<div align="center">
  <h1>Themes</h1>
</div>

_Theme support is currently experimental and in early stages of development;
therefore, any type of errors may occur._

## Stylish (default)

![cover](assets/theme-stylish.png)

Typography and formatting inspired by traditional designs, with a touch of
modernity. The default theme, no need to set it.
```typst
#import "@preview/min-book:1.4.0": book
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
      hr-spacing: value),
    numbering: value,
  )
)
```

Options:

<dl>
  <dt><strong><code>cfg.cover.page:</code></strong></dt>
  <dd>Cover <code>#page</code> options (<em>color</em> or <em>dictionary</em>).</dd>
  
  <dt><strong><code>cfg.cover.title:</code></strong></dt>
  <dd>Cover title <code>#text</code> options (<em>color</em> or <em>dictionary</em>).</dd>
  
  <dt><strong><code>cfg.cover.text:</code></strong></dt>
  <dd>Cover <code>#text</code> options (<em>color</em> or <em>dictionary</em>).</dd>
   
  <dt><strong><code>cfg.cover.back:</code></strong></dt>
  <dd>Enables a back cover at the end of the document (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.reset:</code></strong></dt>
  <dd>Reset defaults back to Typst defaults (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.std-toc:</code></strong></dt>
  <dd>Use default <code>#outline</code> appearance (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.hr-spacing:</code></strong></dt>
  <dd>Set spacing before and after the horizontal rule (<em>length</em>).</dd>
  
  <dt><strong><code>cfg.numbering:</code></strong></dt>
  <dd>Heading <em><a href="https://www.typst.app/universe/package/numbly/">
    numbly</a></em> numbering (<em>string</em> or <em>array</em>)</dd>
</dl>

<details><summary>Default fonts:</summary>

**Text:**
[TeX Gyre Pagella](https://www.gust.org.pl/projects/e-foundry/tex-gyre/pagella/qpl2_501otf.zip) or
Book Antiqua
  
**Math:**
[Asana Math](https://mirrors.ctan.org/fonts/Asana-Math/Asana-Math.otf)
  
**Mono:**
[Inconsolata](https://fonts.google.com/specimen/Inconsolata)

**Cover title:**
[Cinzel](https://fonts.google.com/specimen/Cinzel)
    
**Cover text:**
[Alice](https://fonts.google.com/specimen/Alice)

</details>


## Coffee

![cover](assets/theme-coffee.png)

Confortable fonts in cozy pastel colors for creative writing.
```typst
#import "@preview/min-book:1.4.0": book, themes
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
      std-toc: value,
      hr-spacing: value),
    numbering: value,
  )
)
```

Options:

<dl>
  <dt><strong><code>cfg.theme:</code></strong></dt>
  <dd>Set <em>min-book</em> theme (<em>module</em>).</dd>
  
  <dt><strong><code>cfg.cover.page:</code></strong></dt>
  <dd>Cover <code>#page</code> options (<em>dictionary</em>).</dd>
  
  <dt><strong><code>cfg.cover.text:</code></strong></dt>
  <dd>Cover <code>#text</code> options (<em>dictionary</em>).</dd>
  
  <dt><strong><code>cfg.cover.back:</code></strong></dt>
  <dd>Enables back cover at the end of the document (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.cover.flavor:</code></strong></dt>
  <dd>Catppuccin cover color scheme: <code>"latte"</code>, <code>"frappé"</code>,
  <code>"macchiato"</code>, <code>"mocha"</code>.</dd>
  
  <dt><strong><code>cfg.styling.flavor:</code></strong></dt>
  <dd>Catppuccin book color scheme: <code>"latte"</code>, <code>"frappé"</code>,
  <code>"macchiato"</code>, <code>"mocha"</code>.</dd>
  
  <dt><strong><code>cfg.styling.reset:</code></strong></dt>
  <dd>Reset defaults back to Typst defaults (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.std-toc:</code></strong></dt>
  <dd>Use default <code>#outline</code> appearance (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.hr-spacing:</code></strong></dt>
  <dd>Set spacing before and after the horizontal rule (<em>length</em>).</dd>

  <dt><strong><code>cfg.numbering:</code></strong></dt>
  <dd>Heading <em><a href="https://www.typst.app/universe/package/numbly/">
    numbly</a></em> numbering (<em>string</em> or <em>array</em>)</dd>
</dl>

<details><summary>Default fonts:</summary>

**Text:**
[Nunito](https://fonts.google.com/specimen/Inconsolata)
  
**Headings:**
[Jellee](https://www.fontsquirrel.com/fonts/jellee)

**Mono:**
[Source Code Pro](https://fonts.google.com/specimen/Source+Code+Pro) or
[Fira Mono](https://fonts.google.com/specimen/Fira+Mono)

</details>


## Elegance

![cover](assets/theme-elegance.png)

Modern typography and minimal visuals, without unnecessary visual clutter.
```typst
#import "@preview/min-book:1.4.0": book, themes
#show: book.with(
  cfg: (
    theme: themes.elegance,
    cover: (
      page: value,
      title: value,
      text: value,
      back: value,
      image: value,
      publisher: value),
    styling: (
      reset: value,
      std-toc: value,
      hr-spacing: value),
    part-toc: value,
    numbering: value,
  )
)
```

Options:

<dl>
  <dt><strong><code>cfg.theme:</code></strong></dt>
  <dd>Set <em>min-book</em> theme (<em>module</em>).</dd>
  
  <dt><strong><code>cfg.cover.page:</code></strong></dt>
  <dd>Cover <code>#page</code> options (<em>dictionary</em>).</dd>
  
  <dt><strong><code>cfg.cover.title:</code></strong></dt>
  <dd>Cover title <code>#text</code> options (<em>dictionary</em>).</dd>
  
  <dt><strong><code>cfg.cover.text:</code></strong></dt>
  <dd>Cover <code>#text</code> options (<em>dictionary</em>).</dd>
  
  <dt><strong><code>cfg.cover.back:</code></strong></dt>
  <dd>Enables back cover at the end of the document (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.cover.image:</code></strong></dt>
  <dd>Cover main image.</dd>
  
  <dt><strong><code>cfg.cover.publisher:</code></strong></dt>
  <dd>Cover publisher logo/name (<em>image</em> or <em>content</em>).</dd>
  
  <dt><strong><code>cfg.styling.reset:</code></strong></dt>
  <dd>Reset defaults back to Typst defaults (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.std-toc:</code></strong></dt>
  <dd>Use default <code>#outline</code> appearance (<em>boolean</em>).</dd>
  
  <dt><strong><code>cfg.styling.hr-spacing:</code></strong></dt>
  <dd>Set spacing before and after the horizontal rule (<em>length</em>).</dd>
  
  <dt><strong><code>cfg.part-toc:</code></strong></dt>
  <dd>Enables mini table of contents in part headings (<em>boolean</em>).</dd>

  <dt><strong><code>cfg.numbering:</code></strong></dt>
  <dd>Heading <em><a href="https://www.typst.app/universe/package/numbly/">
    numbly</a></em> numbering (<em>string</em> or <em>array</em>)</dd>
</dl>

<details><summary>Default fonts:</summary>

**Text:**
[TeX Gyre Heros](https://fonts.google.com/specimen/Inconsolata)
  
**Headings:**
[TeX Gyre Adventor](https://www.fontsquirrel.com/fonts/jellee)

**Mono:**
[Source Code Pro](https://fonts.google.com/specimen/Source+Code+Pro) or
[Fira Mono](https://fonts.google.com/specimen/Fira+Mono)

**Math:**
[TeX Gyre Pagella Math](https://www.gust.org.pl/projects/e-foundry/tg-math/download/texgyrepagella-math-1632.zip) or
[Asana Math](https://mirrors.ctan.org/fonts/Asana-Math/Asana-Math.otf)

</details>

Default cover image: [Harpia Brasieira](https://www.deviantart.com/psychosk1/art/Harpia-Brasileira-864239992)
© Psychosk1  
This cover image: [_Rio Memórias_](https://riomemorias.com.br/memoria/machado-de-assis/)


# Create a Theme
Creating a theme should be quite easy by just following these steps:


#### 1. Write Typst functions in a file

The theming system uses special functions to customize specific aspects of the
book; your custom theme can provide all of these functions or inherit them from
other themes through import. The currently supported functions are as follows:

```typst
#import "@preview/min-book:1.4.0": themes
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
  <dd>General formating. Receives 3 items: metadata (<em>dictionary</em>),
  configurations (<em>dictionary</em>), and book content (<em>content</em>);
  must return <em>content</em>.</dd>

  <dt><strong><code>cover-page()</code></strong></dt>
  <dd>Book cover page. Receives 2 items: metadata (<em>dictionary</em>) and
  configurations (<em>dictionary</em>); must return <em>content</em>.</dd>

  <dt><strong><code>title-page()</code></strong></dt>
  <dd>Book title page. Receives 2 items: metadata (<em>dictionary</em>) and
  configurations (<em>dictionary</em>); must return <em>content</em>.</dd>
  
  <dt><strong><code>part-page()</code></strong></dt>
  <dd>Book part heading. Receives 3 items: metadata (<em>dictionary</em>),
  configurations (<em>dictionary</em>), and part content (<em>heading</em>);
  must return <em>content</em>.</dd>
  
  <dt><strong><code>horizontalrule()</code></strong></dt>
  <dd>Horizontal rule. Receives 2 items: metadata (<em>dictionary</em>) and
  configurations (<em>dictionary</em>); must return <em>content</em>.</dd>
</dl>

Check the built-in themes in `src/themes/` to get a practical reference on how
to write the theme code; however, any code structure can be used as long as the
required data types are returned.


#### 2. Import file as Typst module

Insert the file into a Typst project or publish it to Typst Universe, then import
it into the project as a Typst module and set the whole module as value for
`#book(cfg.theme)` option:

```typst
#import "custom-theme.typ"
#show: book.with(
  cfg: (theme: custom-theme)
)
```

The theming system will use the appropriate functions to apply the created custom
theme (additional code and functions will be just ignored).


#### 3. Enjoy!

After importing and defining the theme, the book will be automatically compiled with
a fresh new look! 

<style>
img {max-width: 100%; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.5)}
</style>