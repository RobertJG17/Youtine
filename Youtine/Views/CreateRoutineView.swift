//
//  CreateRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CreateRoutineView: View {
    // MARK: Instance Variables
    var width: CGFloat
    var height: CGFloat
    @Binding var selectedCellIndex: Int?
    @Binding var routines: [Youtine?]
    
    // MARK: Initial form state variables
    @State private var start: String = "8:00 AM"
    @State private var selectedDays: [Int: String] = [:]
    @State private var habits: [Habit] = []
    @State private var showingRoutineInit: Bool = false
    @State private var showingTimePicker: Bool = false
    
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
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .move(edge: .bottom)
                    )
                )
                
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
                .transition(
                    .asymmetric(
                        insertion: .scale,
                        removal: .scale
                    )
                )
            }
        }
        .animation(.easeInOut, value: currentPage.wrappedValue)
        .animation(.easeInOut, value: showingRoutineInit)
        .animation(.easeInOut, value: showingTimePicker)
    }
}

#Preview {
    CreateRoutineView(
        width: 402.0,
        height: 687.6666666,
        selectedCellIndex: .constant(0),
        routines: .constant(testRoutines)
    )
}
