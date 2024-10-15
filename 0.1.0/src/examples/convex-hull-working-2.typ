#import "@preview/cetz:0.2.2"

#let cross_product(o, a, b) = {
  return (a.at(0) - o.at(0)) * (b.at(1) - o.at(1)) - (a.at(1) - o.at(1)) * (b.at(0) - o.at(0))
}

#let calculate-convex-hull(points) = {
  let sorted_points = points.sorted()
  let n = sorted_points.len()

  if n <= 3 {
    return sorted_points
  }

  // Build lower hull
  let lower = ()
  for p in sorted_points {
    while lower.len() >= 2 and cross_product(lower.at(-2), lower.at(-1), p) <= 0 {
      lower.pop()
    }
    lower.push(p)
  }

  // Build upper hull
  let upper = ()
  for p in sorted_points.rev() {
    while upper.len() >= 2 and cross_product(upper.at(-2), upper.at(-1), p) <= 0 {
      upper.pop()
    }
    upper.push(p)
  }

  // Concatenate hulls
  lower.pop()
  upper.pop()
  return lower + upper
}

#let points = (
  (0, 0),
  (1, 1),
  (2, 2),
  (3, 1),
  (4, 0),
  (3, 3),
  (2, 4),
  (1, 3),
  (2, 1),
  (10, 10),
)

#let draw-labels(segments, labels) = {
  let labels = resolve-array(labels)
  let size = str(segments.len())
  let reference = (
    "3": (south: 0, east: 1, north: 2, west: 2),
    "4": (south: 0, east: 1, north: 2, west: 3),
    "5": (south: 0, east: 1, north: 2, west: 4),
  )

  let ref = reference.at(size)
  let callback(label) = {
    let index = ref.at(label.place)
    let segment = segments.at(index)
    let attrs = (fill: label.at("fill", default: none))
    let content = label.at("content", default: none)
    draw.brace(..segment, content, ..attrs)
  }

  for label in labels {
    callback(label)
  }
}

#let convex-hull(points, labels: none) = {
  let hull = calculate-convex-hull(points)

  draw.canvas(
    {
      draw.set-style(circle: (fill: blue))

      draw.shapes.points(points, fill: blue)
      draw.shapes.polygon(hull, stroke: red)

      if labels == none {
        return
      }

      let hull-segments = get-adjacently-paired-segments(hull)
      draw-labels(hull-segments, labels)
    },
  )
}

#let points = (
  (0, 0),
  (1, 1),
  (2, 2),
  (3, 1),
  (4, 0),
  (3, 3),
  (2, 4),
  (1, 3),
  (2, 1),
  (10, 10),
)

#let labels = (
  (place: "north", content: "north"),
  (place: "south", content: "south"),
  (place: "east", content: "east"),
  (place: "west", content: "west", fill: blue),
)

#convex-hull(points, labels: labels)