/**
== Annotation Tools

=== Comments


**/

#let comment(..args, type: auto) = context {
  import "@preview/nexus-tools:0.1.0": storage
  import "@preview/drafting:0.2.2"
  
  if not storage.get("draft", true, namespace: "min-book") {return}
  
  set text(hyphenate:  true, size: text.size - 1pt)
  
  let pos = args.pos()
  let named = args.named()
  
  // Set default box stroke
  if not "stroke" in named.keys() {named.insert("stroke", gray.lighten(30%))}
  
  if type == auto {
    // Margin comments cannot be justified text due to lack of space
    
    drafting.margin-note(
      par(pos.at(0), justify: false),
      ..named
    )
  }
  else if type in (block, box) {
    if type == box {named.insert("par-break", false)}
    
    
    drafting.inline-note(
      pos.at(0),
      ..named
    )
  }
  else {panic("Invalid comment type: " + repr(type))}
}


#let mark(..args) = context {
  import "@preview/nexus-tools:0.1.0": storage
  import "../utils.typ"
  
  let pos = args.pos()
  let named = args.named()
  let text-color = text.fill
  let luminance
  let components
  let background
  let data
  
  assert.eq(named, (:), message: "Invalid named arguments")
  assert(pos.len() <= 2, message: "Expected only 2 pisitional arguments")
  
  if pos.len() == 1 {
    luminance = utils.relative-luminance(text.fill)
    background = if luminance < 0.55 {gray.lighten(50%)} else {gray.darken(50%)}
    data = pos.at(0)
  }
  else {
    background = pos.at(0)
    data = pos.at(1)
  }
  
  if not storage.get("draft", true, namespace: "min-book") {return data}
  
  luminance = utils.relative-luminance(background)
  
  
  // White text when using a dark background
  if luminance < 0.55 {text-color = white}
  
  set text(fill: text-color)
  
  box(data, fill: background, outset: 2pt)
}