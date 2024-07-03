#import "@local/typkit:0.1.0": *
#import "meta-content-layouts/simple.typ": simple-meta-layout
// #import "meta-content-layouts/extended.typ": extended-meta-content
// TODO


#let dialogue-layout(dialogue-items, body-width: auto, row-gutter: 15pt, spacing: 0.8em) = {
  set table.cell(breakable: false)
  set block(breakable: false)
  show par: set block(spacing: spacing )

  table(
    column-gutter: 10pt,
    columns: (auto, body-width),
    stroke: none,
    row-gutter: row-gutter,
    ..dialogue-items,
  )
}
#let dialogue(dialogue, metadata) = {
  let margin = (top: 1in, left: 1in, right: 1in, bottom: 0.85in)
  set page(footer: {
    counter(page).display(number => {
      let num = sm-text(number)
      let mark = [— #num —]
      centered(mark)
    })
  },
    paper: "us-letter", margin: margin
  )

  simple-meta-layout(metadata)
  dialogue-layout(dialogue)
}