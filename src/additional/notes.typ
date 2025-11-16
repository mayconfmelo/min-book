/**
== Note Command

:note:

Adds an end note, an alternative for footnotes but placed inside of the page
instead of its margins. End notes appear at its own page at the end of the
current section, right before the next heading.
**/
#let note(
  numbering: auto, /// <- auto | string
    /// Custom note numbering — a standard numbering string. |
  content, /// <- content <required>
    /// The content of the end note. |
) = context {
  import "../utils.typ"
  import "../orig.typ"
  import "@preview/toolbox:0.1.0": storage
  
  // Find the level (numbering) of current section heading:
  let selector = selector(heading).before(here())
  let level = counter(selector).display()
  let count = counter("min-book-notes")
  let numbering = numbering
  
  if numbering == auto {
    numbering = storage.get("note.numbering", "1", namespace: "min-book")
  }
  else {
    storage.add("note", (numbering: numbering), namespace: "min-book")
  }
  
  count.step()
  
  let this-note = (
    number: count.get().at(0),
    data: content,
    numbering: numbering
  )
  
  // Push the note data to storage
  storage.this.update(curr => {
    if curr.at("min-book").at("note", default: (:)) == (:) {
      curr.at("min-book").insert("note", (:))
    }
    if curr.at("min-book").note.at(level, default: ()) == () {
      curr.at("min-book").note.insert(level, ())
    }
    
    //let this = (:).insert(level, this-number)
    
    curr.at("min-book").note.at(level).push(this-note)
    curr
  })
  
  let this-number = orig.numbering(numbering, ..count.get())
  let this-label = level + "-" + count.display()

  // Set note as #super[NUMBER ::LABEL::] to be managed later
  [#super(this-number + " ::" + this-label + "::")#label(this-label)]
}


// INTERNAL: notes.insert() inserts notes in the document at the right place.
#let insert(body) = {
  import "@preview/toolbox:0.1.0": storage, its
  import "../utils.typ"

  let new-body = body.at("children", default: ())
  let h-index = ()
  
  // Get index of all headings in body.children
  for n in range(new-body.len()) {
    let item = new-body.at(n)
    
    if item.func() == heading {
      h-index.push(n)
    }
  }

  // Insert anchor <note> before each heading obtained
  for n in range(h-index.len()) {
    new-body.insert(h-index.at(n) + n, [#metadata("Note anchor") <note>])
  }

  // Insert a final anchor <note> at the end of the document
  new-body.push([#metadata("Note anchor") <note>])

  // Make the edited new-body into the document body
  body = new-body.join()

  // Make the first note be note 1, instead of note 0.
  counter("min-book-notes").step()

  // Swap the <note> for the actual notes in the current section, if any.
  show <note>: it => context {
    let stored = storage.final("note", (), namespace: "min-book")
    
    if not its.empty(stored) {
      // Find the level (numbering) of current section heading:
      let selector = selector(heading).before(here())
      let level = counter(selector).display()
      
      stored = stored.at(level, default: ())

      // Show notes only if there are any in this section
      if not its.empty(stored) {
        pagebreak(weak: true)

        // Insert the notes:
        for note in stored {
          par(
            first-line-indent: 0pt,
            spacing: 0.75em,
            hanging-indent: 1em
          )[
            // Link to the note marker in the text:
            #link(
              label(level + "-" + str(note.number)),
              strong(utils.numbering-std(note.numbering, note.number) + ":")
            )
            // Insert <LEVEl_NUMBER_content> for cross-reference
            #label(level + "-" + str(note.number) + "-content")
            #note.data
          ]
        }

        pagebreak(weak: true)
      }

      // Make every section notes start at note 1
      counter("min-book-notes").update(1)
    }
  }
  
  // Manages note references
  show super: it => {
    let note-regex = regex("::[0-9-_]+::")
    
    // #note: Parses #super("NUMBER ::LABEL::") -> #link(<LABEL>)[#super("NUMBER")]
    if it.body.text.ends-with(note-regex) {
      let note-label = it.body.text.find(note-regex).trim(":") + "-content"
      let note-number = it.body.text.replace(note-regex, "").trim()
      
      // Link to the actual note content:
      link(label(note-label))[#super(note-number)]
    } else {
      it
    }
  }
  
  body
}