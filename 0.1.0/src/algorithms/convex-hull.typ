#let cross_product(o, a, b) = {
    return (a.at(0) - o.at(0)) * (b.at(1) - o.at(1)) - (a.at(1) - o.at(1)) * (b.at(0) - o.at(0))
}

#let convex-hull(points) = {
  // Helper function to calculate cross product
  // Sort points lexicographically
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


// #let points = (
  // (0, 0), (1, 1), (2, 2), (3, 1), (4, 0), (3, 3), (2, 4), (1, 3), (2, 1), (10, 10),
// )
// #panic(convex-hull(points))
