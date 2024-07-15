
#import "@preview/cetz:0.2.0"
#let translation(c, x: 0, y: 0) = {
    cetz.draw.translate(x: x, y: y)
    c
    cetz.draw.translate(x: -x, y: -y)
}

#let offset((a, b), x: 0, y: 0) = {
    (a + x, b + y)
}

#let wrapper(c, x, y, name: none) = {
    cetz.draw.group(name: name, ctx => translation(c, x: x, y: y))
}


#let rel(x, y, ..sink) = {
    let args = sink.pos()
    if args.len() == 1 {
        return (rel: (x, y), to: args.first())
    } else {
        return (rel: (x, y))
    }
}

