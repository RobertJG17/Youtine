//
//  CreateRoutineView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/17/25.
//

import SwiftUI

struct CreateRoutineView: View {
    // MARK: Instance Variables
    var index: Int
    @Binding var selectedCellIndex: Int?
    var width: CGFloat
    var height: CGFloat
    @Binding var createRoutine: Bool

    // MARK:
    @State private var name: String = ""
    @State private var start: String = "8:00 AM"
    @State private var habits: [Habit] = []
    @State private var showingRoutineInit: Bool = false
    @State private var showingTimePicker: Bool = false

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
                    index: index,
                    selectedCellIndex: $selectedCellIndex,
                    width: width,
                    height: height,
                    createRoutine: $createRoutine,
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
        .animation(.easeInOut, value: showingRoutineInit)
        .animation(.easeInOut, value: showingTimePicker)
    }
}

#Preview {
    CreateRoutineView(
        index: 0,
        selectedCellIndex: .constant(0),
        width: 402.0,
        height: 687.6666666,
        createRoutine: .constant(true)
    )
}
