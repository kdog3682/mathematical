
#import "@local/typkit:0.1.0": *


#let create-fractions-from-ratios(..sink) = {
    let args = sinks.pos()
    assert-is-color-value-object-array(args)
    let values = args.map((x) => x.value)
    let d = values.sum()
    let callback(o) = {
        return colored(frac(o.value, d), o.fill)
    }
    let fractions = args.map(callback)

    let ratio-items = map(values, colored, o.fill).intersperse(marks.math.colon)

    fletcher-canvas({
        for (i, ratio-item) in ratio-items.enumerate() {
            node(0, 0, ratio)
            
        }
        for ratio-item in ratio-items {
            node()
        }
    })

}

