#import "@local/typkit:0.1.0": *
#let extended-meta-content(meta) = {
    let description = meta.at("description", default: none)
    if empty(description) {
        return do-simple-meta-content(meta)
    }

    let subtitle = meta.at("subtitle", default: none)
    let subject = meta.at("subject", default: none)
    let topic = meta.at("topic", default: none)
    let tags = meta.at("tags", default: none)

    let title = meta.title
    let skills = meta.skills
    let speakers = meta.speakers
    let requirements = meta.requirements
    // let assignment-id = meta.assignment-id
    // let student-group = meta.student-group
    // let team-id = 7
    // let team-name = templater("Team $1", team-id)

    let get-name(s) = {
        return split(s, " ").at(0)
    }

    let students = speakers.map(get-name)
    let scope = (
        students: oxford(students)
    )
    let raw = templater(meta.description, scope)
    let description = markup(raw, typkit) 

    let score-box = {
        [*Points:* #h(10pt) #rect()]
    }

    // set text(size: 1.7em)
    let season = "Summer 2024"
    let title-content = {
        let a = {
            ink.blue(h2(title))
            v(-10pt)
            if subtitle != none {
                text(subtitle, font: "Inconsolata")
                // if topic != none {
                    // -50 determines the placement for the topic pill
                    // place(color-match(topic), dy: -50pt)
                // }
            }
            else if topic != none {
                h4(topic)
            }
        }
        let b = box(inset: 5pt, radius: 5pt, stroke: strokes.soft, {
            h3(meta.class)
            v(-10pt)
            ink.blue(season)
            v(3pt)
        })
        table(a, b, columns: (auto, 1fr), align: (left, right), stroke: none)
    }

    // looks very neat
    let colon-content = colon(
        join: "newlines",
        "speakers", bullet(speakers),
        "skills", bullet(skills),
        "requirements", bullet(requirements),
    )

    let colon-content = {
        let a = bullet(speakers, label: "speakers")
        let b = bullet(skills, label: "skills")
        let c = bullet(requirements, label: "requirements")
        stack(a, b, c, spacing: 20pt)
    }

    // let colon-content = {
        // let a = bullet(speakers, label: "speakers")
        // let b = bullet(skills, label: "skills")
        // let c = bullet(requirements, label: "requirements")
        // stack(dir: ltr, spacing: 10pt, a, b, c)
    // }

    title-content
    dashbreak(style: "spacebar")

    let pill = text(color-match(topic), size: 0.8em)
    context {
        let measurement = measure(pill).width
        let loc = (
            dy: -5pt,
            dx: 100% - measurement,
        )
        place(pill, ..loc)
    }
    // colon-content
    // description
    table(
        columns: (auto, 1fr),
        stroke: none,
        column-gutter: 15pt,
        colon-content,
        table.cell(
         align: center + horizon,
         box(emph(text(description, size: 0.95em)), width: 65%)
        )
    )
    v(5pt)
    // css-flex(
        // align: "apart",
        // columns: (50%, 1fr),
        // colon-content,
        // score-box
    // )
    dashbreak(style: "topbar")
}


