#import "@local/typkit:0.1.0": *
#import "@local/mathematical:0.1.0": *

#let convex-hull(points) = {
  let hull = algorithms.convex-hull(points)

  draw.canvas({
    draw.set-style(
        circle: (
            fill: blue
        )
    )

    draw.shapes.points(points, fill: blue)
    draw.shapes.polygon(hull, stroke: red)

    let hull-points = get-adjacently-paired-points(hull)
    for (i, pair) in hull-points.enumerate() {
        draw.brace(..pair, i + 1)
    }
  })
}


#let points = (
  (0, 0), (1, 1), (2, 2), (3, 1), (4, 0),
  (3, 3), (2, 4), (1, 3), (2, 1), (10, 10)
)

#convex-hull(points)

// draws a simple convex-hull
// the labels are just indexes
// there is no selection of which brace to draw ...
// all the braces are drawn
