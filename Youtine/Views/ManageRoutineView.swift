//
//  CreateRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ManageRoutineView: View {
    // MARK: Instance Variables
    @Binding var selectedCellIndex: Int?
    
    // MARK: Initial form state variables
    @State private var id: UUID
    @State private var routineTitle: String
    @State private var routineColor: Color
    @State private var start: String
    @State private var habits: [Habit]
    @State private var selectedDays: [Int: String]
    @State private var showingCreateHabit: Bool = false
    @State private var showingTimePicker: Bool = false
    /// ---
    @State private var currentLabel = ""
    @State private var currentDescription = ""
    @State private var currentHabitID: UUID?
    
    @Environment(\.writeRoutineToDisk) var writeRoutineToDisk
    
    // MARK: Submit form declared here to capture all needed state vars
    func handleFormSubmit() -> Void {
        do {
            if let validIndex = selectedCellIndex {
                try writeRoutineToDisk(
                    id,
                    validIndex,
                    start,
                    selectedDays,
                    routineColor,
                    habits
                )
            }
        } catch {
            print(error)
        }
    }

    init(
        routine: Binding<Routine?>,
        selectedCellIndex: Binding<Int?>
    ) {
        self._selectedCellIndex = selectedCellIndex

        // MARK: If routine == nil, the form will render with default values
        if let unwrappedRoutine = routine.wrappedValue {
            self.id = unwrappedRoutine.id
            self.routineColor = Color.from(description: unwrappedRoutine.borderColor)
            self.start = unwrappedRoutine.start
            self.selectedDays = Routine.decodeDays(unwrappedRoutine.daysJSON)
            self.habits = unwrappedRoutine.habits
        } else {
            self.id = UUID()
            self.routineColor = ManageRoutineView.getRoutineColor(
                index: selectedCellIndex.wrappedValue!
            )
            self.start = "8:00 AM"
            self.selectedDays = [:]
            self.habits = []
        }
        
        self.routineTitle = ManageRoutineView.getRoutineTitle(index: selectedCellIndex.wrappedValue)
    }
    
    var body: some View {
        EditRoutineView(
            routineColor: $routineColor,
            selectedCellIndex: $selectedCellIndex,
            start: $start,
            selectedDays: $selectedDays,
            habits: $habits,
            showingCreateHabit: $showingCreateHabit,
            showingTimePicker: $showingTimePicker,
            currentLabel: $currentLabel,
            currentDescription: $currentDescription,
            currentHabitID: $currentHabitID
        )
        .environment(\.handleFormSubmit, handleFormSubmit)
    }
}

#Preview {
    ManageRoutineView(
        routine: .constant(testRoutines[0]),
        selectedCellIndex: .constant(0)
    )
}
