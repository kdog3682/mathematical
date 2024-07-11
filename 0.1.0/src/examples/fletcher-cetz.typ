#set page(width: auto, height: auto)
#import "@preview/fletcher:0.5.0" as fletcher: diagram, node, edge, cetz

#let canvas-length = 1cm

#let circ(p) = {
  cetz.draw.circle(p, radius: 0.25/4, fill: black)
}
#let higher(p) = {
  (p.at(0), p.at(1) + 0.2)
}
#let rectangle(w, h) = {
  let a = (0, 0)
  let b = (0, h)
  let c = (w, h)
  let d = (w, 0)
  cetz.draw.rect(a, c)
  circ(b)
  circ(c)
  cetz.decorations.brace(higher(b), higher(c), stroke: 0.5pt, name: "top")
  cetz.draw.content("top.k", [hi])
}
#let noder(a, b, ..sink) = {
  let kwargs = sink.named()
  let pos = sink.pos()
  let c = a * canvas-length
  let d = b * canvas-length
  let coor = (c, d)
  node(coor, ..pos, ..kwargs)
}

#let cetz-renderer(items) = {
  let lib = dictionary(cetz.draw)
  for item in items {
    lib.at(item.shape)(..item.args, ..item.at("kwargs", default: (:)))
  }
}

#let payload = (
  (shape: "rect", args: ((0, 0), (4,4))),
  (shape: "circle", args: ((0, 0),)),
)
#let computed-payload = {
  //cetz.draw.circle((0.5, 0.5), radius: 0.25/2, fill: black, name: "a1")
  //cetz.draw.circle((rel: (-0.5, 0.5), to: "a1"), radius: 0.25/2, fill: black, name: "a")
  //cetz.draw.circle((rel: (-0.5, 0.5), to: "a"), radius: 0.25/2, fill: black, name: "a")
  //cetz.draw.line((to: "a1", rel: (0,-0.25)), (to: "a1", rel: (3, -0.25)))
  cetz.draw.grid((0, 0), (4, 4), stroke: 0.25pt)
  rectangle(3, 2)
  
}
#diagram(
  debug: 2,
  node-outset: 5pt,
  render: (grid, nodes, edges, options) => {
    
    cetz.canvas(length: canvas-length, {
      computed-payload
      fletcher.draw-diagram(grid, nodes, edges, debug: options.debug)

    })
  }, {
    
    noder(0, 0, $A$, name: <a>)
    noder(4, 4, $B$, name: <b>)
    edge(<a>, <b>, "->", bend: 15deg, stroke: green)
  }
)

