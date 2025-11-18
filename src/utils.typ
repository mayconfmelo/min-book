
// Handles book numbering
#let numbering(
  patterns: (),
  scope: (:),
) = (
  ..nums
) => context {
  import "@preview/numbly:0.1.0": numbly
  import "orig.typ"

  // Set #patterns final value
  let patterns = if patterns.at(0) != auto {patterns.at(0)}
    else if scope.h1 != none {patterns.at(1, default: none)}
    else {patterns.at(2, default: none)}
  let scope = scope
  
  // Set all numbering to none
  if patterns == none {return none}
  
  // Convert string patterns into array
  if type(patterns) == str {patterns = (patterns,)}
  
  // Transform patterns into positional arguments
  patterns = arguments(..patterns).pos()
  
  // Defines whether the heading being numbered is before or after TOC
  let after-toc = query(selector(label("outline")).before(here())) != ()

  // When using a default numbering string:
  if patterns.len() == 1 and not patterns.at(0).contains(regex("\{.*\}")) {
    return {
      orig.numbering(..patterns, ..nums)
      if not after-toc {h(0.5em)}
    }
  }
  
  // When numbering-style == none
  if patterns == () {
    if scope.h1 != none {
      patterns.push("\n")
      scope.h1 = scope.h1 + ":"
    }
    if scope.h2 != none {
      patterns.push("\n")
       scope.h2 = scope.h2 + ":"
    }
  }
  
  
  if after-toc {
    if scope.h1 != none and patterns.len() >= 1 {
      // Heading level 1 become part
      patterns.at(0) = scope.h1 + " " + patterns.at(0)
  
      // Heading level 2 become chapter
      if scope.h2 != none and patterns.len() >= 2 {
        patterns.at(1) = scope.h2 + " " + patterns.at(1)
      }
    } else {
      let n = scope.at("n", default: 0)
      
      // Heading level 1 become chapter, if no part
      if scope.h2 != none and patterns.len() >= 1 {
        patterns.at(n) = scope.h2 + " " + patterns.at(n)
      }
    }
  }
  else {
    let contents = ()
    
    for pattern in patterns {
      // Remove any "\n" at the end of numbering patterns:
      if type(pattern) == str {pattern = pattern.trim(regex("\n+$"))}
      
      contents.push(pattern)
    }
    patterns = contents
  }

  // HACK: #book(part: "") defines title-only parts, without name nor numbering.
  if scope.h1 == "" {
    patterns.at(0) = ""
  }
  
  // Set the numbering for current level to none
  if patterns.at(nums.pos().len() - 1, default: "") == none {return none}
  
  // Get numbering using numbly
  numbly(default: "I.I.1.1.1.a", ..patterns)(..nums)
  
  // Numbering-title gap in TOC
  if not after-toc {h(0.5em)}
}

// Languages with support for automatic translation

#let std-langs() = {
  let database = (l10n: "ftl")
  let langs = (
    "en", "pt", "la", "zh", "hi", "es", "ar", "fr", 
    "bn", "ru", "ur", "id", "de", "ja", "it",
  )
  
  for lang in langs {
    database.insert(lang, read("l10n/" + lang + ".ftl"))
  }
  return database
}