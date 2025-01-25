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
    
    @Environment(\.screenWidth) var screenWidth
    @Environment(\.screenHeight) var screenHeight
    
    var body: some View {
        ScrollView {
            List($habits, id: \.id, editActions: .all) { todo in
                let label = todo.label.wrappedValue
                let desc = todo.desc.wrappedValue
            
                HStack {
                    VStack(alignment: .leading) {
                        Text(label)
                        Text(desc)
                            .font(.caption)
                            .fontWeight(.light)
                            .lineLimit(1) // Set the number of lines to display
                            .truncationMode(.tail) // Use ellipsis for overflow
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
            .frame(width: screenWidth.wrappedValue, height: screenHeight.wrappedValue/4.0)
        }
        .frame(width: screenWidth.wrappedValue, height: screenHeight.wrappedValue/4.0)
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
