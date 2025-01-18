//
//  Routine.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/13/25.
//

import SwiftData
import SwiftUI

@Model
class Youtine: Identifiable {
    var id: UUID
    var start: String
    var days: [String]
    var title: String
    var habits: [Habit]
    var borderColor: String
    
    init(
        start: String,
        days: [String],
        title: String,
        habits: [Habit],
        borderColor: Color
    ) {
        self.id = UUID()
        self.start = start
        self.days = days
        self.title = title
        self.habits = habits
        self.borderColor = borderColor.description
    }
}

@Model
class Habit: Identifiable {
    var id: UUID
    var label: String
    var desc: String
    var completed: Bool
    
    init(label: String, desc: String) {
        self.id = UUID()
        self.label = label
        self.desc = desc
        self.completed = false
    }
}
