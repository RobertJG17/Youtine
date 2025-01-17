//
//  DetailView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ShortenedDetailView: View {
    var start: String
    var tasksCompleted: Int
    var todos: [Todo]
    
    var body: some View {
        HStack {
            Text("Start Time: ")
                .fontWeight(.thin)
            Spacer()
            Text(start)
                .fontWeight(.thin)
        }
        HStack {
            Text("Tasks Completed: ")
                .fontWeight(.thin)
            Spacer()
            Text("\(tasksCompleted)/\(todos.count)")
                .fontWeight(.thin)
        }
        Spacer()
    }
}

#Preview {
    ShortenedDetailView(
        start: "8:00 a.m.",
        tasksCompleted: 3,
        todos: testRoutines[0].todos
    )
}
