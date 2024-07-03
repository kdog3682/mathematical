#import "@local/typkit:0.1.0": *
#let factorial(n) = {
    let numbers =  range(n, 0, step: -1)
    math.equation(numbers.map(resolve-content).join(marks.math.times))
}

