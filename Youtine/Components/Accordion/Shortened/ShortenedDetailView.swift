//
//  DetailView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ShortenedDetailView: View {
    var start: String
    var habitsCompleted: Int
    var habits: [Habit]
    
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
            Text("\(habitsCompleted)/\(habits.count)")
                .fontWeight(.thin)
        }
        Spacer()
    }
}

#Preview {
    ShortenedDetailView(
        start: "8:00 AM",
        habitsCompleted: 3,
        habits: testRoutines[0].habits
    )
}
