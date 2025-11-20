/**
== Appendices
:appendices:
Creates an special ambient to write or include multiple appendices. An
appendix is any important additional data left out of the main document for
some reason, but directly referenced or needed by it. Inside this ambient,
all level 1 heading is a new appendix.
**/
#let appendices(
  body, /// <- content
    /// The appendices ambient. |
  title: auto, /// <- array of strings | auto
    /// `(singular, plural)`\ Title for each appendix and for Appendices section. |
  numbering: ( /// <- array of strings | string
    "",
    "{2:A}.\n",
    "{2:A}.{3:1}. ",
    "{2:A}.{3:1}.{4:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  ),
    /// Custom appendices numbering (uses #univ("numbly") package). |
  type: "appendix",
) = context {
  import "../utils.typ"
  import "@preview/transl:0.2.0": transl
  import "@preview/toolbox:0.1.0": storage
  
  let singular-title = transl(type, number: "sing", mode: str)
  let plural-title = transl(type, number: "plur", mode: str)
  let break-to = storage.get("break-to", namespace: "min-book")
  
  set heading(
    offset: 1,
    supplement: singular-title,
    numbering: utils.numbering(
      patterns: (numbering,),
      scope: (
        h1: "",
        h2: singular-title,
        n: 1
      )
    ),
  )
  
  show heading.where(level: 2): it => {
    pagebreak(to: break-to)
    it
  }
  
  pagebreak(weak: true, to: break-to)
  
  // Appendices title
  heading(
    plural-title,
    level: 1,
    numbering: none
  )
  
  counter(heading).update(0)
  
  body
}


/** 
== Annexes Command
:annexes:
Creates an special ambient to write or include multiple annexes. An annex is
any important third-party data directly cited or referenced in the main
document. Inside this ambient, all level 1 heading is a new annex.
**/
#let annexes(
  body, /// <- content
    /// The annexes ambient. |
  title: auto, /// <- array of strings | auto
    /// `(singular, plural)`\ Title for each annex and for Annexes section. |
  numbering: ( /// <- array of strings | string
    "",
    "{2:A}.\n",
    "{2:A}.{3:1}. ",
    "{2:A}.{3:1}.{4:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}. ",
    "{2:A}.{3:1}.{4:1}.{5:1}.{6:a}. ",
  ),
    /// Custom annexes numbering (uses #univ("numbly") package). |
) = appendices(
  type: "annex",
  title: title,
  numbering: numbering,
  body
)
