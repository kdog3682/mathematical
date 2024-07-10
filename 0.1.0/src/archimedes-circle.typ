#import "@preview/cetz:0.2.2"
#import cetz.draw: *

#let archimedes-circle(n, offset: 0.5) = {
  let center = (0, 0)
  let points = ()
  let r = 1
  for i in range(n) {
    let theta = ((2 * i/n) + offset) * calc.pi
    let p = (
      r * calc.cos(theta),
      r * calc.sin(theta)
    )
    points.push(p)
  }
  cetz.canvas({
    circle(points.at(0), fill: red, radius: 0.1, stroke: none)
    line(points.at(0), center)
    line(..points, close: true)
    circle(center)
  })
}

#archimedes-circle(5, offset: 0.5)
#archimedes-circle(4, offset: 0.25)
#archimedes-circle(3, offset: 0.5)

