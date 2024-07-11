#context {
    let c = counter("a")
    c.step()
    let x = c.get()
    c.step()
    c.step()
    panic(str(c.final().at(0)))
}

// #context {
    // let s = state("x", 1)
    // s.update((x) => x + 2)
    // panic(s.final())
// }
