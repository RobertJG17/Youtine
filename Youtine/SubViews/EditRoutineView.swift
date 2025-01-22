//
//  ManageRoutine.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/21/25.
//

import SwiftUI

struct EditRoutineView: View {
    // MARK: Instance Variables
    var width: CGFloat
    var height: CGFloat
    @Binding var selectedCellIndex: Int?
    @Binding var routines: [Youtine?]
    @Binding var start: String
    @Binding var selectedDays: [Int: String]
    @Binding var habits: [Habit]
    @Binding var showingRoutineInit: Bool
    @Binding var showingTimePicker: Bool
    
    @Environment(\.currentPage) var currentPage

    var body: some View {
        ZStack {
            if showingRoutineInit == true {
                HabitInitView(
                    width: width,
                    height: height,
                    habits: $habits,
                    showingRoutineInit: $showingRoutineInit
                )
                .transition(.move(edge: .bottom))
            } else if showingTimePicker == true {
                TimePickerView(
                    width: width,
                    height: height,
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
                    width: width,
                    height: height,
                    selectedCellIndex: $selectedCellIndex,
                    routines: $routines,
                    start: $start,
                    selectedDays: $selectedDays,
                    habits: $habits,
                    showingRoutineInit: $showingRoutineInit,
                    showingTimePicker: $showingTimePicker
                )
                .padding(.bottom, 20)
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: currentPage.wrappedValue)
        .animation(.easeInOut, value: showingRoutineInit)
        .animation(.easeInOut, value: showingTimePicker)
    }
}

#Preview {
    EditRoutineView(
        width: 402.0,
        height: 687.666666666667,
        selectedCellIndex: .constant(0),
        routines: .constant(testRoutines),
        start: .constant(testRoutines[0]!.start),
        selectedDays: .constant(Youtine.decodeDays(testRoutines[0]!.daysJSON)),
        habits: .constant(testRoutines[0]!.habits),
        showingRoutineInit: .constant(false),
        showingTimePicker: .constant(false))
}
