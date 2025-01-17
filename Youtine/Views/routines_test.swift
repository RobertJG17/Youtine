//
//  routines.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import Foundation

var testRoutines: [Youtine] =
    [
        Youtine(
            start: "8:00 am",
            title: "Morning Routine",
            todos: [
                Todo(
                    label: "Wash Face",
                    desc: "Use cetaphil cleanser"
                ),
                Todo(
                    label: "Shave",
                    desc: "Slow manual shave"
                ),
                Todo(
                    label: "Moisture",
                    desc: "Use moisturizer with SPF 50 minimum"
                )
            ],
            borderColor: .yellow
        ),
        Youtine(
            start: "12:00 pm",
            title: "Afternoon Routine",
            todos: [
                Todo(
                    label: "Wash Face",
                    desc: "Use cetaphil cleanser"
                ),
                Todo(
                    label: "Shave",
                    desc: "Slow manual shave"
                ),
                Todo(
                    label: "Moisture",
                    desc: "Use moisturizer with SPF 50 minimum"
                )
            ],
            borderColor: .blue
        ),
        Youtine(
            start: "8:00 pm",
            title: "Night Routine",
            todos: [
                Todo(
                    label: "Wash Face",
                    desc: "Use cetaphil cleanser"
                ),
                Todo(
                    label: "Shave",
                    desc: "Slow manual shave"
                ),
                Todo(
                    label: "Moisture",
                    desc: "Use moisturizer with SPF 50 minimum"
                )
            ],
            borderColor: .red
        )
    ]
