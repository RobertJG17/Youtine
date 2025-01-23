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
    var index: Int
    var start: String
    var daysJSON: String // Store days as JSON string
    var borderColor: String
    @Relationship(deleteRule: .cascade) var habits: [Habit] = [] // Proper relationship

    init(
        index: Int,
        start: String,
        days: [Int: String],
        borderColor: Color,
        habits: [Habit]
    ) {
        self.id = UUID() // Generate a unique identifier
        self.index = index
        self.start = start
        self.daysJSON = Youtine.encodeDays(days)
        self.borderColor = borderColor.description
        self.habits = habits
    }
    

    // Helper to encode days dictionary into JSON
    static func encodeDays(_ days: [Int: String]) -> String {
        guard let data = try? JSONEncoder().encode(days),
              let jsonString = String(data: data, encoding: .utf8) else {
            return "{}" // Return empty JSON if encoding fails
        }
        return jsonString
    }

    // Helper to decode days JSON back into a dictionary
    static func decodeDays(_ daysJSON: String) -> [Int: String] {
        guard let data = daysJSON.data(using: .utf8),
              let decoded = try? JSONDecoder().decode([Int: String].self, from: data) else {
            return [:] // Return empty dictionary if decoding fails
        }
        return decoded
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
