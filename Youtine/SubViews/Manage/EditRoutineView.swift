//
//  ManageRoutine.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/21/25.
//

import SwiftUI

struct EditRoutineView: View {
    // MARK: Instance Variables
    @Binding var routineColor: Color
    @Binding var selectedCellIndex: Int?
    @Binding var start: String
    @Binding var selectedDays: [Int: String]
    @Binding var habits: [Habit]
    @Binding var showingCreateHabit: Bool
    @Binding var showingTimePicker: Bool
    
    @Binding var currentLabel: String
    @Binding var currentDescription: String
    @Binding var currentHabitID: UUID?
    
    var hasChanges: Bool
    
    @Environment(\.currentPage) var currentPage

    var body: some View {
        ZStack {
            if showingCreateHabit == true {
                CreateHabitView(
                    habits: $habits,
                    showingCreateHabit: $showingCreateHabit,
                    label: $currentLabel,
                    desc: $currentDescription,
                    id: $currentHabitID
                )
                .transition(.move(edge: .bottom))
            } else if showingTimePicker == true {
                TimePickerView(
                    showingTimePicker: $showingTimePicker,
                    start: $start
                )
                .transition(
                    .asymmetric(
                        insertion: .push(from: .trailing),
                        removal: .push(from: .leading)
                    )
                )
            } else {
                FormView(
                    routineColor: $routineColor,
                    selectedCellIndex: $selectedCellIndex,
                    start: $start,
                    selectedDays: $selectedDays,
                    habits: $habits,
                    showingCreateHabit: $showingCreateHabit,
                    showingTimePicker: $showingTimePicker,
                    currentLabel: $currentLabel,
                    currentDescription: $currentDescription,
                    currentHabitID: $currentHabitID,
                    hasChanges: hasChanges
                )
                .padding(.bottom, 20)
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: currentPage.wrappedValue)
        .animation(.easeInOut, value: showingCreateHabit)
        .animation(.easeInOut, value: showingTimePicker)
    }
}

#Preview {
    EditRoutineView(
        routineColor: .constant(Color.white),
        selectedCellIndex: .constant(0),
        start: .constant(testRoutines[0]!.start),
        selectedDays: .constant(Routine.decodeDays(testRoutines[0]!.daysJSON)),
        habits: .constant(testRoutines[0]!.habits),
        showingCreateHabit: .constant(false),
        showingTimePicker: .constant(false),
        currentLabel: .constant(""),
        currentDescription: .constant(""),
        currentHabitID: .constant(UUID()),
        hasChanges: false
    )
}
