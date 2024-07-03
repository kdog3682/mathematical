#import "@local/typkit:0.1.0": *
#import "factorial.typ*: factorial

#let colored(x, fill) = {
    text(resolve-content(x), fill: resolve-color(fill))
}

#let fraction(a, b, align: false) = {
    let a = mathup(a)
    let b = mathup(b)
    if align == true {
        context {
            let la = measure(a).width
            let lb = measure(b).width
            let p = la - lb
            if p > 0pt {
                // add padding to the bottom
                // TODO: needs to not align
                math.display(math.frac(a, h(p) + b))
            } else {
                // add padding to the top
                math.display(math.frac(h(-1 * p) + a, b))
            }
        }
    } else {
        math.display(math.frac(a, b))
    }
}

#let factorial-fraction(a, b, top: none, bottom: none, align: false, delimiter: "times", cancel: false, lhs: none) = {
    let top-base = (
        left: 3,
        right: 3,
        fill: blue,
    )
    
    let bottom-base = (
        left: 3,
        right: 3,
        fill: purple,
    )

    let top = merge-dictionaries(top-base, top)
    let bottom = merge-dictionaries(bottom-base, bottom)
    let delimiter = if delimiter == "times" {
        marks.math.times
    } else {
        marks.math.dot
    }
    let connector = marks.math.dots

    let runner(n, opts) = {
        if n <= 10 {
            return text(factorial(n) fill: resolve-color(opts.fill))
        }
        let a = range(n, n - opts.left, step: -1)
        let b = range(opts.right, 0, step: -1)
        let c = {
            let d = a.map(resolve-content).join(delimiter)
            let e = b.map(resolve-content).join(delimiter)
            colored((d, e).join(connector), opts.fill)
        }
        return c
    }
    if cancel == true {
        // hmm i dunno
    }
    let numerator = runner(a, top)
    let denominator = runner(b, bottom)
    let rhs = fraction(numerator, denominator, align: align)
    if lhs != none {
        let lhs = fraction(colored(a, top.fill), colored(b, bottom.fill))
        return (lhs, boxy(rhs)).join(marks.math.equals)
    } else {
        return rhs
    }
}
// #factorial-fraction(556, 55)
// #factorial-fraction(556, 55, align: true)

#factorial-fraction(
    top: ( value: 10, left: 5, fill: "none"),
    bottom: ( value: 6, left: 5, fill: "none", hide: false),
    cancel: true
)

// #import "factorial-fraction.typ": factorial-fraction
// $display(#blue($999!$)/#purple($998!$)) = display(#blue($999 * 998 * 997 * 996 ... -> -> 3 * 2 * 1$)/#purple($#hide($999 *$) cancel(998) * 997 * 996 -> -> -> 3 * 2 * 1$))$

