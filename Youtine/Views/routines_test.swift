//
//  routines.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import Foundation

var testRoutines: [Youtine?] =
    [
        Youtine(
            start: "8:00 AM",
            days: ["M", "W", "F"],
            title: "Morning Routine",
            habits: [
                Habit(
                    label: "Wash Face",
                    desc: "Use cetaphil cleanser"
                ),
                Habit(
                    label: "Shave",
                    desc: "Slow manual shave"
                ),
                Habit(
                    label: "Moisturize",
                    desc: "Use moisturizer with SPF 50 minimum"
                ),
                Habit(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                ),
                Habit(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                ),
                Habit(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                ),
                Habit(
                    label: "Code",
                    desc: "Learn iOS for at least 20 mins a day"
                )
            ],
            borderColor: .yellow
        ),
        Youtine(
            start: "12:00 PM",
            days: ["M", "W", "F"],
            title: "Afternoon Routine",
            habits: [
                Habit(
                    label: "Wash Face",
                    desc: "Use cetaphil cleanser"
                ),
                Habit(
                    label: "Shave",
                    desc: "Slow manual shave"
                ),
                Habit(
                    label: "Moisture",
                    desc: "Use moisturizer with SPF 50 minimum"
                )
            ],
            borderColor: .blue
        ),
        nil
//        Youtine(
//            start: "8:00 PM",
//            days: ["M", "W", "F"],
//            title: "Night Routine",
//            habits: [
//                Habit(
//                    label: "Wash Face",
//                    desc: "Use cetaphil cleanser"
//                ),
//                Habit(
//                    label: "Shave",
//                    desc: "Slow manual shave"
//                ),
//                Habit(
//                    label: "Moisture",
//                    desc: "Use moisturizer with SPF 50 minimum"
//                )
//            ],
//            borderColor: .red
//        )
    ]
