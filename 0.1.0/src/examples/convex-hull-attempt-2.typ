#let graham_scan(points) = {
  // Helper function to calculate cross product
  let cross_product(o, a, b) = {
    return (a.at(0) - o.at(0)) * (b.at(1) - o.at(1)) - (a.at(1) - o.at(1)) * (b.at(0) - o.at(0))
  }

  // Sort points lexicographically
  let sorted_points = points.sorted(key: p => (p.at(0), p.at(1)))
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

// Example usage with Cetz
#import "@preview/cetz:0.1.2"

#let points = (
  (0, 0), (1, 1), (2, 2), (3, 1), (4, 0),
  (3, 3), (2, 4), (1, 3), (2, 1), (10, 10)
)

#let hull = graham_scan(points)


#let offset_point(p1, p2, offset) = {
  let dx = p2.at(0) - p1.at(0)
  let dy = p2.at(1) - p1.at(1)
  let length = calc.sqrt(dx * dx + dy * dy)
  let ux = -dy / length
  let uy = dx / length
  return (p1.at(0) + offset * ux, p1.at(1) + offset * uy)
}

#cetz.canvas({
  // Plot all points
  for point in points {
    cetz.draw.circle(point, stroke: none, radius: 3pt, fill: blue)
  }
  
  // Draw convex hull
  cetz.draw.line(..hull, close: true, stroke: red)

  for i in range(hull.len()) {
    let p1 = hull.at(i)

    let offset = -0.7
    let next = calc.rem(i + 1, hull.len())
    let p2 = hull.at(next)
    let offset_p1 = offset_point(p1, p2, offset)
    let offset_p2 = offset_point(p2, p1, -offset)
    cetz.draw.line(offset_p1, offset_p2, stroke: (dash: "dashed", paint: black), name: "segment")
    cetz.draw.circle("segment.start", fill: red)
    cetz.draw.circle("segment.end", fill: blue)
  }
})
