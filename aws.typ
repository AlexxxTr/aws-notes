#import "@preview/zero:0.5.0": set-group

#set-group(separator: "'", threshold: 4)

#show link: underline

#set document(title: [AWS Notes])
#set page(
  footer: context [
    #line(length: 100%)
    *AWS Notes*
    #h(1fr)
    #counter(page).display("1/1", both: true)
  ],
)
#set heading(numbering: "1.", depth: 3)
#set text(font: "Arial")

#align(center)[
  #text(size: 24pt, weight: "bold")[
    AWS Notes
  ]
]

#outline(depth: 3)

#pagebreak()

#outline(title: "Figures", target: figure.where(kind: image))

#pagebreak()

#include "./iam.typ"
#pagebreak()
#include "./sts.typ"
#pagebreak()
#include "./ram.typ"
#pagebreak()
#include "./service-quota.typ"
#pagebreak()
#include "./virtualization.typ"
