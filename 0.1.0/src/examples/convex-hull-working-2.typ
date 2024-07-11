#import "@local/typkit:0.1.0": *
#import "@local/mathematical:0.1.0": *

#let draw-labels(segments, labels) = {
  let labels = resolve-array(labels)
  let size = str(segments.len())
  let reference = (
      "3": (
          south: 0,
          east: 1,
          north: 2,
          west: 2,
      ),
      "4": (
          south: 0,
          east: 1,
          north: 2,
          west: 3,
      ),
      "5": (
          south: 0,
          east: 1,
          north: 2,
          west: 4,
      ),
  )

  let ref = reference.at(size)
  let callback(label) = {
      let index = ref.at(label.place)
      let segment = segments.at(index)
      let attrs = (
          fill: label.at("fill", default: none)
      )
      let content = label.at("content", default: none)
      draw.brace(..segment, content, ..attrs)
  }

  for label in labels {
      callback(label)
  }
}


#let convex-hull(points, labels: none) = {
  let hull = algorithms.convex-hull(points)

  draw.canvas({
    draw.set-style(circle: (fill: blue))

    draw.shapes.points(points, fill: blue)
    draw.shapes.polygon(hull, stroke: red)

    if labels == none {
      return
    }

    let hull-segments = get-adjacently-paired-segments(hull)
    draw-labels(hull-segments, labels)
  })
}

#let points = (
  (0, 0), (1, 1), (2, 2), (3, 1), (4, 0), (3, 3), (2, 4), (1, 3), (2, 1), (10, 10),
)

#let labels = (
    (place: "north", content: "north"),
    (place: "south", content: "south"),
    (place: "east", content: "east"),
    (place: "west", content: "west", fill: blue),
)
#convex-hull(points, labels: labels)
// problems
// the blue fill is not that easy to read
// should be better options for the labels
// but in general ... it is working
