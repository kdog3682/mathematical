#import "@local/typkit:0.1.0": *

#let is-divisible(a, b) = {
    return calc.rem(a, b) == 0
}
#let assert-is-ratio-divisible(n, ratios) = {
    assert(is-divisible(n, ratios.sum()), message: "the ratios do not evenly divide the size")
}


#let ratio(size: 12, ratios: (1, 2)) = {
    assert-is-ratio-divisible(size, ratios)
    let d = ratios.sum()
    let chunks = ratios.map((n) => int(size * n / d))
    panic(chunks)
}
#let ratio(size: 12, ratios: (1, 2), fills: ("blue", "green")) = {
    let store = ()
    let d = ratios.sum()
    let n = int(size / d)
    let callback((i, n)) = {
        let fill = fills.at(i, default: none)
        return colored(resolve-math-content(n), fill)
    }
    let p = ratios.enumerate().map(callback).join(marks.math.plus)
    for n in range(1, n + 1) {
        let t = [*total: * $#(n * d)$]
        store.push((p, t))
    }
    x-table(..store, align: horizon + left)


}

// #svg-test(ratio)
// 
