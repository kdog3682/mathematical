#import "@preview/cetz:0.2.0"
#cetz.canvas({
  import cetz.draw: *
  grid((0,0), (4,4))
  cetz.decorations.brace((1,1), (2,1), name: "a", flip: false)
  let anchor-pos = "a.k"
  circle(anchor-pos, radius: 3pt, fill: black)
  let b = (rel: (0, 0), to: "b.k")
  let content-anchor = "south-west"
  content(anchor-pos, box(inset: 5pt, fill: none, height: 30pt, align(center + horizon, "CONTENT"), stroke: red), anchor: content-anchor)
})

/// the content-anchor is a game-changer
/// i was having troubles placing the labels for the slope-triangle
/// the answer is using content-anchor
/// in this example, it is set at south-west
/// this means the point of connection happens at it's southwestern point
