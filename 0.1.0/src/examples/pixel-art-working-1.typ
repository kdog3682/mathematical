#import "@preview/cetz:0.2.2"
#import cetz.draw
#import cetz.plot


#let off(p, n: 0) = {
  (p.at(0) + n, p.at(1) + n)
}

#let cubio() = {
  import cetz.draw: *
  on-yz({ rect((0, 0), (1, 1)) })
  on-xz({ rect((0, 0), (1, 1)) })
  on-xy({ rect((0, 0), (1, 1)) })
  on-xy({ line((1, 1), (1, 1)) })
}

#let ratioat(p) = {
  cetz.draw.rect(p, (rel: (1, 1)))
  cetz.draw.rect(p, (rel: (2, 1)))
  cetz.draw.rect(p, (rel: (3, 1)))
  cetz.decorations.flat-brace(p, (rel: (3, 0)))
}
#let fractionat(p) = {
  cetz.draw.rect(p, (rel: (1, 1)))
  cetz.draw.rect(p, (rel: (2, 1)))
  cetz.draw.rect(p, (rel: (3, 1)))
  cetz.decorations.flat-brace(p, (rel: (3, 0)))
}
#let bezierworks() = {
  // a function
    let bezier-points = ((0, 0), (1, 1), (2, 4))
draw.bezier-through(..bezier-points, name: "b")
    let bezier-points = ((2, 4), (3, 3), (5,5))
draw.bezier-through(..bezier-points, name: "b")
}
#let plotworks(params) = {
  
    plot.plot(axes: none, size: (2,2), x-tick-step: none, y-tick-step: none, {
 plot.add(domain: (0, 2*calc.pi), calc.sin)
 plot.annotate({
 draw.rect((0, -1), (calc.pi, 1), fill: rgb(50,50,200,50))
 draw.content((calc.pi, 0), [Here])
 })
})
}
#let k = 0.5
#let boxed(c) = {
  box(outset: 10pt, fill: white, c)
}
#let grapher(x, y,) = {
  import cetz.draw: *
  circle((x, y), fill: white, radius: 0.1, stroke: none)
}
#let plotter() = {

  boxed(cetz.canvas(length: 40pt, {
plot.plot(size: (2,2), x-tick-step: none, y-tick-step: none, {
 plot.add(domain: (0, 2*calc.pi), calc.sin)
 plot.annotate({
 draw.rect((0, -1), (calc.pi, 1), fill: rgb(50,50,200,50))
 draw.content((calc.pi, 0), [Here])
 })
})
    
  }))
}
#let wrapper(content) = layout(page => {
  box(
    inset: (
      x: 6.22pt / 2,    
      y: 50.89pt / 2
    ),
    content
  )
})
#let main() = layout(page => {
  
  let x2 = 6
  let y2 = 10
  let length = 40pt
  let c = draw.circle.with(radius: 0.05, fill: black, stroke: none)
  let marker = draw.circle.with(radius: 0.25, fill: red)
  cetz.canvas(length: length, {
    // plotworks(1)
    //draw.grid((0, 0), (x2, y2))
    cubio()
    fractionat((2, 8))
     bezierworks()
    let data = (
      (3, 5),
      (2, 2),
    )
    draw.rect((1 - k/2, k), (1 + k/2, 5))
    // draws a bar rect at 1
    
    draw.rect((3 - k/2, k), (3 + k/2, 5))
    // draws a bar rect at 5
    draw.line((0 + 0.5, 0 + 0.5), (0 + 0.5, y2 + 0.5))
    // draws the y-axis
    draw.line((0 + 0.5, 0 + 0.5), (x2 + k + 0, 0.5))
    // draws the x-axis
    for i in range(x2 + 1) {
      for j in range(y2 + 1) {
        if i == 0 {
          if j == 0 {
            draw.line((0.3, 0.3), (0.5, 0.5))
          }
          draw.content((i, j), [#j])
            draw.line((k, j), (0.3, j))
        }
        else if j == 0 {
          draw.content((i, j), [#i])
            draw.line((i, k), (i, 0.3))
        }
        else {
          c((i, j), fill: red)
        }
      }
    }
    for d in data {
      c(off(d), fill: blue, radius: 0.2)
    }
    let mx = x2 / 2
    let my = y2 / 2
    //marker((mx, my))
    //draw.content((3, 8), plotter())
    grapher(2, 8)
    
    //draw.content((mx, my), box([hi sdfsdfsdf], fill: white, outset: 40pt), name: "a")
    //draw.content((to: "a", rel: (0, -0.25)), line(length: 50pt))
    //draw.content((to: "a", rel: (0, -0.5)), [hi])
  })
})

#let pat = pattern(size: (3pt, 6pt))[
  #place(line(start: (0%, 0%), end: (100%, 100%)))
  #place(line(start: (0%, 100%), end: (100%, 0%)))
]

#{
  let b = {
    place(rect(width: 100%, height: 100%))
    let p = pattern(size: (3pt, 3pt), {
      circle(radius: 1pt, fill: gray)
    })
    
    let p2 = pattern(size: (3pt, 3pt), {
    })
    let p2 = pat
    // place(rect(width: 20%, height: 100%, fill: black.lighten(95%), align(time-travel, center + horizon)))
    place(dx: 20%, rect(inset: 0pt, width: 80%, height: 100%, stroke: none, wrapper(main())))
  }
  set page(margin: (rest: 0pt))
  b
}

