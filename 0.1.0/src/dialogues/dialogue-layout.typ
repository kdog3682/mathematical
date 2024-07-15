#import "@local/typkit:0.1.0": *

#let dialogue-layout(items, body-width: auto, row-gutter: 15pt, spacing: 0.8em) = {
  set block(breakable: false)
  show par: set block(spacing: spacing )

  let even(item) = {
      block(breakable: false, width: body-width, {
        item
      })
  }
  let items = map-even-odd(items, even, bold)

  table(
    column-gutter: 10pt,
    columns: (auto, body-width),
    stroke: none,
    row-gutter: row-gutter,
    ..items,
  )
}
