#import "/src/lib.typ": themes
#set page(height: auto)
#let args = ( (cover: auto), (styling: (:)) )


#show divider: themes.stylish.divider(..args)

#lorem(100)

#divider()

#lorem(100)


#show divider: themes.coffee.divider(..args)

#divider()

#lorem(100)


#show divider: themes.elegance.divider(..args)

#divider()

#lorem(100)