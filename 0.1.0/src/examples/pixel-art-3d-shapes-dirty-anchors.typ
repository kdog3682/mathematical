#import "@preview/cetz:0.2.2"
#import cetz.draw: *

  #let my-star(center, name: none, ..style) = {
 group(name: name, ctx => {
 // Define a default style
 let def-style = (n: 5, inner-radius: .3, radius: .2)
 // Resolve the current style ("star")
 let style = cetz.styles.resolve(ctx.style, merge: style.named(),
 base: def-style, root: "star")
 // Compute the corner coordinates
 let corners = range(0, style.n * 2).map(i => {
 let a = 90deg + i * 360deg / (style.n * 2)
 let r = if calc.rem(i, 2) == 0 { style.radius } else { style.inner-radius }
 // Output a center relative coordinate
 (rel: (calc.cos(a) * r, calc.sin(a) * r, 0), to: center)
 })
 line(..corners, ..style, close: true)
 })
}
// Call the element

#cetz.canvas({
  
set-style(star: (fill: yellow)) // set-style works, too!
my-star((0,4))
  grid((0, 0), (5, 5), stroke: 0.25pt)

  let fooga(stroke: black) = {
    set-style(
      rect: (stroke: stroke)
    )
    rect((0, 0), (1, 1))
  }

  content(anchor: "west", (0, 0), {
    text("HIIIII\n")
    text("HIIIII\n")
    text("HIIIII\n")
  })
  
  content(anchor: "north", (3, 5), [addd

f

f])
  content(anchor: "north", (rel: (0, -0.6)), [aaaaaab
  
  c

d])
  content(anchor: "north-west", (0, 0), {
    table(
      columns: (1cm, 1cm, 1cm),
      rows: (1cm, 1cm),
      align: center + horizon,
      [1],
      table.cell([1], stroke: blue, fill: yellow),
      [1],
      [1],
      [1],
      [1],
      [1],
      [1],
    )
  })
  
  
})
