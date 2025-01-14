#import "@local/typkit:0.1.0": *

#let equals = marks.math.equals

#let wde(x) = {
    let mc = mathup(x)
    [*What does #mc equal?*]
}

#let find-x(x, target: "x") = {
    let mc = mathup(x)
    [*Find $#target$:* #h(7pt) #mc]
}

#let x-equals(x, answer) = {
    let mc = mathup(x)
    let opts = (fill: blue.lighten(80%), baseline: 25%, stroke: none)
    let p = pill([*$x$ equals #answer.*], ..opts)
    [#mc.  #h(5pt) #p]
}

#let answer-x(x, target: "x") = {
    let mc = mathup(x)
    [The answer is #h(3pt) #boxy([*#target #equals #mc*])]
}

#let labeled(label, c) = {
    boxy([*#label #equals #mathup(c)*])
}


// #table(inset: 10pt,
    // find-x("a^1 * a^2 * a^3 = a^(x/2)"),
    // x-equals($1 + 2 + 3 = display(x/2)$, 12),
    // answer-x("a^(3x)", target: "b"),
    // wde("a + b"),
    // boxy("x^2 times 5"),
// )


// #boxy([#boxy(123) is cool])


#let bubbles(a, b) = {
    let s = [
        Choice #upper(a): #b
    ]
    boxy(s, inset: 10pt)
}

