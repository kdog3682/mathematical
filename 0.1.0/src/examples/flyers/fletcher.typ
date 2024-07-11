#let my-mark = (
 size: 2,
 draw: mark => draw.circle((0,0), radius: mark.size, fill: none, stroke: 0.5pt)
)

#diagram(edge(stroke: 3pt, marks: (my-mark + (size: 4), my-mark)))

// a node is kind of like a box
// fletcher is really cool
// Joseph Wilson 
#fletcher.diagram(
 node((0,0), $A$, name: <A>),
 node((1,0.6), $B$, name: <B>),
 edge(<A>, <B>, "->"),
 node((rel: (1, 0), to: <B>), $C$, name: <D>),
 edge(<A>, <D>, "->"),
 edge((0,0), (rel: (0,2)), (rel: (1,0)), (rel: (1,1)), "->", `poly`, bend: 30deg)
)

