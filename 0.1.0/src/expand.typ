
#import "@local/typkit:0.1.0": *


#let is-exponent-content(c) = {
    test(s, "\^$")
}

#let is-factorial(s) = {
    test(s, "!$")
}

#let is-fraction(s) = {
    test(s, "!$")
}

#let is-multiplication(s) = {
    test(s, "!$")
}

#let expand-string(s, evaluate: false) = {
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
    }
}
#let expand-content(c) = {
    if is-exponent-content(c) {
        // base and body
    }
}

#let expand(s, evaluate: false) = {
    if is-string(s) {
        expand-string(s, evaluate: evaluate)
    } else {
        expand-content(s)
    }
}


#expand("3!")
// #panic(expand("3!"))
