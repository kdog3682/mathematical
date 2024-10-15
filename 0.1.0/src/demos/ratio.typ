#import "@local/typkit:0.1.0": *
#import "@local/mathematical:0.1.0": *

#let ratio(size: 12, ratios: (1, 2), fills: ("blue", "green")) = {
    let store = ()
    let d = ratios.sum()
    let n = int(size / d)
    let callback((i, n)) = {
        return colored(resolve-math-content(n), getter(fills, i))
    }
    let p = ratios.enumerate().map(callback).join(marks.math.plus)
    for n in range(1, n + 1) {
        let t = [*total: * $#(n * d)$]
        store.push((p, t))
    }
    x-table(..store, align: horizon + left)
}


#let ribbon-ratio(size: 12, ratios: (1, 2), fills: ("blue", "green")) = {
    let d = ratios.sum()
    let x = 0

    draw.canvas({
        for (index, n) in ratios.enumerate() {
            let amount = int(size * n / d)
            for i in range(amount) {
                let pos = (s.get().at(0), 0)
                square(pos, getter(fills, index))
                s.step()
            }
        }
        map(size, square())
    })
}


ratio()
