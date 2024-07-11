#import "@preview/cetz:0.2.2"

#let plot-opts = (
  size: (4, 4), 
  name: "plot", 
  axis-style: "school-book",
  x-min: -4 + 0.0,
  y-min: -4,
  x-format: v => text(6pt, $ #v $),
  x-tick-step: 0.5,
  y-format: v => text(6pt, $ #v $),
  y-tick-step: 0.5,
)

#let plot-style = (
  axes: (
    x: (
      mark: (fill: black, start: "stealth", end: "stealth"),
    ),
    y: (
      mark: (fill: black, start: "stealth", end: "stealth"),
    ),
  )
)

#let points = ((0, 0), (3, 3), (2,0), (0,2))
#cetz.canvas({
    import cetz.plot
    import cetz.draw: *
    set-style(..plot-style)
    plot.plot(..plot-opts, {
        plot.add(points)
        plot.add-anchor("first-point", points.last())
    })
    circle("plot.first-point", fill: red, radius: 0.2)
})


/// if no domain is specified, 
