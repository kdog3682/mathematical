// status: works

#import "@preview/cetz:0.2.2"
#import cetz.draw: *

#let get-cube-segments(x, y, z) = {
  let length = 3
  let vertices = (
    (x, y, z),
    (x + length, y, z),
    (x + length, y + length, z),
    (x, y + length, z),
    (x, y, z + length),
    (x + length, y, z + length),
    (x + length, y + length, z + length),
    (x, y + length, z + length)
  )

  let edges = (
    (0, 1), (1, 2), (2, 3), (3, 0),
    (4, 5), (5, 6), (6, 7), (7, 4),
    (0, 4), (1, 5), (2, 6), (3, 7)
  )

  return edges.map(edge => {
    let (start, end) = edge
    let (x1, y1, z1) = vertices.at(start)
    let (x2, y2, z2) = vertices.at(end)
    ((x1, y1, z1), (x2, y2, z2))
  })
}

#{
    cetz.canvas({
        let lines = get-cube-segments(0, 0, 0)
        for pos in lines {
            line(..pos)
        }
    })
}
