#import "@local/typkit:0.1.0": *
#import "@local/mathematical:0.1.0": *

#let fractions-from-ratios(..sink) = {
    let args = sinks.pos()
    assert-is-color-value-object-array(args)
    let values = args.map((x) => x.value)
    let d = values.sum()
    let callback(o) = {
        return colored(fraction(o.value, d), o.fill)
    }
    let fractions = args.map(callback)
    let ratio-items = map(values, colored, o.fill).intersperse(marks.math.colon)
}


#fractions-from-ratios(
    (fill: "blue", value: 4),
    (fill: "purple", value: 5),
)
