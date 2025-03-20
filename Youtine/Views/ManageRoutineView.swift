//
//  ManageRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ManageRoutineView: View {
    // MARK: Initial form state variables
    @State private var id: UUID
    @State private var routineTitle: String
    @State private var routineColor: Color
    @State private var start: String
    @State private var habits: [Habit]
    @State private var selectedDays: [Int: String]
    @State private var showingCreateHabit: Bool = false
    @State private var showingTimePicker: Bool = false
    
    @Environment(UIStore.self) var uiStore
    @Environment(\.modelContext) var context
    
    var dataManagerService: DataManagerService {
        DataManagerService(context: context)
    }
    
    init(routine: Routine?, selectedCellIndex: Int?) {
        if let unwrappedRoutine = routine {
            // MARK: Initial values for EDITING a routine
            self.id = unwrappedRoutine.id
            self.routineColor = Color.from(description: unwrappedRoutine.color)
            self.start = unwrappedRoutine.start
            self.selectedDays = Routine.decodeDays(unwrappedRoutine.daysJSON)
            self.habits = unwrappedRoutine.habits
        } else {
            // MARK: Initial values for CREATING a routine
            self.id = UUID()
            self.routineColor = getRoutineColor(index: selectedCellIndex)
            self.start = getRoutineStartTime(index: selectedCellIndex)
            self.selectedDays = [:]
            self.habits = []
        }
        
        self.routineTitle = getRoutineTitle(index: selectedCellIndex)
    }
    
    // MARK: Submit form declared here to capture all needed state vars
    func handleFormSubmit() -> Void {
        if let validIndex = uiStore.selectedCellIndex {
            dataManagerService.saveRoutine(
                id: id,
                index: validIndex,
                start: start,
                days: selectedDays,
                color: routineColor,
                habits: habits
            )
        }
    }
    
    var body: some View {
        EditRoutineView(
            routineColor: $routineColor,
            start: $start,
            selectedDays: $selectedDays,
            habits: $habits,
            showingCreateHabit: $showingCreateHabit,
            showingTimePicker: $showingTimePicker
        )
        .environment(\.handleFormSubmit, handleFormSubmit)
    }
}

#Preview {
    ManageRoutineView(routine: testRoutines[0], selectedCellIndex: 0)
}
