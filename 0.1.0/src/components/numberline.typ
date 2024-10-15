#import "@local/typkit:0.1.0": *
#import "@preview/cetz:0.2.0"
#import cetz.draw: *
#import "../draw/index.typ" as draw

#let BRACE_OFFSET = 0.65

#let draw-distance((from, label, to), lerp) = {
    let from = lerp(from)
    let to = lerp(to)
    todo()
}

#let draw-brace((from, label, to, side, style), lerp) = {
    let from = lerp(from)
    let to = lerp(to)
    if is-string(label) {
        label = bold(label)
    }
    // opposite side is required for numberlines 
    draw.brace(from, to, label, offset: BRACE_OFFSET, side: opposite(side), style: style)
}

#let draw-point((value, label), lerp, offset: 0.35) = {
    let pos = lerp(value)

    draw.shapes.point(pos, radius: 0.1)

    if label != none {
        if is-string(label) {
            label = bold(label)
        }
        content(draw.utils.offset(pos, y: offset), label)
    }
}

#let draw-pair((from, label, to, style), lerp) = {
    draw-point(from, lerp)
    draw-point(to, lerp)
    draw-brace((from: from.value, to: to.value, label: label, side: "above", style: style), lerp)
}

#let draw-square((value, label), lerp) = {
    let pos = lerp(value)
    line(pos, (rel: (0, .4)), stroke: strokes.soft)
    rect((), (rel: (0.2, .2)), anchor: "east", fill: black)
}

#let draw-reference = (
    point: draw-point,
    brace: draw-brace,
    pair: draw-pair,
    square: draw-square,
)

#let numberline-base(data, min: auto, max: auto, length: auto) = {
    let transform(x, mode: "max") = {
        let value = x.at("value", default: none)
        if value != none {
            return value
        }
        let value = if mode == "min" {
            x.at("from", default: none)
        } else {
            x.at("to", default: none)
        }
        if is-number(value) {
            return value
        }
        return value.value
    }

    if max == auto {
        let highest = get-max(data, transform: transform)
        max = calc.max(10, highest)
    }

    if min == auto {
        let lowest = get-min(data, transform: transform.with(mode: "min"))
        min = calc.min(1, lowest)
    }

    if length == auto {
        length = max - min
    }

    return {
        let (a, b) = ((0,0), (length,0))
        line(
            (rel: (-1,0), to: a),
            (rel: (1,0), to: b),
            mark: (fill: black, end: "stealth", start: "stealth"),
            name: "line",
        )

        let len = cetz.vector.dist(a, b)
        let lerp(v) = {
            cetz.vector.lerp(a, b, (v - min) / (max - min))
        }

        for d in data {
            draw-reference.at(d.type)(d, lerp)
        }

        // Place ticks
        // Both sided
        let aa = 0.1
        let bb = aa * -2

        // Place ticks above
        // Place ticks below
        for maj in range(min, max + 1) {
            let val = cetz.vector.lerp(a, b, (maj - min) / (max - min))
            move-to(val)
            line((rel: (0, aa)), (rel: (0, bb)))
            content((rel: (0, -aa)), $maj$, anchor: "north")
        }
    }
}

#let data = (
    (type: "point", label: [A], value: 1),
    (type: "point", label: [B], value: 2),
    // (type: "point", label: [C], value: 3),
    (
        type: "pair",
        label: $3x + 1$,
        from: (value: 3, label: "A"),
        to: (value: 6, label: "B"),
        style: "segment",
    ),
    // (type: "brace", label: [$\ax^2 + 3$], from: 3, to: 7, side: "above"),
)

#let numberline((x, y), data, name: none) = {
    draw.utils.wrapper(numberline-base(data), x, y)
}

// it works 
#cetz.canvas({
    draw.shapes.grid()
    draw.shapes.point((0, 0))
    numberline((3, 3), data, name: "abc")
})
