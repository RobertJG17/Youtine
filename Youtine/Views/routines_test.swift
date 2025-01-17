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
            days: ["M", "W", "F"],
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
                    label: "Moisturize",
                    desc: "Use moisturizer with SPF 50 minimum"
                ),
                Todo(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                ),
                Todo(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                ),
                Todo(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                ),
                Todo(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                )
            ],
            borderColor: .yellow
        ),
        Youtine(
            start: "12:00 pm",
            days: ["M", "W", "F"],
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
            days: ["M", "W", "F"],
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
