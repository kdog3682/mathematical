#import "@preview/cetz:0.2.2"
#import cetz.draw

// more like a series of inner squares
// i dont know why this works
#let runner(size, steps: 1) = {
    for i in range(steps) {
        draw.rect((0, 0), (size, size))
        size = size / 2
        let offset = size / 2
        draw.translate(x: offset, y: offset)
    }
}

#let main(n: 3) = {
    cetz.canvas({
        runner(5, steps: 6)
    })
}
#main()

