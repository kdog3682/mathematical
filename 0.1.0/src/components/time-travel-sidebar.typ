


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
    let s = text(size: 48pt, "TIME TRAVEL EDITION", fill: p, spacing: 20pt, tracking: 3pt, weight: "bold", stroke: black + 0.25pt)
    let t = text(size: 48pt, "(1991)", fill: p2, spacing: 20pt, tracking: 0pt, weight: "bold", stroke: black + 1pt)
    let time-travel = {
      rotate(s + h(20pt) + t, 270deg, reflow: true)
    }
    place(rect(width: 20%, height: 100%, fill: black.lighten(95%), align(time-travel, center + horizon)))
    let dots = blue
    let main = [
      hiii
    ]
    place(dx: 20%, rect(width: 80%, height: 100%, fill: dots, main))
  }
  set page(margin: (rest: 0pt))
  b
}
