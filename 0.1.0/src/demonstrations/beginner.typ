#import "@local/typkit:0.1.0": *


#let ratio(size: 12, ratios: (1, 2)) = {
    assert-is-ratio-divisible(size, ratios)
    let d = ratios.sum()
    let chunks = ratios.map((n) => int(size * n / d))
    panic(chunks)
}
// #svg-test(ratio)
// 
