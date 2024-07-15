#import "@preview/cetz:0.2.2"
#import cetz.draw

#let offsetf(offset) = {
    let callback(p) = {
        return p.map((x) => x + offset)
    }
    return callback
}

#let recursive_diamond(size, depth) = {
  let runner(size, offset) = {
    let half = size / 2
    let x = 0
    let y = 0
    let callback = offsetf(offset)
    let rect-points = ((x, y), (size, size)).map(callback)
    let diamond-points = ((half, y), (size, half), (half, size), (x, half)).map(callback)
    return (rect: rect-points, diamond: diamond-points)
  }

  let offset = 0
  let store = ()
  while depth > 0 {
    let points = runner(size, offset)
    store.push(points)
    let new_size = size / calc.sqrt(2)
    offset = (size - new_size) / 2
    size = new_size
    depth -= 1
  }

  cetz.canvas(length: 1pt, {
      for arg in store {
          draw.rect(..arg.rect)
          draw.line(..arg.diamond, close: true)
      }
  })
}



// have to make it smaller
// have to make it fit TE
// this kind of works
// #let diamond = recursive_diamond(30, 2)
// #let pat = pattern(size: (30pt, 30pt), diamond)
// #rect(fill: pat, width: 60pt, height: 60pt)

// #let pat = pattern(size: (5pt, 5pt), place(rect(width: 5pt, height: 5pt)))
// #rect(fill: pat, width: 60pt, height: 60pt, stroke: none)
