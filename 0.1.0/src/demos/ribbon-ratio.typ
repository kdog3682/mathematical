#import "@local/typkit:0.1.0": *
#import "@local/mathematical:0.1.0": *

#let ribbon-ratio(size: Integer, ratios: RatioObjectArray) = {

    let values = ratios.map((x) => x.value)
    let d = values.sum()


    let callback(rob) = {
        return colored(fraction(rob.value, d), rob.fill)
    }
    let callback-2(rob) = {
        let f = math.bold(callback(rob))
        let answer = math.bold(str(int(size * rob.value / d)))
        let v = math.equation(f + $times #size = #answer$)

        centered(stack(30pt, f, v, spacing: 15pt))
    }
    // colored fractions based on ratio values
    // let fractions = ratios.map(callback)

    draw.canvas({
        draw.brace((0, 1), (d, 1), size, side: "inside")
        let step = 0
        for ratio in ratios {
            let start = step
            let fill = resolve-fill(ratio.fill)

            for i in range(ratio.value) {
                draw.shapes.square((step, 0), fill: fill)
                step += 1
            }
            draw.brace((start, 0), (step, 0), fill: fill, side: "outside", callback-2(ratio))
        }
    })



}



#ribbon-ratio(
    ratios: (
        (fill: "blue", value: 4),
        (fill: "purple", value: 5),
    ),
    size: 63, 
)
