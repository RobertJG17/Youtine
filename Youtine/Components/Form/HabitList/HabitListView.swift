//
//  HabitListView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct HabitListView: View {
    @Binding var habits: [Habit]
    @Binding var showingCreateHabit: Bool
    @Binding var currentLabel: String
    @Binding var currentDesc: String
    @Binding var currentHabitID: UUID?
    
    var body: some View {
        List($habits, id: \.id, editActions: .all) { todo in
            let label = todo.label.wrappedValue
            let desc = todo.desc.wrappedValue
        
            HStack {
                VStack(alignment: .leading) {
                    Text(label)
                    Text(desc)
                        .font(.caption)
                        .fontWeight(.light)
                        .truncationMode(.tail)
                }
                
                Spacer()
                
                // TODO: Create edit pencil and use Tip Kit for swipe to delete action
                Button {
                    // MARK: Capture properties in state to initialize CreateHabitView with
                    currentLabel = label
                    currentDesc = desc
                    currentHabitID = todo.id
                    
                    showingCreateHabit = true
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

#Preview {
    HabitListView(
        habits: .constant(testRoutines[0]!.habits),
        showingCreateHabit: .constant(false),
        currentLabel: .constant(""),
        currentDesc: .constant(""),
        currentHabitID: .constant(UUID())
    )
}
