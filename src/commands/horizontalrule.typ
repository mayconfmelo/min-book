/**
== Horizontal Rule
:horizontalrule:
Adds a horizontal rule, visual separators used to distinguish subtle changes
of subject in extensive texts.
**/
#let horizontalrule(
  spacing: 1.5em, /// <- length
    /// Vertical space before and after the horizontal rule. |
) = [#metadata("hr placeholder") <horizontalrule:insert>]


/// The `#horizontalrule` command is also available as the smaller `#hr` alias.
#let hr = horizontalrule