// doesnt really work
// Helper function to calculate the angle between two points
#let getAngle(p1, p2) = {
  calc.atan2(p2.at(1) - p1.at(1), p2.at(0) - p1.at(0))
}

// Helper function to calculate the Euclidean distance between two points
#let getHypot(p1, p2) = {
  let dx = p2.at(0) - p1.at(0)
  let dy = p2.at(1) - p1.at(1)
  calc.sqrt(dx * dx + dy * dy)
}

// Helper function to remove duplicate angles from the results
#let removeDuplicateAngles(results) = {
  let unique = ()
  for result in results {
    if unique.len() == 0 or result.angle != unique.last().angle {
      unique.push(result)
    }
  }
  unique
}

// Helper function to determine if three points make a counter-clockwise turn
#let ccw(p1, p2, p3) = {
  (p2.at(0) - p1.at(0)) * (p3.at(1) - p1.at(1)) - (p2.at(1) - p1.at(1)) * (p3.at(0) - p1.at(0))
}

// Main function to compute the convex hull
#let getConvexHull(points) = {
  points = points.sorted()

  let pivot = points.first()
  let results = points.map(point => {
    (
      angle: getAngle(pivot, point),
      distance: getHypot(pivot, point),
      point: point,
    )
  })

  results = results.sorted(key: el => {
    return (el.angle, el.distance)
  })
  results = removeDuplicateAngles(results)
  // panic(results)

  let hull = ()
  for result in results {
    let point = result.point
    let l = hull.len()
    if l < 3 {
      hull.push(point)
    } else {
      while l >= 2 and ccw(hull.at(l - 2), hull.at(l - 1), point) > 0 {
        hull.pop()
        l = hull.len()
      }
      hull.push(point)
    }
  }
  return hull
}

#import "@preview/cetz:0.2.0"
#import cetz.draw: *


// Define the points of a pentagon
#let pentagonPoints = (
  (0, 0),
  (4, 0),
  (5, 3),
  (2, 5),
  (2, 0),
  (2, 1),
  (2, 2),
  (2, 3),
  (0, 3)
)

// Get the convex hull

// Function to scale points to fit nicely on the canvas
#let scalePoints(points, scale: 20, offsetX: 0, offsetY: 0) = {
  points.map(p => ((p.at(0) + offsetX) * scale, (p.at(1) + offsetY) * scale))
}

// Create the visualization
#let points(points, ..sink) = {
    for p in points {
      circle(p, radius: 0.2, stroke: none, fill: black, ..sink)
    }
}

#let polygon(points) = {
    line(..points, close: true)
}

#let drawing() = {
  let hull = getConvexHull(pentagonPoints)
  cetz.canvas({
  
    grid((0, 0), (5, 5), stroke: 0.25pt)
    points(pentagonPoints, fill: red)
    polygon(hull)
    points(hull)
  })

}

#drawing()
