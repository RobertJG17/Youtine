//
//  FormView.swift
//  Youtine
//
//  Created by Bobby Guerra on 1/18/25.
//

import SwiftUI

struct FormView: View {
    var index: Int
    var width: CGFloat
    var height: CGFloat
    @Binding var createRoutine: Bool
    @Binding var showingRoutineInit: Bool

    @State private var name: String = ""
    @State var start: String = "8:00 AM"
    @State private var selectedDays: [Int: String] = [:]
    @State private var habits: [Habit] = []
    @State private var showingTimePicker: Bool = false
    
    var body: some View {
        Form {
            Section(
                header: HStack {
                    Text("\(routineTitle)")
                        .font(.system(size: 35, weight: .ultraLight))
                    Spacer()
                    Button {
                        createRoutine.toggle()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                    }
                }
                .foregroundStyle(routineColor)
            ) {}

            Section(header: Text("Start")) {
                Button {
                    showingTimePicker.toggle()
                } label: {
                    Text(start)
                }
                .sheet(isPresented: $showingTimePicker, content: {
                    TimePickerView(
                        showingTimePicker: $showingTimePicker,
                        start: $start
                    )
                })
            }

            Section(header: Text("Days")) {
                DayPickerView(
                    width: width,
                    selectedDays: $selectedDays
                )
            }

            Section(header: HStack(alignment: .center) {
                HabitHeaderView(
                    showingRoutineInit: $showingRoutineInit
                )
            }) {
                HabitListView(
                    habits: $habits
                )
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

#Preview {
    FormView(
        index: 0,
        width: 402.0,
        height: 687.666667,
        createRoutine: .constant(true),
        showingRoutineInit: .constant(true)
    )
}
