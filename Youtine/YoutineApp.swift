//
//  YoutineApp.swift
//  Youtine
//
//  Created by Bobby Guerra on 12/19/24.
//

import SwiftUI
import SwiftData

@main
struct YoutineApp: App {
    var routines = [
        Youtine(
            start: "8:00 am",
            title: "Morning Routine",
            todos: [
                Todo(label: "Wash Face", desc: "Use cetaphil cleanser"),
                Todo(label: "Shave", desc: "Slow manual shave"),
                Todo(label: "Moisture", desc: "Use moisturizer with SPF 50 minimum")
            ],
            borderColor: .yellow
        ),
        Youtine(
            start: "12:00 pm",
            title: "Afternoon Routine",
            todos: [
                Todo(label: "Wash Face", desc: "Use cetaphil cleanser"),
                Todo(label: "Shave", desc: "Slow manual shave"),
                Todo(label: "Moisture", desc: "Use moisturizer with SPF 50 minimum")
            ],
            borderColor: .blue
        ),
        Youtine(
            start: "8:00 pm",
            title: "Night Routine",
            todos: [
                Todo(label: "Wash Face", desc: "Use cetaphil cleanser"),
                Todo(label: "Shave", desc: "Slow manual shave"),
                Todo(label: "Moisture", desc: "Use moisturizer with SPF 50 minimum")
            ],
            borderColor: .red
        )
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView(routines: routines)
        }
        .modelContainer(for: [Youtine.self, Todo.self])
    }
}
