//
//  CreateRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct ManageRoutineView: View {
    // MARK: Instance Variables
    var width: CGFloat
    var height: CGFloat
    @Binding var selectedCellIndex: Int?
    
    // MARK: Initial form state variables
    @State private var id: UUID
    @State private var routineTitle: String
    @State private var routineColor: Color
    @State private var start: String
    @State private var habits: [Habit]
    @State private var selectedDays: [Int: String]
    @State private var showingRoutineInit: Bool = false
    @State private var showingTimePicker: Bool = false
    
    @Environment(\.modelContext) var context
    @Environment(\.contextViewModel) var contextViewModel
    @Environment(\.writeRoutineToDisk) var writeRoutineToDisk
    
    // MARK: FORM FUNCTIONALITY
    func handleFormSubmit() -> Void {
        do {
            if let validIndex = selectedCellIndex {
                let newRoutine = buildRoutine(index: validIndex)
                try writeRoutineToDisk(newRoutine, contextViewModel)
            }
        } catch {
            print(error)
        }
        
    }
    
    func buildRoutine(index: Int) -> Youtine {
        let routine = Youtine(
            index: index,
            start: start,
            days: selectedDays,
            borderColor: routineColor,
            habits: habits
        )
        
        routine.habits.forEach({ habit in
            print("HABIT: ", habit.label)
        })
        
        // MARK: Set id for existing routines so fetchDescriptor in Data Manager save will capture saved instances
        routine.setID(id: id)
        return routine
    }

    init(
        width: CGFloat,
        height: CGFloat,
        routine: Binding<Youtine?>,
        selectedCellIndex: Binding<Int?>
    ) {
        self.width = width
        self.height = height
        self._selectedCellIndex = selectedCellIndex

        // MARK: If routine == nil, the form will render with default values
        if let unwrappedRoutine = routine.wrappedValue {
            self.id = unwrappedRoutine.id
            self.routineColor = Color.from(description: unwrappedRoutine.borderColor)
            self.start = unwrappedRoutine.start
            self.selectedDays = Youtine.decodeDays(unwrappedRoutine.daysJSON)
            self.habits = unwrappedRoutine.habits
        } else {
            print("In else")
            self.id = UUID()
            self.routineColor = ManageRoutineView.getRoutineColor(index: selectedCellIndex.wrappedValue!)
            self.start = "8:00 AM"
            self.selectedDays = [:]
            self.habits = []
        }
        
        self.routineTitle = ManageRoutineView.getRoutineTitle(index: selectedCellIndex.wrappedValue)
    }
    
    var body: some View {
        EditRoutineView(
            width: width,
            height: height,
            routineColor: $routineColor,
            selectedCellIndex: $selectedCellIndex,
            start: $start,
            selectedDays: $selectedDays,
            habits: $habits,
            showingRoutineInit: $showingRoutineInit,
            showingTimePicker: $showingTimePicker
        )
        .onAppear {
            print("ROUTINE: ", routineTitle)
        }
        .environment(\.handleFormSubmit, handleFormSubmit)
    }
}

#Preview {
    ManageRoutineView(
        width: 402.0,
        height: 687.6666666,
        routine: .constant(testRoutines[0]),
        selectedCellIndex: .constant(0)
    )
}
