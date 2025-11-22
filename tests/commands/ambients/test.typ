#import "/src/lib.typ": book, appendices, annexes

#set text(font: ("libertinus serif", "new computer modern"))
#set page(height: auto, margin: 2cm, footer: none)

#show: book.with(
  title: "", authors: "", cover: none, titlepage: none, toc: false,
  cfg: (two-sided: false),
  part: none, // continuous appendices/annexes (no #pagebreak)
)


#appendices[
  = One Appendix
  #lorem(50)
  == Section
  #lorem(50)
  
  = Another Appendix
  #lorem(50)
  == Section
  #lorem(50)
]


#annexes[
  = One Annex
  #lorem(50)
  == Section
  #lorem(50)
  
  = Another Annex
  #lorem(50)
  == Section
  #lorem(50)
]