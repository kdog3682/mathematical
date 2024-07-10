
#import "@preview/cetz:0.2.2"

#let get-rect-coordinates(w, h) = {
  let a = (0, 0)
  let b = (0, h)
  let c = (w, h)
  let d = (w, 0)
  return (a, b, c, d)
}

#let get-brace-points() = {
    
}

#let brace(points, c, place: "below") = {
  let (a, b) = get-brace-points(points, place)
  cetz.decorations.brace(a, b, stroke: 0.5pt, name: "brace")
  cetz.draw.content("brace.k", resolve-content(c))
}


#let square(length) = {
  let points = get-rect-coordinates(length, length)
  cetz.draw.rect(points.at(0), points.at(2))
  brace(points, length, place: "below")
}

#let rectangle(w, h) = {
  cetz.draw.rect(a, c)
  circ(b)
  circ(c)


Small squares have side length 2. 
#square(2)
