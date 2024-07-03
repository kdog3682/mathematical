#import "@local/typkit:0.1.0": *
#import "typesetting.typ": boxy

#let evaluate-string(s) = {
    let answer = eval(s, mode: "code")
    let computed = str-sub(s, " +\* +", " #times ")
    let mc = mathup(computed + " = " + str-call("bold", answer))
    mc
}

#let evaluate(s) = {
    if is-string(s) {
        return evaluate-string(s)
    }
    todo("not done yet ... only have evaluate-string")
}

// #evaluate("10 * 8")
