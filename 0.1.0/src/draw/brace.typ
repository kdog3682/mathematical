#import "@preview/cetz:0.2.2"
#import "@local/typkit:0.1.0": *
#import "../utils.typ": * 
// these are not drawing utils
#import "shapes.typ"


#let segment-decoration(
  p1, p2, c, fill: none, 
  side: "outside"
) = {
    let (x1, y1) = p1
    let (x2, y2) = p2
    let k = 0.1

    let stroke = 0.5pt
    let end1 = shapes.vline(y1 - k, y1 + k, x1, stroke: stroke)
    let end2 = shapes.vline(y1 - k, y1 + k, x2, stroke: stroke)
    let segment = shapes.hline(x1, x2, y1, name: "segment", stroke: stroke)

    end1
    end2
    segment
    if c != none {
        let pos = (rel: (0, 0.35), to: "segment.mid")
        cetz.draw.content(pos, resolve-content(c))
    }
}

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

  let flip = side == "outside" or side == "above"
  let k = if flip { 1 } else { -1 }

  let m1 = get-offset-point(p1, p2, -k * offset)
  let m2 = get-offset-point(p2, p1, k * offset)

  let base = (stroke: strokes.soft)

  let styles = colored(resolve-sink-attrs(sink, base), fill, key: "stroke")
  let c = resolve-sink-content(sink)

  if style == "default" or style == "brace" {
      cetz.decorations.brace(m1, m2, flip: flip, name: "brace", ..styles)
  } else if style == "segment" {
      return segment-decoration(m1, m2, c)
  }

  if c != none {
    if rotate-content == true {
      let angle = get-brace-content-angle(m1, m2)
      c = typst.rotate(c, angle)
    }
    cetz.draw.content("brace.k", colored(c, fill))
  }
}

