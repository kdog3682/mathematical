#import "@local/typkit:0.1.0": *

// 
#let lightning-question(s, number: 1) = {
    
}


// Shows a lightning bolt table for fast math questions
#let lightning-round(..sink) = {
    let questions = sink.pos()
    vertical-table(..globals.table-reset, ..questions)
    // it should be a table that goes downwards
}


#let question = lightning-question
#let round = lightning-round
