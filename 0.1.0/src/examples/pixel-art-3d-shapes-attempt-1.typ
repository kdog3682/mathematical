#import "@preview/cetz:0.2.2"
#import cetz.draw: *



#cetz.canvas({
  grid((0, 0), (5, 5), stroke: 0.25pt)

  let fooga(stroke: black) = {
    set-style(
      rect: (stroke: stroke)
    )
    rect((0, 0), (1, 1))
  }
  
  let booga(dimension, x1, y1, x2, y2)= {
    let dimensions = (
      xz: on-xz,
      yz: on-yz,
      xy: on-xy,
    )
    dimensions.at(dimension)(rect((x1, y1), (x2, y2)))
  }
  on-xy(fooga())
  on-xz(fooga(stroke: blue))
  on-yz(fooga(stroke: red))
  booga("yz", 0, 0, -1, 1)
  booga("xz", 0, 0, -1, 1)
  translate(x: 1, y: 0.5, z: 0.5)
  booga("xy", 0, 0, 1, 1)
  
})
