#import "@local/typkit:0.1.0": *
#import "factorial.typ": factorial
#import "fraction.typ": fraction

/// this is the factorial function
/// asdf
/// sdf
/// sdf
/// sdf
///
/// sdf
/// sdf
#let factorial-fraction(
  top: none,
  bottom: none,
  delimiter: "times",
  cancel: false,
  lhs: none,
  highlight-remaining: false,
  highlight-color: "blue",
  centered: false,
  ..sink,
) = {
  let args = sink.pos()
  let (
    a,
    b,
  ) = if args.len() == 0 {
    (
      top.value,
      bottom.value,
    )
  } else {
    args
  }
  let top-base = (
    left: 3,
    right: 3,
    fill: blue,
    early-stop: true,
  )

  let bottom-base = (
    left: 3,
    right: 3,
    fill: purple,
    early-stop: true,
  )

  let top = merge-dictionaries(
    top-base,
    top,
  )
  let bottom = merge-dictionaries(
    bottom-base,
    bottom,
  )

  let runner(
    n,
    opts,
    cancels,
  ) = {
    if cancel == false {
      cancels = none
    }
    let hide = opts.at(
      "hide",
      default: false,
    )
    if hide == true {
      return hidden(
        5pt,
      )
    }
    return colored(
      factorial(
        n,
        cancels: cancels,
        limit: 10,
        left: opts.left,
        right: opts.right,
        highlight-remaining: highlight-remaining,
      ),
      opts.fill,
    )
  }

  let numerator = runner(
    a,
    top,
    b,
  )
  let denominator = runner(
    b,
    bottom,
    a,
  )
  // let opts = (
  // highlight-remaining: highlight-remaining,
  // cancels: cancels,
  // limit: 10,
  // )
  // let (numerator, denominator) = double-factorial(a, b, top, bottom, ..opts)
  let rhs = fraction(
    numerator,
    denominator,
    align: align,
  )
  let value = rhs
  if lhs != none {
    let lhs = fraction(
      colored(
        str-add(
          a,
          "!",
        ),
        top.fill,
      ),
      colored(
        str-add(
          b,
          "!",
        ),
        bottom.fill,
      ),
    )
    value = (
      lhs,
      rhs,
    ).join(
      marks.math.equals,
    )
  }
  if centered == true {
    set text(
      size: 1.5em,
    )
    value = align(
      value,
      center,
    )
  }
  return v(
    10pt,
  ) + value
}
// #factorial-fraction(556, 55, cancel: true)
// #factorial-fraction(556, 55, cancel: false)

// WORKS
// #factorial-fraction(
// top: ( value: 10, left: 5, fill: "none"),
// bottom: ( value: 6, left: 5, fill: "none", hide: false),
// cancel: true,
// highlight-remaining: true
// )
