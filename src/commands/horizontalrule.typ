/**
== Horizontal Rule
:horizontalrule:
Adds a horizontal rule, visual separators used to distinguish subtle changes
of subject in extensive texts.
**/
#let horizontalrule(
  spacing: 1.5em, /// <- length
    /// Vertical space before and after the horizontal rule. |
) = context {
  import "@preview/toolbox:0.1.0": storage
  
  let std = align(center, image("../themes/stylish/hr.svg", width: 50%))
  let body = storage.final("themes", (:), namespace: "min-book")
  
  v(spacing, weak: true)
  body.at("hr", default: std)
  v(spacing, weak: true)
}


/// The `#horizontalrule` command is also available as the smaller `#hr` alias.
#let hr = horizontalrule