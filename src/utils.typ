// Handles book numbering
#let numbering(
  pattern,
  scope: (:),
) = (..level) => context {
  import "@preview/numbly:0.1.0": numbly
  import "orig.typ"
  
  let after-toc = query(selector(<toc:inserted>).before(here())) != ()
  let pattern = pattern
  let scope = scope
  let level = level.pos()
  
  if pattern == none {return none}
  if pattern.at(level.len() - 1, default: "") == none {return none}
  if type(pattern) == str {
    if not pattern.contains(regex("[{}]")) {
      return {
        orig.numbering(pattern, ..level)
        
        if not after-toc {h(0.5em)}
      }
    }
    
    pattern = (pattern,)
  }
  
  scope.part = scope.at("part", default: none)
  scope.chapter = scope.at("chapter", default: "Foo")
  
  if after-toc {
    if scope.part != none and pattern.len() >= 1 {
      pattern.at(0) = scope.part + " " + pattern.at(0) // set part (level 1)
      
      if scope.part == "" {pattern.at(0) = ""}
      if scope.chapter != none and pattern.len() >= 2 {
        if scope.chapter != "" {scope.chapter += " "}
        
        pattern.at(1) = scope.chapter + pattern.at(1) // set chapter (level 2)
      }
    }
    else if scope.chapter != none and pattern.len() >= 1 {
      if scope.chapter != "" {scope.chapter += " "}
      
      pattern.at(0) = scope.chapter + pattern.at(0) // set chapter (level 1)
    }
  }
  else {
    pattern = pattern.map(
      item => if type(item) == str { item.trim(regex("\n+")) }
    )
  }
  
  
  numbly(default: "I.I.1.1.1.a", ..pattern)(..level)
  
  if not after-toc {h(0.5em)} // gap between numbering and title in TOC
}


// Generate #transl Fluent database for standard languages
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