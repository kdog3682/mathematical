#import "@local/typkit:0.1.0": *

#let KacperStudent = (
    grade: 6,
    name: "Kacper Jarecki",
)

#let do-time-travel-sidebar-message(year) = {
    let time-travel-text = pattern-text(
        "TIME TRAVEL EDITION",
    )
    let year-text = bold("(" + str(year) + ")", size: 32pt, fill: blue)
    let c = {
        time-travel-text
        h(20pt)
        year-text
    }
    let c = box(centered(c), width: 100%, fill: patterns.dots, outset: 15pt)
    return rotate(c, 270deg, reflow: true)
}
#let do-grade-level(grade) = {
    let g6 = text(
        "G" + str(grade),
        size: 50pt,
        weight: "bold",
        font: "PT Sans",
    )

    return rect(centered(g6, true), fill: patterns.stripes, inset: 10pt)
}

#let do-title(season, year, subject, grade) = {


    let a = {
        bold(season, size: 26pt)
        h(10pt)
        pattern-text(year, style: "criss-cross", size: 26pt)
    }

    let b = bold(subject + " Workbook", size: 32pt)

    centered({
        b
        v(-15pt)
        a
    })

    // it doesnt look that good
    // it looks squished together
    // grid(
        // rows: 2,
        // columns: 2,
        // row-gutter: 10pt,
        // column-gutter: 20pt,
        // grid.cell(
            // rowspan: 2,
            // align: center,
            // fill: black,
            // text(g6, fill: white)
        // ),
        // b,
        // a,
    // )

}
#let do-student(student) = {
    return colon("For student", student.name, size: 18pt, font: "courier")
}

#let cover(
    season: "Autumn",
    year: 1991,
    subject: "Math",
    student: KacperStudent,
) = context {

    let title = do-title(season, year, subject, student.grade)
    let student-line = do-student(student)

    let hmc-mark = [— Hammy Math Class ©#get-year() —]

    let main-content = block(height: 100%, {
        title
        v(10pt)
        // centered(student-line)
        let pic = rect(width: 200pt, height: 200pt, fill: blue.transparentize(75%))
        centered(pic)
        // placed(pic, center + horizon)
        // placed(grade-level, right + bottom)
    })

    // let time-travel = do-time-travel-sidebar-message(year)

    let time-travel = do-time-travel-sidebar-message(year)
    let width = measure(time-travel).width
    let dots = rect(width: 100%, height: 100%, fill: yellow,
    inset: 20pt, {
        // text("HI")
        // text("HI")
        // text("HI")
        // text("HI")
        placed(time-travel, left)
    })
    let background = {
        dots
    }
    let page-content = main-content
    // let page-content = stacked(h(width), main-content)

    page(
        paper: "us-letter",
        footer: {
            placed(hmc-mark, bottom + center, inset: 20pt)
        },
        background: background,
        page-content,
    )

}

#cover()
