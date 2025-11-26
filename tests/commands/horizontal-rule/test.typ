#import "/src/lib.typ": horizontalrule, hr, themes
#set page(height: auto)
#let args = ( (cover: auto), (styling: (:)) )

#show <horizontalrule:insert>: themes.stylish.horizontalrule(..args)


#lorem(100)

#horizontalrule()

#lorem(100)

#hr()

#lorem(100)