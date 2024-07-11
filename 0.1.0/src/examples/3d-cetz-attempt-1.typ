// status: working
// 

#import "@preview/cetz:0.2.2"
#import cetz.draw: *

#cetz.canvas({
  let origin = (0, 0)
  set-style(
    grid: (
      stroke: (
        thickness: 0.25pt,
        dash: "densely-dotted"
      )
    ),
    circle: (
      radius: 3pt,
      fill: black,
    )
  )
  on-yz({
    grid(origin, (4, 4), stroke: (paint: blue))
    grid((-4, -4), (0, 0), stroke: (paint: blue))
  })
  on-xy({
    grid(origin, (4, 4), stroke: (paint: purple))
  })
  on-xz({
    grid(origin, (4, 4))
  })
  //let c = circle.with(radius: 3pt, fill: black)
  circle((1, 1, 1))
  circle((1, 1, 0))
  line((0, 0, 0), (1, 0, 0))
  line((1, 0, 0), (1, 1, 0))
  line((1, 1, 0), (1, 1, 1))
})
