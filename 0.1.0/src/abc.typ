#let origin = (0, 0)
#let unit-segment = (origin, (1, 0))
#let stealth = (
    // end: "stealth",
    end: "triangle",
    fill: black,
)

#import "@preview/cetz:0.2.2"
#let strokes = (
    soft: (
        thickness: 0.5pt,
        dash: "densely-dotted",
        // dash: "dotted",
    ),
    smooth: (
        thickness: 0.5pt,
        // dash: "dotted",
    ),
)
#let dotted(thickness) = {
    let dotted = (
        thickness: thickness,
        dash: "densely-dotted",
        // dash: "dotted",
    )
    return dotted
}

#let boxed(c) = {
    box(inset: 5pt, baseline: 0pt, width: auto, radius: 5pt, stroke: dotted(0.25pt), c)
}
#let arrow(width, fill: black, angle: 0deg) = {
    let size = 0.3em
    let stroke = (
        paint: fill,
        thickness: size * 0.1,
        // dash: "densely-dotted"
    )
    let base = line(length: width, stroke: stroke)
    let head = rotate(polygon.regular(vertices: 3, fill: fill, size: size), -30deg)

    arrow = box({
            base
            place(head, dx: 0.8 * width, dy: -size * 0.5)
        })

    rotate(arrow, angle * -1)
}
#let curve() = {
    let points = (
        (0pt, 5pt, 0pt),
        (100pt, 7pt, 0pt),
    )
    let points = (
        (0, 0),
        (0, 0),
    )
}

/// snippet: cetz-wrapper
#let cetz-wrapper(body, length: 1cm) = {
    box(cetz.canvas(
            length: length,
            body,
        ))
}

/// snippet: auto page setup
// #set page(width: auto, height: auto, margin: (rest: 0pt))
#set page(width: auto, height: auto)

/// docs: returns the coordinates of a point located (angle, radius) away. used for performing transformations about an origin.
#let cossin(angle, r: 1, origin: (0, 0)) = {
    return (origin.first() + r * calc.cos(angle), origin.last() + r * calc.sin(angle))
}
#let place-about-origin(items, offset: 0) = {

    let n = items.len()
    cetz.canvas(length: 1cm, {
            let origin = (0, 0)
            let angles = range(n).map((x) => {
                    (x + offset) * (360deg / n)
                })
            let points = angles.map(cossin.with(r: 2, origin: origin))
            for (i, point) in points.enumerate() {
                cetz.draw.content(point, items.at(i))
            }
        })
}

/// extract: true
#let luli-website-logo(n: 3) = {
    import cetz.draw: *
    cetz.canvas(length: 1cm, {
            let origin = (0, 0)
            let offset = 0.75
            let angles = range(n).map((x) => {
                    (x + offset) * (360deg / n)
                })
            let points = angles.map(cossin.with(r: 1))
            let colors = (red, blue, green)
            for (i, point) in points.enumerate() {
                /// snippet 
                circle(
                    point,
                    fill: colors.at(i),
                    radius: 0.3,
                    stroke: none,
                )
            }
        })
}

// #luli-website-logo()

#let cetz-wrapper-2(n: 3) = {
    import cetz.draw: *
    box(cetz.canvas(length: 1cm, {
            }))
}

#let cetz-arrow-label() = {
    import cetz.draw: *
    box(cetz.canvas(length: 1cm, {
                line(
                    origin,
                    (angle: 90deg, radius: 20pt),
                    mark: stealth,
                    name: "arrow",
                )
                // rect("arrow.center", (3,3))
                rect(origin, "arrow.start", fill: none)
            }))
}
#let speech-bubble(message) = {
    box(
        radius: (
            left: 0pt,
        ),
        text(message, style: "italic"),
    )
    v(3pt)
}
#let stick-figure-head(mouth: 0.2) = {
    import cetz.draw: *
    box(cetz.canvas(length: 1cm, {
                circle(origin, name: "head", radius: 0.8)
                circle((rel: (0.5, -0.5), to: "head.north"), radius: 1.5pt, fill: black)
                circle((rel: (-0.5, -0.5), to: "head.north"), radius: 1.5pt, fill: black)
                circle(origin, radius: 1pt, fill: black)
                // line(
                //   (rel: (-0.5, 0.5), to: "head.south"),
                //   (rel: (0.5, 0.5), to: "head.south"),
                // )
                

                let y = 0.6
                let mouth-opening = y - mouth
                let left = (rel: (-0.5, y), to: "head.south")
                let right = (rel: (0.5, y), to: "head.south")
                let control = (rel: (0.0, mouth-opening), to: "head.south")
                let (a, b, c) = (
                    left,
                    right,
                    control,
                )
                line(a, c, b)
                bezier(a, b, c)
                // arc(
                //   ("head.south"), 
                //   start: 180deg, 
                //   stop: 360deg,
                //   radius: 0.5,
                //   anchor: "origin"
                // )
            }))
    // place(circle(radius: 1pt), dx: 5pt, dy: -5pt)
}
#let centered(c) = {
    align(c, center + horizon)
}
#let stick-figure(message: none, mouth: 0.3) = {
    let body = {

        stack(
            stick-figure-head(mouth: mouth),
            circle(centered([13]), radius: 0.9em),
        )
    }
    if message == none {
        body
    } else {
        grid(
            align: center,
            gutter: 5pt,
            speech-bubble(message),
            body,
        )
    }
}
#let asset-the-cool-thirteens() = {
    let messages = (
        "Bruh are you a 13?",
        "Bruh I am!",
        "Bruh!",
    )
    let stick-figures = messages.enumerate().map(((i, m)) => stick-figure(m, mouth: i / 10))
    place-about-origin(stick-figures)
}
// #asset-the-cool-thirteens()

