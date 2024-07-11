#import "@preview/cetz:0.2.2"

#let points(points, ..sink) = {
    for p in points {
      cetz.draw.circle(p, radius: 3pt, stroke: none, fill: black, ..sink)
    }
}

#let polygon(points, ..sink) = {
    cetz.draw.line(..points, close: true, ..sink)
}
