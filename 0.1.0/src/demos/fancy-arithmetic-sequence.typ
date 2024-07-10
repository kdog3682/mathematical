#import "@local/typkit:0.1.0": *
#import "@preview/cetz:0.2.2"

#let number-sum-content(numbers) = {
    let a = numbers.map((x) => $#x$).join(marks.math.plus)
    let b = math-bold(numbers.sum())
    return (a, b).join(marks.math.equals)
}

#let fancy-arithmetic-sequence(a: none, k: none, n: none, labels: none, braces: none) = {
    let labels = resolve-array(labels)
    let elements = ()
    let last = n - 1
    let middle = int(last / 2)
    for i in range(n) {
        let label = if labels != none {
            if i == 0 and "first" in labels {
                "first"
            }
            else if i == middle and "middle" in labels {
                "middle"
            }
            else if i == last and "last" in labels {
                "last"
            }
        } else {
            none
        }
        let p = ( value: a + k * i, label: label )
        elements.push(p)
    }
    cetz.canvas({
        let offset = 0.5
        // offset is important for centering the values
        for (i, (label, value)) in elements.enumerate() {
            drawing.rect(i, 0, i + 1, 1, math-bold(value))
            if label != none {
                drawing.content(i + offset, -1 + offset, bold(label))
            }
        }
        let braces = resolve-array(braces)
        let k = 0.3
        for (i, brace-fn) in braces.enumerate() {
            let tuple = brace-fn(n, middle)
            let points = tuple.map((p) => (p + offset, i + 1 + k))
            let numbers = n-range(tuple, (x) => elements.at(x).value)
            let c = number-sum-content(numbers)
            drawing.brace(..points, c, stroke: strokes.soft)
        }
    })
}


// #fancy-arithmetic-sequence(
    // a: 1,
    // k: 3,
    // n: 7,
    // labels: ("middle"),
    // braces: (
        // (n, middle) => (middle - 1, middle + 1),
        // (n, middle) => (middle - 2, middle + 2),
        // (n, middle) => (middle - 3, middle + 3),
    // )
// )

