#import "@local/typkit:0.1.0": mathup
#let fraction(a, b, align: false) = {
    let a = mathup(a)
    let b = mathup(b)
    if align == true and false == true {
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
