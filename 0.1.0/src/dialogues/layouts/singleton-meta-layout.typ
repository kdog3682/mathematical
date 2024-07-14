#import "@local/typkit:0.1.0": *
#let singleton-meta-layout(meta) = {
    let left = context {
        let size = 1.5em
        let a = bold(meta.topic, size: size)
        let h = measure(a).height * 2
        let b = ink.blue(bold(meta.title, size: size))
        let separator = line(length: h, angle: 90deg)
        base-flex(spacing: 10pt, a, separator, b)
    }
    let b = pill({
        let size = 0.9em
        align(h3(meta.class), right)
        v(-10pt)
        align(bold(meta.assignmentType, size: size), right)
        v(-7pt)
        align(ink.blue(meta.season, size: size), right)
        v(3pt)
    }, inset: 8pt)

    css-flex(left, b, align: "apart", columns: (auto, 1fr))
    lines.soft
    v(15pt)
}



