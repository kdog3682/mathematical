#import "@preview/fletcher:0.5.0" as fletcher: edge, cetz

#let CANVAS_LENGTH = 1cm

#let node(a, b, ..sink) = {
  let kwargs = sink.named()
  let pos = sink.pos()
  let c = a * CANVAS_LENGTH
  let d = b * CANVAS_LENGTH
  let location = (c, d)
  fletcher.node(location, ..pos, ..kwargs)
}

#let cetz-renderer(items) = {
  let lib = dictionary(cetz.draw)
  for item in items {
    lib.at(item.shape)(..item.args, ..item.at("kwargs", default: (:)))
  }
}


#let fletcher-canvas(body, background) = {
    fletcher.diagram(
      debug: 2,
      node-outset: 5pt,
      render: (grid, nodes, edges, options) => {

        cetz.canvas(length: CANVAS_LENGTH, {
          cetz-renderer(background)
          fletcher.draw-diagram(grid, nodes, edges, debug: options.debug)
        })
      }, body
    )
}


