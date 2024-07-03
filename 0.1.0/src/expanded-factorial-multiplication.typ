#import "@local/typkit:0.1.0": *

#let expanded-factorial-multiplication(..sink) = {
    let rows = sink.pos()
    let start = rows.at(0).flatten().at(0)
    let top-row = range(start, 0, step: -1)
    context {
        
    }
}



#let expanded-factorial-multiplication(..sink) = {
    let arr = rotate(sym.arrow, 90deg)
    let rows = sink.pos()
    let start = rows.at(0).flatten().at(0)
    let top-row = range(start, 0, step: -1)
    let e = top-row.map(x => [#x]).intersperse($sym.times$)
    e.push(hide([1]))
    e.push(hide([1]))
    e.push(table.cell(align: center, colspan: 3, arr))
    e.push(hide([1]))
    e.push(table.cell(align: center, colspan: 3, arr))
    e.push(hide([1]))
    e.push(hide([1]))
    e.push(hide([1]))
    e.push(hide([1]))
    e.push(table.cell(align: center, colspan: 3, [20]))
    e.push(hide([1]))
    e.push(table.cell(align: center, colspan: 3, [6]))
    e.push(hide([1]))
    e.push(hide([1]))
    e.push(table.cell(inset: 10pt, align: center, colspan: 11, $6 times 20 times 6 times 1= bold(720)$))
    table(columns: 11, ..e, stroke: none)

}
