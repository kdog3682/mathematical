#let map-even-odd(items, ..sink) = {
  let args = sink.pos()
  let (even, odd) = if len(args) == 1 {
    (args.first(), none)
  } else {
    args
  }
  let callback((i, item)) = {
      if calc.even(i) == true && even != none {
          even(item)
      } else if odd != none {
          odd(item)
      }
  }
  return items.enumerate().map(callback)
}
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
