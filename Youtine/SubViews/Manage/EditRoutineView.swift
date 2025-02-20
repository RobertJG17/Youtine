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
    
    // MARK: These variables are set in HabitListView and accessed in CreateHabitView
    @State private var currentLabel = ""
    @State private var currentDescription = ""
    @State private var currentHabitID: UUID?
    
    // MARK: Initial Values we declare and then set in onAppear()
    @State var initialStart: String = ""
    @State var initialSelectedDays: [Int: String] = [:]
    @State var initialRoutineColor: Color = Color.white
    @State var initialHabits: [Habit] = []
    
    @State var hasChanges: Bool = false
    
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
                    hasChanges: $hasChanges
                )
                .padding(.bottom, 20)
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: currentPage.wrappedValue)
        .animation(.easeInOut, value: showingCreateHabit)
        .animation(.easeInOut, value: showingTimePicker)
        .onAppear {
            initialStart = start
            initialRoutineColor = routineColor
            initialSelectedDays = selectedDays
            initialHabits = habits
        }
        
        // MARK: These onChange modifiers compare the initial form values to changed values to determine whether or not to present confirmation dialogs in FormToolbarView
        .onChange(of: start) { _, newStart in
            hasChanges = initialStart != newStart
        }
        .onChange(of: routineColor) { _, newColor in
            hasChanges = initialRoutineColor != newColor
        }
        .onChange(of: selectedDays) { _, newSelectedDays in
            if (initialSelectedDays.count != newSelectedDays.count) {
                hasChanges = true
            } else {
                let keys = newSelectedDays.keys
                keys.forEach { key in
                    if (initialSelectedDays[key] != newSelectedDays[key]) {
                        hasChanges = true
                        return
                    }
                }
                
                hasChanges = false
            }
        }
        .onChange(of: habits) { _, newHabits in
            if (initialHabits.count != newHabits.count) {
                hasChanges = true
            } else {
                for (idx, habit) in newHabits.enumerated() {
                    if (
                        initialHabits[idx].label != habit.label ||
                        initialHabits[idx].desc != habit.desc
                    ) {
                        hasChanges = true
                        return
                    }
                }
                
                hasChanges = false
            }
        }
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
        showingTimePicker: .constant(false)
    )
}
