//
//  Routine.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/13/25.
//

import SwiftData
import Foundation

@Model
class Youtine {
    var id: UUID
    var start: Date
    var todos: [Todo]

    init(start: Date, todos: [Todo]) {
        self.id = UUID()
        self.start = start
        self.todos = todos
    }
}

@Model
class Todo {
    var id: UUID
    var label: String
    var desc: String
    
    init(label: String, desc: String) {
        self.id = UUID()
        self.label = label
        self.desc = desc
    }
}
