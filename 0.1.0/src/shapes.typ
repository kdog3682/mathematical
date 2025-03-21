
#import "@preview/cetz:0.3.2"
#let points(points, ..sink) = {
    for p in points {
      cetz.draw.circle(p, radius: 3pt, stroke: none, fill: black, ..sink)
    }
}

#let polygon(points, ..sink) = {
    cetz.draw.line(..points, close: true, ..sink)
}

#let square((x, y), length: 1, ..sink) = {
    let points = (
        (x, y),
        (x + length, y + length),
    )
    cetz.draw.rect(..points, ..sink)
}



#let vline(y1, y2, ..sink) = {
    let args = sink.pos()
    let x = if args.len() == 1 { args.first() } else { 0 }
    let points = ((x, y1), (x, y2))
    return cetz.draw.line(..points, ..sink.named())
}

#let hline(x1, x2, ..sink) = {
    let y = sink.pos().len() == 1
    let args = sink.pos()
    let y = if args.len() == 1 { args.first() } else { 0 }
    let points = ((x1, y), (x2, y))
    return cetz.draw.line(..points, ..sink.named())
}

#let point(p, radius: 0.1, stroke: none, fill: black) = {
      cetz.draw.circle(p, radius: radius, stroke: stroke, fill: fill)
}

#let grid(width: 10, height: 10) = {
    cetz.draw.grid((0, 0), (width, height), help-lines: true)
}

