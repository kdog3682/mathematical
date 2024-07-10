#import "@local/typkit:0.1.0": *


#let expand-string(s, evaluate: false, show-original: false, fill: none) = {
    if is-factorial(s) {
        let m = int(match(s, "\d+"))
        let numbers = range(m, 0, step: -1)
        let a = numbers.map(resolve-content).join(marks.math.times)
        if evaluate == true {
            let b = math.bold(str(numbers.product()))
            return math.equation((a, b).join(marks.math.equals))
        } else {
            return math.equation(a)
        }
    }
    else if is-multiplication(s) {
        let (a, b) = get-integers(s)
        let ans = a * b
        let store = ()
        let smaller = text.with(size: sizes.small)
        let items = map(b, (x) => $#colored(a, fill)$).intersperse(sym.plus).map(smaller)
        let attrs = (
            stroke: none,
            align: horizon + center,
            columns: b,
            inset: 2pt,
        )
        let content = table(..items, ..attrs)
        let repeated = boxy(content, stroke: strokes.soft)

        store.push(repeated)
        store.push(marks.math.equals)
        store.push(boxy($#ans$))

        if show-original == true {
            store.insert(0, marks.math.arrow)
            store.insert(0, mathup(s))
        }
        return math.equation(store.join())
    }
}
#let expand-content(c) = {
    if is-exponent-content(c) {
        // base and body
    }
}

#let expand(s, ..sink) = {
    if is-string(s) {
        expand-string(s, ..sink)
    } else {
        expand-content(s, ..sink)
    }
}
#let expansion(..sink) = {
    return expand(..sink)
}



// #expand("4 times 8")
// #panic(expand("3!"))
