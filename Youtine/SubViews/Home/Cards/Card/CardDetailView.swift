//
//  DetailView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CardDetailView: View {
    var start: String
    var habitsCompleted: Int
    var habits: [Habit]
    
    var body: some View {
        VStack {
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
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CardDetailView(
        start: "8:00 AM",
        habitsCompleted: 3,
        habits: testRoutines[0]!.habits
    )
}
