// the file works ... but 
// there are overlaps and these overlaps need to be removed

#import "@local/typkit:0.1.0": *
#import "@preview/cetz:0.2.2"
#import cetz.draw: *




// length: 1, width: 1, height: 1,
#let get-prism-segments(pos, dimensions: (1, 1, 1), styles: (:)) = {
    let (x, y, z)=pos
  let (length, width, height) = dimensions
  let vertices = (
    (x, y, z),
    (x + length, y, z),
    (x + length, y + width, z),
    (x, y + width, z),
    (x, y, z + height),
    (x + length, y, z + height),
    (x + length, y + width, z + height),
    (x, y + width, z + height)
  )

  let faces = (
    ((0, 1, 2, 3), "front"),
    ((4, 5, 6, 7), "back"),
    ((0, 4, 7, 3), "left"),
    ((1, 5, 6, 2), "right"),
    ((0, 1, 5, 4), "bottom"),
    ((3, 2, 6, 7), "top")
  )

  return faces.map(face => {
    let (indices, name) = face
    let style = styles.at(name, default: (:))
    let segments = indices.map(i => vertices.at(i))
    return (segments, style)
  })
}



#{
    cetz.canvas({
        let start = (0, 0, 0)
        let attrs = (
            dimensions: (1, 1, 1),
            styles: (
                front: (
                    fill: blue,
                    stroke: strokes.soft,
                ),

                top: (
                    fill: green,
                    stroke: strokes.soft,
                ),
            )
        )
        let lines = get-prism-segments(start, ..attrs)
        for (vertices, style) in lines {
            line(..vertices, close: true, ..style)
        }
    })
}
