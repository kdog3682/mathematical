#import "@local/typkit:0.1.0": *
#import "@preview/cetz:0.2.2"
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
#let paired-points(hull) = {
    let store = ()
    let l = hull.len()
    for i in range(l) {
      let p1 = hull.at(i)
      let p2 = hull.at(calc.rem(i + 1, l))
      store.push((p1, p2))
    }
    return store
}
#let angle-between-points(p1, p2) = {
  // the ordering of (p1 and p2) MATTERS
  let dx = p2.at(0) - p1.at(0)
  let dy = p2.at(1) - p1.at(1)
  let angle = calc.atan2(dy, dx)
  return angle
}

#let get-brace-content-angle(p1, p2) = {
  let angle = angle-between-points(p1, p2) - 90deg
  if angle < -180deg {
    angle += 180deg
  }
  return angle
}


#let offset_point(p1, p2, offset) = {
  let dx = p2.at(0) - p1.at(0)
  let dy = p2.at(1) - p1.at(1)
  let length = hyp(dx, dy)
  let ux = -dy / length
  let uy = dx / length
  return (p1.at(0) + offset * ux, p1.at(1) + offset * uy)
}

#let draw_flat_brace(p1, p2, offset: 0.5, side: "outside", rotate-content: true, end_length: 0.3, ..sink) = {
  // the offset is very important
  // otherwise it will overlap on the line

  let k = if side == "outside" { 1 } else { -1 }
  let m1 = offset_point(p1, p2, -k * offset)
  let m2 = offset_point(p2, p1, k * offset)

  // let perp1 = offset_point(m1, m2, end_length)
  // let perp2 = offset_point(m1, m2, -end_length)
  // let perp3 = offset_point(m2, m1, end_length)
  // let perp4 = offset_point(m2, m1, -end_length)
  // canvas.draw.line(perp1, perp2, stroke: green)
  // canvas.draw.line(m1, m2, stroke: green)
  // this stuff is for drawing a custom brace: |--------|

  let brace-attrs = sink.named()
  let content = resolve-sink-content(sink)

  cetz.decorations.brace(m1, m2, flip: true, name: "brace", ..brace-attrs)
  if content != none and rotate-content == true {
      let angle = get-brace-content-angle(m1, m2)
      content = typst.rotate(content, angle)
  }
  // 
  cetz.draw.content("brace.content", content)
}

/// #example(```
/// line((0,0), (1,1), name: "l")
/// get-ctx(ctx => {
///   // Get the vector of coordinate "l.start" and "l.end"
///   let (ctx, a, b) = cetz.coordinate.resolve(ctx, "l.start", "l.end")
///   content("l.start", [#a], frame: "rect", stroke: none, fill: white)
///   content("l.end",   [#b], frame: "rect", stroke: none, fill: white)
/// })
/// ```)
///
/// - ctx (context): Canvas context object
/// - ..coordinates (coordinate): List of coordinates
/// - update (bool): Update the context's last position
/// -> (ctx, vector..) Returns a list of the new context object plus the
///    resolved coordinate vectors
//
/// input
#let convex-hull-display(points) = {
  let hull = graham_scan(points)
  draw.canvas({
    // Plot all points
    draw.points(points, fill: blue)
    draw.polygon(hull, stroke: red)

    // Draw braces for the hull
    let hull-points = paired-points(hull)
    for (i, pair) in hull-points.enumerate() {
        draw_flat_brace(..pair, i + 1)
    }
  })
}


#let points = (
  (0, 0), (1, 1), (2, 2), (3, 1), (4, 0),
  (3, 3), (2, 4), (1, 3), (2, 1), (10, 10)
)

#convex-hull-display(points)

