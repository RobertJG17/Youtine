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
        
    @Environment(UIStore.self) var uiStore
    
    var body: some View {
        List($habits, id: \.id, editActions: .all) { todo in
            let label = todo.label
            let desc = todo.desc
        
            HStack(alignment: .center, spacing: 0) {
                HabitListDisclosureGroupView(
                    label: label.wrappedValue,
                    desc: desc.wrappedValue
                )
                
                Spacer()
                
                Divider()
                
                // TODO: Create edit pencil and use Tip Kit for swipe to delete action
                Button {
                    // MARK: Capture properties in state to initialize CreateHabitView
                    currentLabel = label.wrappedValue
                    currentDesc = desc.wrappedValue
                    currentHabitID = todo.id
                    
                    showingCreateHabit = true
                } label: {
                    Image(systemName: "pencil")
                        .frame(
                            width: uiStore.screenWidth*0.10,
                            height: uiStore.screenHeight*0.08,
                            alignment: .center
                        )
                        .padding(.leading, 15)
                }
                .contentShape(Rectangle())
                .background(Color.clear)
                .foregroundStyle(Color.white)
            }
            
            // !!!: Can't decide between this and default list row bg
            .listRowBackground(Color.clear)
        }
        .frame(
            width: uiStore.screenWidth*0.8
        )
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
