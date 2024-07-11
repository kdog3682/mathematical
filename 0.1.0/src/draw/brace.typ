#import "@preview/cetz:0.2.2"
#import "@local/typkit:0.1.0": *
#import "../utils.typ": *

// - fill: the decoration and content (if present) are colored to the fill
// - style: (todo ... determines the type of brace-decoration)
// - rotate-content: make the content be at same angle as the decoration
// - offset: how far off the decoration should be from the shape
#let brace(
  p1, p2, offset: 0.3, fill: none, side: "outside", style: "default", rotate-content: true, ..sink,
) = {
  let get-brace-content-angle(p1, p2) = {
    let angle = get-angle-between-points(p1, p2) - 90deg
    if angle < -180deg {
      angle += 180deg
    }
    return angle
  }

  let flip = side == "outside"
  let k = if flip { 1 } else { -1 }

  let m1 = get-offset-point(p1, p2, -k * offset)
  let m2 = get-offset-point(p2, p1, k * offset)

  let base = (stroke: strokes.soft)

  let brace-attrs = colored(resolve-sink-attrs(sink, base), fill, key: "stroke")
  let c = resolve-sink-content(sink)

  cetz.decorations.brace(m1, m2, flip: true, name: "brace", ..brace-attrs)

  if c != none {
    if rotate-content == true {
      let angle = get-brace-content-angle(m1, m2)
      c = typst.rotate(c, angle)
    }
    cetz.draw.content("brace.k", colored(c, fill))
  }
}

