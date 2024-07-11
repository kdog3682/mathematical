#import "@local/typkit:0.1.0": *

#let proportion-table(a, b, count: auto) = {
    let get(x, n) = {
        if is-number(x) {
            return $#{x * n}$
        } else {
            let (c, d) = x.split("/").map(int)
            return [$#{n * c}/#d$]
        }
    }

    let callback(n) = {
        return (get(a, n), get(b, n))
    }

    if count == auto {
        count = int(if is-str-frac(a) { a.at(0) } else { b.at(0) })
        count = if is-str-frac(a) {
            a.split("/").map(int).at(1)
        } else {
            b.split("/").map(int).at(1)
        }
        assert(is-number(count), message: "count is required")
    }
    let items = range(1, count + 1).map(callback)
    x-table(..items, dir: "H")
}

// #svg-test(
    // proportion-table("1/8", 9),
    // proportion-table("1/8", "1/5"),
    // proportion-table(6, "1/5"),
// )
