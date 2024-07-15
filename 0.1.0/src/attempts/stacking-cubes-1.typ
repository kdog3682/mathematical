// this file attempts to remove the overlaps between edges
// it is a major refactor: changing styles to an array
// example-single-cube: working
// example-multiple-cube(): the background overlaps ...
// doesnt look very good

#import "@local/typkit:0.1.0": *
#import "@local/mathematical:0.1.0": *
#import "@preview/cetz:0.2.2"
#import "../utils.typ": get-adjacent-pairs
#import cetz.draw: *

#let get-prism-segments(pos, dimensions: (1, 1, 1), styles: ()) = {
  let (x, y, z) = pos
  let (length, width, height) = dimensions
  let vertices = (
    (x, y, z), (x + length, y, z), (x + length, y + width, z), (x, y + width, z), (x, y, z + height), (x + length, y, z + height), (x + length, y + width, z + height), (x, y + width, z + height),
  )

  let faces = (
    front: ((0, 1), (1, 2), (2, 3), (3, 0)), back: ((4, 5), (5, 6), (6, 7), (7, 4)), left: ((0, 4), (4, 7), (7, 3), (3, 0)), right: ((1, 5), (5, 6), (6, 2), (2, 1)), bottom: ((0, 1), (1, 5), (5, 4), (4, 0)), top: ((3, 2), (2, 6), (6, 7), (7, 3)),
  )

  let face-keys = unique(faces.keys(), styles.map((x) => x.key))
  let store = ()
  let seen = ()
  let items = styles + face-keys.map((key) => (key: key))
  for item in items {
    let index-pairs = faces.at(item.key)
    for index-pair in index-pairs {
      let key = stringify(index-pair.sorted())
      if key not in seen {
        seen.push(key)
        let p = (
          segment: index-pair.map((i) => vertices.at(i)), style: getter(item, ignore: "key"),
        )
        store.push(p)
      }
    }
  }
  return store
}


#let example-single-cube() = {
  cetz.canvas(
    {
      let start = (0, 0, 0)
      let attrs = (
        styles: (
          (fill: blue, stroke: strokes.soft, key: "front"), 
          (fill: blue, stroke: strokes.soft, key: "back"),
        ),
      )
      let items = get-prism-segments(start, ..attrs)
      let n = 3
      for (i, item) in items.enumerate() {
        line(..item.segment, ..item.style)
      }
    },
  )
}


#let prism(start, ..attrs) = {
          let items = get-prism-segments(start, ..attrs)
          for (i, item) in items.enumerate() {
            line(..item.segment, ..item.style)
          }
}

#let example-multiple-cube() = {
  cetz.canvas(
    {
      let start = (0, 0, 0)
      let attrs = (
        styles: (
          // (fill: blue, stroke: strokes.soft, key: "front"),
          // (fill: blue, stroke: strokes.soft, key: "back"),
        ),
      )
      for i in range(5) {
          let start = (i, 0, 0)
          prism(start, ..attrs)
      }

      for i in range(5) {
          let start = (0, 0, i)
          prism(start, ..attrs)
      }
    },
  )
}
// #example-multiple-cube()
// cubes are drawn

#cetz.canvas({
    draw.shapes.grid()
    prism((-1, 1, -1))
    prism((-1, 2, -1))
})
