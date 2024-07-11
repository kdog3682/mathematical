#import "@preview/cetz:0.2.2"
#import "@local/stdlib:0.1.0" as stdlib: *
#import cetz.draw: *


#let axes-opts = (
      right: ( tick: ( stroke: none, ) ),
      top: ( tick: ( stroke: none, ) ),
      
      left: (
        grid: (stroke: blue + 0.1pt),
        label: (
            offset: 0.2,
            angle: 360deg,
            anchor: "center",
        ),
        tick: (
          length: 0.2,
          minor-length: 0.1,
          offset: -0.1,
          stroke: black + 0.5pt
        ),
        
      ),
      bottom: (
        grid: (stroke: blue + 0.1pt),
        tick: (
          length: 0.2,
          minor-length: 0.1,
          offset: -0.1,
          stroke: black + 0.5pt
        ),
          label: (
            offset: 0.4cm,
            angle: 360deg,
            anchor: "center",
          )
      )
    )

#let resolve-list(x) = {
    if type(x) == array {
        x
    } else {
        (x,)
    }
}


#let scientific-opts = (
    plot-size: (4, 4),
    grid: true,
    // axis-style: "school-book",
    // grid: false,
    // x-label: $x$,
    x-label: auto,
    y-label: auto,
)

#let scientific(plots, domain: (-5, 5), ..style) = cetz.canvas({
    let plots = resolve-list(plots)
    // let o = stdlib.styles.resolve(style, "scientific")

    let o = scientific-opts
    let tick-step = 1
    let minor-tick-step = none
    let tick-format-size = 8pt

    let plot-opts = (
        size: o.plot-size,
        x-tick-step: tick-step,
        // y-tick-step: tick-step,
        x-grid: o.grid,
        y-grid: o.grid,
        // axis-style: o.axis-style,
        x-minor-tick-step: minor-tick-step,
        y-minor-tick-step: minor-tick-step,
        x-format: (x) => text(str(x), size: tick-format-size),
        y-format: (x) => text(str(x), size: tick-format-size),
        x-label: o.x-label,
        y-label: o.y-label,
    )

    set-style(axes: axes-opts)
    cetz.plot.plot(..plot-opts, {
        for p in plots {
            let d = p.at("domain", default: domain)
            cetz.plot.add(domain: d, style: (stroke: p.stroke), p.fn)
        }
    })
})
// #panic("HI")

#let plots = (
    ( fn: (x) => x * x, domain: (-3, 3), stroke: 0.5pt + blue ),
    ( fn: (x) => x * x * x, domain: (-5, 3), stroke: 0.5pt + green ),
)
#scientific(plots)
