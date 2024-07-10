#import "@local/typkit:0.1.0": *

#let long-multiplication-v0(a, b) = {
    let top = split(a).map(int)
    let bottom = split(b).map(int)
    let top-rev = top.rev()
    let bottom-rev = bottom.rev()

    let store = bottom-rev.enumerate().map(((i, b)) => {
        let answer-row = ()
        let carry-row = ()
        for (j, t) in top-rev.enumerate() {
          let a = t * b
          let l = len(a)
          if l > 1 {
            let (c, d) = split(a).map(int)
            carry-row.push(c)
            answer-row.push(d)
          } else {
            carry-row.push("")
            answer-row.push(a)
          }
        }
        return (
            answer-row: answer-row,
            carry-row: carry-row,
        )
    })
    // (6,1), (5,1)  
    // panic(store)
    let x-length = len(top)
    let y-length = len(bottom)

    let c = 0
    for row in store {
        for el in row {
            c += 1

            if steps == c {
                break
            }
        }
        if steps == c {
            break
        }
    }

}
#let long-multiplication(a, b, steps: 100) = {
    let top = split(a).map(int)
    let bottom = split(b).map(int)

    let get(n) = {
        return if n < 10 {
            (none, n)
        } else {
            split(n).map(int)
        }
    }

    let get-operations(top, bottom) = {
        let top-rev = top.rev()
        let bottom-rev = bottom.rev()
        let operations = ()
        let c = 0
        for (row-index, b) in bottom-rev.enumerate() {
            for t in top-rev {
                if steps == c {
                    return operations
                }
                c += 1
                let a = t * b
                let (carry, value) = get(a)
                operations.push((
                    carry: carry,
                    value: value,
                    row-index: row-index,
                ))
            }
        }
        return operations
    }
    let operations = get-operations(top, bottom)

    let x-length = len(top)
    let y-length = len(bottom)
    let answer-row = ()
    let carry-row = ()
    for op in operations.slice(0, x-length) {
        carry-row.push(op.carry)
        answer-row.push(op.value)
    }

    let r1 = top
    let r2 = bottom
    panic(carry-row, answer-row)

    let c = 0
    for row in store {
        for el in row {
            c += 1

            if steps == c {
                break
            }
        }
        if steps == c {
            break
        }
    }

}
#long-multiplication(56, 12)

