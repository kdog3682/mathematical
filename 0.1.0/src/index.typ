#import "typesetting.typ": *
#import "utils.typ": *
#import "dialogue.typ": dialogue
#import "expand.typ": expand, expansion
#import "evaluate.typ": evaluate
#import "factorial-fraction.typ": factorial-fraction
#import "factorial.typ": factorial
#import "fraction.typ": fraction
#import "lightning.typ"
#import "homework-question.typ": homework-question
#import "expanded-factorial-multiplication.typ": expanded-factorial-multiplication

// mathtools are kind of different from demos
// although they are similarly complex


// ------------------------------------------------------------
// ------------------------------------------------------------
// 07-10-2024 
// demonstrations/index.typ is being converted into demos

#import "algorithms/index.typ" as algorithms
// 1: convex-hull

#import "mathtools/index.typ" as mathtools
// it almost feels like the two of these should be combined together
// demonstrations has been deprecated
#import "draw/index.typ" as draw
// draw/index.typ operates via:
// draw.shapes.points(points: array, ..attrs)
// draw.brace(p1, p2, content?, ..attrs)
// it uses many utils from mathematical/utils.typ

// what did i do today?
// the stuff above is what i did today
// ------------------------------------------------------------
// ------------------------------------------------------------

// #import "demos/index.typ" as demos
// #cannot import demos
// cyclic backtrace happens when demos/index.typ is imported
// the reason is because it imports ratio.typ which imports mathematical
// and hey, it just so happens this file is mathematical.
// thus, the cyclic backtrace
#import "dialogues/index.typ" as dialogues
