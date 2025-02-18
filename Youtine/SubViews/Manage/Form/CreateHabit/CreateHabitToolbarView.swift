//
//  CreateHabitToolbarView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/24/25.
//

import SwiftUI

struct CreateHabitToolbarView: View {
    @Binding var habits: [Habit]
    @Binding var showingCreateHabit: Bool
    @Binding var label: String
    @Binding var desc: String
    @Binding var id: UUID?
    
    func resetParams() {
        label = ""
        desc = ""
    }
    
    func update(index: Int) {
        // MARK: Access existing habit
        let habitToEdit = habits[index]
        
        // MARK: Adjust habit label & desc
        habitToEdit.label = label
        habitToEdit.desc = desc
    }
    
    func save() {
        // MARK: Create new Habit
        let newHabit = Habit(
            label: label,
            desc: desc
        )
        
        // MARK: Save new habit in memory
        habits.append(newHabit)
    }
    
    var body: some View {
        HStack {
            Button {
                resetParams()
                showingCreateHabit = false
            } label: {
                Image(systemName: "xmark")
            }
            .foregroundStyle(.white)
            
            Spacer()
            
            Button {
                if label != "" && desc != "" {
                    // ???: Check if habit exists in state
                    let index = habits.firstIndex { habit in habit.id == id }
                    
                    if let validIndex = index {
                        update(index: validIndex)
                    } else {
                        save()
                    }
                }
                resetParams()
                showingCreateHabit = false
            } label: {
                Text("Done")
            }
            .disabled(label == "" || desc == "")
        }
    }
}

#Preview {
    CreateHabitToolbarView(
        habits: .constant(testRoutines[0]!.habits),
        showingCreateHabit: .constant(false),
        label: .constant(""),
        desc: .constant(""),
        id: .constant(UUID())
    )
}
