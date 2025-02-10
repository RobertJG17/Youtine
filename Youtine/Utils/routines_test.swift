//
//  routines.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/16/25.
//

import SwiftUI

var testRoutines: [Routine?] =
    [
        Routine(
            index: 0,
            start: "8:00 AM",
            days: [0: "M", 1: "W", 2: "F"],
            borderColor: .red,
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
            ]
        ),
        Routine(
            index: 1,
            start: "12:00 PM",
            days: [0: "M", 1: "W", 2: "F"],
            borderColor: .blue,
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
            ]
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
