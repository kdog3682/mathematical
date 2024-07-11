#import "@preview/riesketcher:0.2.0": riesketcher

#riesketcher(
    x => -calc.pow(x, 2) + 9,
    domain: (-4, 4),
    start: -3,
    end: 3,
    n: 6,
    plot-x-tick-step: 1,
)
