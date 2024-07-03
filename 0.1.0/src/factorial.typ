#import "@local/typkit:0.1.0": *


#let factorial(n, cancels: none, limit: 10, left: 3, right: 3, delimiter: "times", connector: "dots", highlight-remaining: false, highlight-color: "blue") = {

    let delimiters = (
        "times": marks.math.times,
        "dot": marks.math.dot,
    )
    let delimiter = delimiters.at(delimiter)

    let connectors = (
        "dots": marks.math.dots,
    )
    let connector = connectors.at(connector)
    let singleton = n > limit
    // panic(singleton)

    let callback(n) = {
       let mc = resolve-content(n)
       if cancels == none {
          return mc
       } else if cancels >= n {
           return math.cancel(mc)
       } else if singleton == false {
           let value = math.bold(mc)
           return tern(highlight-remaining, colored(value, highlight-color), value)
       } else {
           mc
       }
    }

    if singleton == true {
        let a = range(n, n - left, step: -1).map(callback)
        let b = range(right, 0, step: -1).map(callback)
        let d = a.join(delimiter)
        let e = b.join(delimiter)
        return math.equation((d, e).join(connector))
    } else {
        let numbers = range(n, 0, step: -1)
        return math.equation(numbers.map(callback).join(delimiter))
    }
}