#let asset-transformaco() = {
    let opts = (
        inset: 5pt,
        width: 200pt,
        height: 200pt,
        radius: 5pt,
        stroke: dotted(0.75pt),
    )

    block(..opts, {
            centered(text("Transformaco!", weight: "black", size: 2em))

            grid(
                align: left,
                gutter: 10pt,
                row-gutter: 10pt,
                columns: 2,
                [Python],
                [```python f = lambda x: x + 6```],
                [Rust],
                [```rust let f = |x| x + 6```],
                [Scala],
                [```scala val f = (x: Int) => x + 6```],
                [JavaScript],
                [```javascript const f = x => x + 6```],
                [Math],
                [$f(x) = x + 6$],
            )
            v(10pt)
            centered([
                    Transformers functions for just \$5.99
                    #v(-5pt)
                    Even grandma will want one!
                ])
        })
}

#let bold(it) = {
    if not type(it) == str and it.func() == math.equation {
        math.bold(it)
    } else {
        text(it, weight: "bold")
    }
}
#let main = (
    equation: $f(x) = x + 6$,
)
// #asset-transformaco()
#let asset-input-output(input: bold("INPUT"), middle: none, output: bold("OUTPUT"), equation: main.equation) = {

    let stripes = pattern(
        size: (30pt, 30pt),
        relative: "parent",
        square(
            size: 30pt,
            fill: gradient
            .conic(..color.map.rainbow),
        ),
    )
    let diamonds = pattern(
        size: (10pt, 10pt),
        relative: "parent",
        place(
            dx: 5pt,
            dy: 5pt,
            rotate(45deg, square(
                    size: 1pt,
                    fill: black,
                )),
        ),
    )

    let transformation-box = context if middle == none {
        place(bold(equation), center, dy: -20pt)
        set text(fill: blue)
        rect({
                rect([_transformation_
        
        in progress], fill: white)
            }, inset: 15pt, radius: 5pt, fill: diamonds, stroke: black)
    } else {
        let eq = bold(equation)
        // eq
        let el = rect(
            middle,
            inset: 20pt, radius: 5pt, stroke: black
        )
        let m = measure(el).width
        let n = measure(eq).width
        if n > m {
            let el = rect(
                middle,
                inset: 25pt, radius: 5pt, stroke: black
            )
            place(eq, center, dy: -20pt)
            el
        } else {
            place(eq, center, dy: -10pt)
            el
        }
    }
    let items = (
        input,
        arrow(10pt),
        transformation-box,
        arrow(10pt),
        output
    )
    grid(columns: 5, align: center + horizon, column-gutter: 10pt, ..items)
}
// #asset-input-output()

#let asset-3-stepping-into-the-function() = {
    $f(x) = x + 6$
    let entrypoint = {
        grid(
            row-gutter: 7pt,
            align: center,
            arrow(10pt, angle: 90deg),
            boxed(text("here!", weight: "bold")),
        )
    }
    let dx = -3.3pt
    place(entrypoint, dx: dx, dy: 10pt)
}

// #asset-3-stepping-into-the-function()
#let asset-where-will-i-come-out() = {
    $f(x) = x + 6$
    let entrypoint = {
        grid(
            row-gutter: 7pt,
            align: center,
            boxed(text("in", weight: "bold")),
            arrow(10pt, angle: -90deg),
        )
    }
    let exitpoint = {
        grid(
            row-gutter: 7pt,
            align: center,
            cetz.canvas({
                    cetz.decorations.brace(
                        ..unit-segment,
                        amplitude: 0.3,
                        flip: true,
                        stroke: strokes.smooth,
                    )
                }, length: 23pt),
            arrow(10pt, angle: -90deg),
            boxed(text("out", weight: "bold")),
        )
    }
    place(entrypoint, dx: 3.4pt, dy: -40pt)
    place(exitpoint, dx: 36pt, dy: 5pt)
}
#let asset-im-stepping-in-mom() = {
    asset-input-output(
        input: text("7", weight: "bold", size: 2em),
        middle: $7 + 6$,
        output: none,
    )
}
#let asset-changing-back() = {
    asset-input-output(
        output: text("7", weight: "bold", size: 2em),
        middle: $13 - 6$,
        input: stick-figure(mouth: -0.1),
        equation: $f(x) = x - 6$,
    )
}
#{
    // asset-where-will-i-come-out()
    asset-im-stepping-in-mom()
    // asset-changing-back()
}
hi
bye

#let coao(abc: 12) = {
    
}

#{
    table
}
