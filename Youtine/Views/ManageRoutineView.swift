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
    
    @State var hasChanges: Bool = false
    
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
            // MARK: Initial values for EDITING a routine
            self.id = unwrappedRoutine.id
            self.routineColor = Color.from(description: unwrappedRoutine.borderColor)
            self.start = unwrappedRoutine.start
            self.selectedDays = Routine.decodeDays(unwrappedRoutine.daysJSON)
            self.habits = unwrappedRoutine.habits
        } else {
            // MARK: Initial values for CREATING a routine
            self.id = UUID()
            self.routineColor = getRoutineColor(index: selectedCellIndex.wrappedValue)
            self.start = "8:00 AM"
            self.selectedDays = [:]
            self.habits = []
        }
        
        self.routineTitle = getRoutineTitle(index: selectedCellIndex.wrappedValue)
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
            currentHabitID: $currentHabitID,
            hasChanges: hasChanges
        )
        .onChange(of: start) { _, nextValue in
            hasChanges = true
        }
        .onChange(of: selectedDays) { prevValue, nextValue in
            hasChanges = prevValue == nextValue
        }
//        .onChange(of: routineColor) { prevValue, nextValue in
//            hasChanges = prevValue == nextValue
//        }
//        .onChange(of: habits) { prevValue, nextValue in
//            hasChanges = prevValue == nextValue
//        }
        .onChange(of: hasChanges) { _, newVal in
            print("Has changes?: ", newVal)
        }
        .environment(\.handleFormSubmit, handleFormSubmit)
    }
}

#Preview {
    ManageRoutineView(
        routine: .constant(testRoutines[0]),
        selectedCellIndex: .constant(0)
    )
}
