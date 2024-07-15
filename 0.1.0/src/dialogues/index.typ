#import "layouts/singleton-meta-layout.typ": singleton-meta-layout
#import "base-dialogue.typ": base-dialogue as dialogue-layout
#import "dialogue-layout.typ": dialogue-layout

#let singleton = base-dialogue.with(meta-layout: singleton-meta-layout)

// /home/kdog3682/projects/typst/mathematical/0.1.0/src/academic/multiple-choice-question.typ
// /home/kdog3682/projects/typst/mathematical/0.1.0/src/academic/index.typ

#let run(items, meta) = {
    let meta-layout = layouts.at(meta.kind)
    set page(..pages.dialogue)
    meta-layout(meta)
    dialogue-layout(items)
}

