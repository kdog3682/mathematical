#import "@local/typkit:0.1.0": *
#import "@preview/cetz:0.2.2"
#import cetz.draw: *


#let main(..sink) = {

    draw.canvas({
        width: 100%
    })
    // rect(width: 100%, height: 100%, fill: blue, centered("HI", true))
}

#let sidebar(year) = {
    let s = text(
        "TIME TRAVEL EDITION",
        size: 48pt,
        fill: patterns.circles,
        spacing: 20pt,
        tracking: 3pt,
        weight: "bold",
        stroke: black + 0.25pt,
    )
    let t = text(
        size: 48pt,
        "(" + str(year) + ")",
        fill: patterns.cross,
        spacing: 20pt,
        tracking: 0pt,
        weight: "bold",
        stroke: black + 1pt,
    )

    centered(rotate(s + h(20pt) + t, 270deg, reflow: true), true)
}


#let time-travel(
    season: "Autumn",
    year: 1991,
    subject: "Math",
    student: StudentObject,
) = {

    page(
        ..pages.no-margin,
        grid(
            columns: (20%, 1fr),
            grid.cell(
                fill: black.lighten(95%),
                sidebar(year)
            ),
            grid.cell(
                main(season, year, subject, student)
            ),
        ),
    )
}
// #time-travel()
// inoreab <buffer> wh100 width: 100%, height: 100%<C-R>=Eatchar('\s')<CR>


