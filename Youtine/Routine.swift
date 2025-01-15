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
    var title: String
    var todos: [Todo]
    var borderColor: String
    
    init(
        start: String,
        title: String,
        todos: [Todo],
        borderColor: Color
    ) {
        self.id = UUID()
        self.start = start
        self.title = title
        self.todos = todos
        self.borderColor = borderColor.description
    }
}

@Model
class Todo: Identifiable {
    var id: UUID
    var label: String
    var desc: String
    var completed: Bool
    
    init(label: String, desc: String, completed: Bool = false) {
        self.id = UUID()
        self.label = label
        self.desc = desc
        self.completed = completed
    }
}
