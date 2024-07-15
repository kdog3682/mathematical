// located at time-travel-edition
#import "@local/typkit:0.1.0": *

#set page(paper: "us-letter")

#let KacperStudent = (
    grade: 6,
    name: "Kacper Jarecki",
)

#let do-time-travel-sidebar-message(year) = {
    let time-travel-text = text(
        size: 50pt,
        fill: blue,
        "TIME TRAVEL EDITION",
        weight: "bold",
    )
    let year-text = bold("(" + str(year) + ")", size: 50pt)
    let c = {
        time-travel-text
        h(20pt)
        year-text
    }
    let c = box(centered(c), width: 100%)
    return rotate(c, 270deg, reflow: true)
}
#let do-title(season, year, subject) = {

    let a = {
        text(season, size: 32pt)
        h(15pt)
        pattern-text(year, style: "criss-cross")
    }

    let b = bold(subject + " Workbook", size: 28pt)

    centered(a + v(10pt) + b)
    lines.soft
}
#let do-student(student) = {
    return colon("For student", student.name, size: 18pt, font: "courier")
}

#let cover(
    season: "Autumn",
    year: 1991,
    subject: "Math",
    student: KacperStudent,
) = {
    let title = do-title(season, year, subject)
    let student-line = do-student(student)

    let grade-level = text(
        "G" + str(student.grade),
        size: 50pt,
        weight: "bold",
    )

    let hmc-mark = [— Hammy Math Class ©#get-year() —]

    let top-content = {
        title
        v(10pt)
        student-line
    }
    // the main page part
    let body-content = {
        let pic = rect(width: 200pt, height: 200pt, fill: blue)
        placed(pic, center + horizon)
        placed(grade-level, right + bottom)
    }
    let table = table.with(inset: 0pt, stroke: none)
    let items = (
        table.cell(colspan: 2, top-content),
        do-time-travel-sidebar-message(year),
        table.cell(body-content),
    )

    let payload = table(columns: (auto, 1fr), rows: (auto, 1fr), ..items)
    page(
        footer: {
            placed(hmc-mark, bottom + center)
        },
        payload
    )
}

#cover()
