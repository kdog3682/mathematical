#let midpoint(a, b) = {
    return (
        a.at(0) + (0.5 * (b.at(0) - a.at(0))),
        a.at(1) + (0.5 * (b.at(1) - a.at(1))),
    )
}

#let hyp(a, b) = {
  return calc.sqrt(calc.pow(a, 2) + calc.pow(b, 2))
}

#let get-dxdy(p1, p2) = {
  let dx = p2.at(0) - p1.at(0)
  let dy = p2.at(1) - p1.at(1)
  return (dx, dy)
}
#let get-angle-between-points(p1, p2) = {
  let (dx, dy) = get-dxdy(p1, p2)
  return calc.atan2(dy, dx)
}

#let get-adjacently-paired-segments(points) = {
    let store = ()
    let l = points.len()
    for i in range(l) {
      let p1 = points.at(i)
      let p2 = points.at(calc.rem(i + 1, l))
      store.push((p1, p2))
    }
    return store
}

/// frequently used for determining point position of brace decoration
#let get-offset-point(p1, p2, offset) = {
  let (dx, dy) = get-dxdy(p1, p2)
  let length = hyp(dx, dy)
  let ux = -dy / length
  let uy = dx / length
  return (p1.at(0) + offset * ux, p1.at(1) + offset * uy)
}



#let get-centroid(points) = {
  let sum-x = 0
  let sum-y = 0
  let n = points.len()

  for point in points {
    sum-x += point.at(0)
    sum-y += point.at(1)
  }

  return (sum-x / n, sum-y / n)
}

#let get-adjacent-pairs = get-adjacently-paired-segments
