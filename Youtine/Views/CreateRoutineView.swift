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
    var width: CGFloat
    var height: CGFloat
    @Binding var createRoutine: Bool

    // MARK:
    @State private var name: String = ""
    @State private var start: String = "8:00 AM"
    @State private var habits: [Habit] = []
    @State private var showingRoutineInit: Bool = false

    var body: some View {
        ZStack {
            if showingRoutineInit == false {
                FormView(
                    index: index,
                    width: width,
                    height: height,
                    createRoutine: $createRoutine,
                    showingRoutineInit: $showingRoutineInit
                )
                .transition(
                    .asymmetric(
                        insertion: .scale,
                        removal: .scale
                    )
                )
            } else {
                HabitInitView(
                    width: width,
                    height: height,
                    habits: $habits,
                    showingRoutineInit: $showingRoutineInit
                )
                .transition(
                    .asymmetric(
                        insertion: .scale,
                        removal: .scale
                    )
                )
            }
        }
        .animation(.easeInOut, value: showingRoutineInit)
    }
}

#Preview {
    CreateRoutineView(
        index: 0,
        width: 402.0,
        height: 687.6666666,
        createRoutine: .constant(true)
    )
}
